'use strict'

gulp = require('gulp')
browserSync = require('browser-sync').get('talkform')
config = require('../config')

gulp.task('watch', ['browserSync'], ->
  gulp.watch(config.markup.src, ['markup']).on('change', browserSync.reload)
  gulp.watch(config.styles.src, ['styles']).on('change', browserSync.reload)
  gulp.watch(config.script.src, ['bundle']).on('change', browserSync.reload)
  gulp.watch(config.static.src, ['static']).on('change', browserSync.reload)
)
