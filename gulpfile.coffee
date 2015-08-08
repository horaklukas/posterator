gulp = require 'gulp'
gutil = require 'gulp-util'
cjsx = require 'gulp-cjsx'
stylus = require 'gulp-stylus'
browserify = require 'browserify'
source = require 'vinyl-source-stream'
mocha = require 'gulp-mocha'
nib = require 'nib'
connect = require 'gulp-connect'
watch = require 'gulp-watch'

paths =
  cjsx:
    src: [
      'public/scripts/**/*.cjsx'
      'public/scripts/**/*.coffee'
    ]
    dest: 'public/scripts/'
  stylus:
    src: 'public/styles/**/*.styl'
    main: 'public/styles/index.styl'
    dest: 'public/styles/'
  build:
    bundle: 'posterator.js'
    dest: 'public/scripts'
  test:
    src: 'test/tests/**/*-test.coffee'

browserifyConfig =
  entries: ['./public/scripts/index.js']
  debug: true

mochaOptions =
  reporter: 'spec'
  globals: ['sinon', 'expect', 'mockery']
  bail: true

handleError = (err) ->
  gutil.log gutil.colors.red err
  @emit 'end'

gulp.task 'default', ['cjsx', 'stylus']

gulp.task 'cjsx', ->
  gulp.src(paths.cjsx.src)
    .pipe cjsx({bare: true}).on 'error', handleError
    .pipe gulp.dest(paths.cjsx.dest)
    #.pipe connect.reload()

gulp.task 'stylus', ->
  gulp.src(paths.stylus.main)
    .pipe stylus({compile: false, use:[nib()]}).on 'error', handleError
    .pipe gulp.dest(paths.stylus.dest)
    .pipe connect.reload()

gulp.task 'build', ['cjsx'], ->
  browserify(browserifyConfig)
    .bundle()
    .pipe source(paths.build.bundle)
    .pipe gulp.dest(paths.build.dest)

gulp.task 'test', ->
  require './test/test-assets'

  gulp.src([paths.test.src], {read: false})
    .pipe mocha(mochaOptions).on 'error', handleError

gulp.task 'connect', ->
  connect.server {
    root: 'public'
    livereload: true
  }

gulp.task 'watch', ['connect'], ->
  watch paths.cjsx.src, -> gulp.start ['cjsx', 'test']
  watch paths.stylus.src, -> gulp.start 'stylus'
  watch paths.test.src, -> gulp.start 'test'