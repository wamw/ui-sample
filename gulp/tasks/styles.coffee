'use strict'

$ = require('gulp-load-plugins')()
gulp = require('gulp')
handleErrors = require('../util/handle-errors')
config = require('../config').styles
RELEASE = require('../config').RELEASE

gulp.task('styles', ->
  gulp.src(config.src)
    # Ready for create sourcemaps
    .pipe($.sourcemaps.init())
    # Compile sass to css
    .pipe($.sass(config.settings))
    # Handle error
    .on('error', handleErrors)
    # if mode is production then write sourcemaps
    .pipe($.if(! RELEASE, $.sourcemaps.write()))
    # Auto prefixer
    .pipe($.autoprefixer({ browsers: ['last 4 version'] }))
    # Makes your code beautiful
    .pipe($.csscomb())
    # if mode is production then minify
    .pipe($.if(RELEASE, $.minifyCss()))
    .pipe(gulp.dest(config.dest))
    .pipe($.size({ title: 'styles' }))
  # return stream
)
