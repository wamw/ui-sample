'use strict'

gulp = require('gulp')
config = require('../config').markup
ejs = require('gulp-ejs')
plumber = require('gulp-plumber')
browserSync = require('browser-sync')
{variables} = require('../config')

gulp.task('markup', ->
  return gulp.src(config.src)
    .pipe(plumber())
    .pipe(ejs(variables))
    .pipe(gulp.dest(config.dest))
)
