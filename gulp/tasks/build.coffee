'use strict'

gulp = require('gulp')
runSequence = require('run-sequence')

gulp.task('build', ['clean'], (cb) ->
  runSequence(
    'markup',
    'styles',
    'bundle',
    'static',
    cb
  )
)