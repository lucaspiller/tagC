module.exports = function(grunt) {
  grunt.initConfig({
    pkg: grunt.file.readJSON('package.json'),
    coffee: {
      compile: {
        files: {
          'lib/tagc.js': ['src/tagc.coffee', 'src/**.coffee', 'src/*/*.coffee']
        }
      }
    },
    watch: {
      compile: {
        files: ['src/*.coffee', 'src/*/*.coffee'],
        tasks: ['coffee']
      },
      specs: {
        files: ['spec/*.coffee', 'spec/*/*.coffee'],
        tasks: ['exec:spec']
      },
    },
    exec: {
      spec: {
        command: 'node_modules/jasmine-node/bin/jasmine-node --coffee --color spec'
      }
    }
  });

  grunt.loadNpmTasks('grunt-contrib-watch');
  grunt.loadNpmTasks('grunt-contrib-coffee');
  grunt.loadNpmTasks('grunt-exec');

  // Default task(s).
  grunt.registerTask('default', ['coffee']);
};
