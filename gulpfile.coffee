gulp = require 'gulp'
gutil = require 'gulp-util'
cjsx = require 'gulp-cjsx'
stylus = require 'gulp-stylus'
browserify = require 'browserify'
source = require 'vinyl-source-stream'
jasmine = require 'gulp-jasmine'
nib = require 'nib'
bootstrap = require 'bootstrap-styl'
connect = require 'gulp-connect'
watch = require 'gulp-watch'
SpecReporter = require 'jasmine-spec-reporter'
runSequence = require 'run-sequence'

paths =
  cjsx:
    src: 'public/scripts/**/*.@(coffee|cjsx)'
    dest: 'public/scripts/'
  js:
    src: 'public/scripts/**/*.js'
  stylus:
    src: 'public/styles/**/*.styl'
    main: 'public/styles/index.styl'
    dest: 'public/styles/'
  build:
    bundle: 'posterator.js'
    dest: 'public/scripts'
  test:
    src: 'test/tests/**/*-test.@(coffee|cjsx)'
    dest: 'test/tests/'
    js: 'test/tests/**/*-test.js'


handleError = (err) ->
  gutil.log gutil.colors.red err
  @emit 'end'

gulp.task 'default', ['cjsx', 'stylus', 'watch']

gulp.task 'cjsx', ->
  gulp.src(paths.cjsx.src)
    .pipe cjsx({bare: true}).on 'error', handleError
    .pipe gulp.dest(paths.cjsx.dest)
    #.pipe connect.reload()

gulp.task 'stylus', ->
  plugins = [nib(), bootstrap()]

  gulp.src(paths.stylus.main)
    .pipe stylus({compile: false, use: plugins}).on 'error', handleError
    .pipe gulp.dest(paths.stylus.dest)
    .pipe connect.reload()

browserifyConfig =
  entries: ['./public/scripts/index.js']
  debug: true

gulp.task 'build', ['cjsx'], ->
  browserify(browserifyConfig)
    .bundle()
    .pipe source(paths.build.bundle)
    .pipe gulp.dest(paths.build.dest)

gulp.task 'cjsx-test', ->
  gulp.src(paths.test.src)
  .pipe cjsx({bare: true}).on 'error', handleError
  .pipe gulp.dest(paths.test.dest)

specReporterConfig =
  displayStacktrace: 'none'
  displayFailuresSummary: true
  displayPendingSummary: true
  displaySuccessfulSpec: true
  displayFailedSpec: true
  displayPendingSpec: true
  displaySpecDuration: false
  displaySuiteNumber: false
  colors:
    pending: 'cyan'
  prefixes:
    pending: 'o '
  customProcessors: []

jasmineConfig =
  reporter: new SpecReporter(specReporterConfig)
  config:
    spec_dir: 'test'
    helpers: ['test-assets.js']

gulp.task 'test', ['cjsx-test'], ->
  gulp.src([paths.test.js])
  .pipe jasmine(jasmineConfig)

gulp.task 'connect', ->
  connect.server {
    root: 'public'
    livereload: true
  }

gulp.task 'watch', ['connect'], ->
  watch paths.cjsx.src, -> runSequence 'cjsx', 'test'
  watch paths.test.src, -> gulp.start 'test'
  watch paths.stylus.src, -> gulp.start 'stylus'