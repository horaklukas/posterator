gulp = require 'gulp'
gutil = require 'gulp-util'
coffee = require 'gulp-coffee'
cjsx = require 'gulp-cjsx'
browserify = require 'gulp-browserify'
rename = require 'gulp-rename'
connect = require 'gulp-connect'

paths =
	coffee: './public/scripts/**/*.coffee'
	cjsx: './public/scripts/**/*.cjsx'
	scripts: './public/scripts'

handleError = (err) ->
	gutil.log gutil.colors.red('Error:'), err
	@end?()

gulp.task 'coffee', ->
	gulp.src(paths.coffee)
		.pipe(coffee({bare: true})).on('error', handleError)
		.pipe gulp.dest(paths.scripts)

gulp.task 'cjsx', ->
	gulp.src(paths.cjsx)
		.pipe(cjsx({bare: true})).on('error', handleError)
		.pipe gulp.dest(paths.scripts)

gulp.task 'browserify', ->
	gulp.src('./public/scripts/index.js')
		.pipe(browserify())
		.pipe(rename('bundle.js'))
		.pipe(gulp.dest(paths.scripts))
		.pipe(connect.reload())

gulp.task 'default', ['coffee', 'cjsx', 'browserify']

gulp.task 'connect', ->
  connect.server {
    root: 'public/scripts'
    livereload: true
  }

gulp.task 'watch', ['connect'], ->
	gulp.watch paths.coffee, ['coffee']
	gulp.watch paths.cjsx, ['cjsx']
	gulp.watch(
		['./public/scripts/**/*.js','!./public/scripts/bundle.js']
		['browserify']
	)
