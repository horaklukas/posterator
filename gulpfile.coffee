gulp = require 'gulp'
gutil = require 'gulp-util'
coffee = require 'gulp-coffee'
cjsx = require 'gulp-cjsx'
browserify = require 'gulp-browserify'
rename = require 'gulp-rename'

paths =
	coffee: './public/scripts/**/*.coffee'
	cjsx: './public/scripts/**/*.cjsx'
	scripts: './public/scripts'

gulp.task 'coffee', ->
	gulp.src(paths.coffee)
		.pipe(coffee({bare: true})).on('error', gutil.log)
		.pipe gulp.dest(paths.scripts)

gulp.task 'cjsx', ->
	gulp.src(paths.cjsx)
		.pipe(cjsx({bare: true})).on('error', gutil.log)
		.pipe gulp.dest(paths.scripts)

gulp.task 'browserify', ->
	gulp.src('./public/scripts/index.js')
		.pipe(browserify())
		.pipe(rename('bundle.js'))
		.pipe gulp.dest(paths.scripts)

gulp.task 'watch', ->
	gulp.watch paths.coffee, ['coffee']
	gulp.watch paths.cjsx, ['cjsx']
	gulp.watch( 
		['./public/scripts/**/*.js','!./public/scripts/bundle.js']
		['browserify']
	)
