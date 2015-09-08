'use strict'

gulp = require('gulp')
config = require('../config').static

gulp.task('static', ->
  return gulp.src(config.src)
    .pipe(gulp.dest(config.dest))
)
