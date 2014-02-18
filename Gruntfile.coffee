module.exports = (grunt) ->
  # load plugins that provides tasks  
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-este'

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
          ]
          ext: '.js'
        }]

    esteDeps:
      all:
        options:
          outputFile: 'public/scripts/deps.js'
          prefix: '../../../../'
          root: [
            'bower_components/closure-library'
            'bower_components/este-library/este'
            'public/scripts'
          ]

    coffee2closure:
      app:
        files: '<%= coffee.app.files %>'
    
    watch:
      coffee:
        files: '<%= coffee.app.files[0].src %>' #'public/scripts/**/*.coffee' #
        tasks: ['coffee:app']
        options:
          livereload: true