gulp = require 'gulp'
gutil = require 'gulp-util'
coffee = require 'gulp-coffee'
cjsx = require 'gulp-cjsx'
browserify = require 'gulp-browserify'
rename = require 'gulp-rename'
connect = require 'gulp-connect'
stylus = require 'gulp-stylus'
nib = require 'nib'

paths =
	coffee: './public/scripts/**/*.coffee'
	cjsx: './public/scripts/**/*.cjsx'
	scripts: './public/scripts'
	styles: './public/styles/**/*.styl'

handleError = (err) ->
	gutil.log gutil.colors.red('Error:'), err
	@end?()

gulp.task 'coffee', ->
	gulp.src(paths.coffee)
		.pipe(coffee({bare: true}).on('error', handleError))
		.pipe gulp.dest(paths.scripts)

gulp.task 'cjsx', ->
	gulp.src(paths.cjsx)
		.pipe(cjsx({bare: true}).on('error', handleError))
		.pipe gulp.dest(paths.scripts)

gulp.task 'stylus', ->
	gulp.src('./public/styles/main.styl')
		.pipe(stylus({compile: true, use: [nib()]}).on('error', handleError))
		.pipe(gulp.dest('./public/styles'))
		.pipe(connect.reload())

gulp.task 'browserify', ->
	gulp.src('./public/scripts/index.js')
		.pipe(browserify())
		.pipe(rename('bundle.js'))
		.pipe(gulp.dest(paths.scripts))
		.pipe(connect.reload())

gulp.task 'default', ['coffee', 'cjsx', 'browserify']

gulp.task 'connect', ->
  connect.server {
    root: 'public'
    livereload: true
  }

gulp.task 'watch', ['connect'], ->
	gulp.watch paths.coffee, ['coffee']
	gulp.watch paths.cjsx, ['cjsx']
	gulp.watch(
		['./public/scripts/**/*.js','!./public/scripts/bundle.js']
		['browserify']
	)
	gulp.watch paths.styles, ['stylus']
