'use strict'

$ = require('gulp-load-plugins')()
gulp = require('gulp')
webpack = require('webpack')
config = require('../config').webpack

gulp.task('bundle', (cb) ->
  started = false
  bundler = webpack(config)
  watch = require('../config').watch

  bundle = (error, stats) ->
    if error
      console.log error

    if ! started
      started = true
      return cb()

  if watch
    bundler.watch(200, bundle)
  else
    bundler.run(bundle)
)
