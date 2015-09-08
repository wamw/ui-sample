'use strict'

gulp = require('gulp')
rimraf = require('rimraf')
config = require('../config').markup

gulp.task('clean', (cb) ->
  rimraf(config.dest, cb)
)
