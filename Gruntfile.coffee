module.exports = (grunt) ->
  # load plugins that provides tasks  
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-coffee-react'
  
  grunt.loadNpmTasks 'grunt-browserify'

  # tasks aliases
  grunt.registerTask 'deps', ['esteDeps']

  grunt.initConfig
    coffee:
      options:
        compile: true
        bare: true

      app:
        files: [{
          expand: true,
          src: [
            './**/*.coffee'
            '!node_modules/'
          ]
          ext: '.js'
        }]

    cjsx:
      app:
        options:
          bare: true
        files: [{
          expand: true,
          src: ['./**/*.cjsx']
          ext: '.js'
        }]

    browserify:
      dist:
        files:
          'public/scripts/bundle.js': ['./public/scripts/index.js'],

    watch:
      coffee:
        files: '<%= coffee.app.files[0].src %>' #'public/scripts/**/*.coffee' #
        tasks: ['coffee:app']

      cjsx:
        files: '<%= cjsx.app.files[0].src %>' #'public/scripts/**/*.coffee' #
        tasks: ['cjsx']

      browserify:
        files: ['public/scripts/**/*.js','!public/scripts/bundle.js']
        tasks: ['browserify']
        livereload: true
