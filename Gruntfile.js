"use strict"; 

module.exports = function( grunt ) {

	require("time-grunt")(grunt);
	require("load-grunt-tasks")(grunt);

	grunt.initConfig({

		autoprefixer: {
			app: {
				expand: true,
				flatten: true,
				src: "app/styles/*.css",
				dest: "app/styles/"
			}
		},

		browserSync: {
			bsFiles: [
				"app/scripts/site/**",
				"app/styles/*.css",
				"app/*.html"
			],
			options: {
				watchTask: true,
				ghostMode: false,
				server: {
					baseDir: "app"
				}
			}
		},

		coffee: {
			dev: {
				options: {
					bare: true,
					sourceMap: true
				},
				expand: true,
				cwd: "src/coffee/",
				src: [ "**/*.coffee" ],
				dest: "app/scripts",
				ext: ".js"
			}
		},

		compass: {
			dev: {
				options: {
					sassDir: "src/sass",
					extensionsDir: "src/sass/extensions",
					cssDir: "app/styles",
					imagesDir: "app/images",
					relativeAssets: true,
					force: true
				}
			}
		},

		concat: {
			options: {
				stripBanners: true
			},
			home: {
				src: [ "app/scripts/site.js" ],
				dest: "app/scripts/site.js"
			}
		},

		copy: {
			app: {
				expand: true,
				cwd: "src/",
				src: [
					"fonts/**",
					"images/**",
					"mat/**",
					"obj/**"
				],
				dest: "app"
			},
			dist: {
				expand: true,
				cwd: "app/",
				src: [
					"fonts/**",
					"images/**",
					"mat/**",
					"obj/**",
					"styles/**",

					// can't be compiled with require for some reason?
					"scripts/vendor/cannon.js/build/cannon.min.js"
				],
				dest: "dist"
			}
		},

		cssmin: {
			dist: {
				files: {
					"dist/styles/main.css": [ "dist/styles/main.css" ]
				}
			}
		},

		htmlmin: {
			dist: {
				options: {
					collapseWhitespace: true,
					minifyJS: true,
					minifyCSS: true
				},
				files: {
					"dist/index.html": "app/index.html"
				}
			}
		},

		"html-prettyprinter": {
			main: {
				src: "app/index.html",
				dest: "app/index.html"
			}
		},

		mustache_render: {
			options: {
				directory: "src/mustache"
			},
			build: {
				data: "src/json/main.json",
				template: "src/mustache/main.mustache",
				dest: "app/index.html"
			}
		},

		requirejs: {
			dist: {
				options: {
					name: "main",
					out: "dist/scripts/main.js",
					optimize : "uglify2",
					mainConfigFile: "app/scripts/main.js",
					baseUrl: "app/scripts",
					include: [ "requirejs" ]
				}
			}
		},

		targethtml: {
			dev: {
				files: {
					"app/index.html": "app/index.html"
				}
			},
			dist: {
				files: {
					"dist/index.html": "dist/index.html"
				}
			}
		},

		watch: {
			compass: {
				files: [ "src/sass/**" ],
				tasks: [ "compass" , "autoprefixer" ],
				options: {
					debounceDelay: 200
				}
			},
			coffee: {
				files: [ "src/coffee/**" , "src/models/**" ],
				tasks: "coffee",
				options: {
					debounceDelay: 200
				}
			},
			mustache: {
				files: [ "src/mustache/**" ],
				tasks: ["mustache_render","targethtml:dev","html-prettyprinter"],
				options: {
					debounceDelay: 200
				}
			},
			json: {
				files: [ "src/json/**" ],
				tasks: ["mustache_render","targethtml:dev","html-prettyprinter"],
				options: {
					debounceDelay: 200
				}
			}
		}

	});

	// Build
	grunt.registerTask( "build", [
		"mustache_render",
		"html-prettyprinter",
		"compass",
		"autoprefixer:app",
		"coffee:dev",
		"copy:app",
		"copy:dist",
		"cssmin",
		"htmlmin",
		"requirejs",
		"targethtml"
	]);

	// Prep the dev environment for watching, or run this directly to
	// update it a single time
	grunt.registerTask( "devupdate", [
		"copy:app",
		"compass",
		"autoprefixer:app",
		"coffee:dev",
		"mustache_render",
		"html-prettyprinter",
		"targethtml"
	]);

	// Update dev environment, and start watch
	grunt.registerTask( "start", [
		"devupdate",
		"browserSync",
		"watch"
	]);

	grunt.registerTask( "default", [ "build" ] );
};