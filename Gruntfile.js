module.exports = function(grunt){
	
  // Project configuration.
  grunt.initConfig({
    jshint: {
      files: ['Gruntfile.js', 'WebContent/**/*.js' ],
      options: {
        globals: {
          jQuery: true
        }
      }
    },

    watch: {
      files: ['Gruntfile.js','WebContent/**/*.js'],
      tasks: ['jshint']
    },

    wiredep: {
      task: {
        src: [
          'WebContent/**/UserList.jsp'  // .html support...
        ]
      }
    },

    includeSource: {
      options: {
        basePath: 'WebContent',
        baseUrl: '',
      },

      myTarget: {
        files: {
          'WebContent/WEB-INF/views/insertform.jsp':'WebContent/WEB-INF/views/insertform.jsp'
        }
      }
    },

    cssmin:{
      minify:{
        expand: true,
        cwd: 'public/css/',
        src: ['*.css', '!Nwagon.css'],
        dest: 'public/build/css',
        ext: '.min.css'
      },
    
      options:{
        keepSpecialComments: 0
      }
    }
 
  });


 // Load plugins used by this task gruntfile
  grunt.loadNpmTasks('grunt-contrib-jshint');
  grunt.loadNpmTasks('grunt-contrib-watch');
  grunt.loadNpmTasks('grunt-wiredep');
  grunt.loadNpmTasks('grunt-include-source');
  grunt.loadNpmTasks('grunt-contrib-cssmin');

  // Task definitions
  grunt.registerTask('default', ['jshint','watch','cssmin']);
	
	
};
