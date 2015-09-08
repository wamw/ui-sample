'use strict'

gulp = require('gulp')
browserSync = require('browser-sync').create('talkform')
config = require('../config').browserSync

gulp.task('browserSync', (cb) ->
  browserSync.init(config, cb)

  process.on('exit', ->
    browserSync.exit()
  )
)
