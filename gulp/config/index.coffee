'use strict'

webpack = require('webpack')
argv = require('minimist')(process.argv.slice(2))

# Settings
RELEASE = !! argv.release
AUTOPREFIXER_BROWSERS = [
  'ie >= 10'
  'ie_mob >= 10'
  'ff >= 30'
  'chrome >= 34'
  'safari >= 7'
  'opera >= 23'
  'ios >= 7'
  'android >= 4.4'
  'bb >= 10'
]
AUTOPREFIXER_LOADER = do (AUTOPREFIXER_BROWSERS) ->
  browsers = AUTOPREFIXER_BROWSERS.map (i) ->
    '"' + i + '"'
  .join(', ')
  return "autoprefixer-loader?{browsers:['#{browsers}'']}"



CONF = {
  src: {
    html: 'src/**/*.html'
    style: 'src/assets/scss/**/*.{sass,scss}'
    script: 'src/assets/coffee/**/*.coffee'
    static: 'src/assets/static/**/*'
  }
  dest: {
    html: './dist'
    style: './dist/css'
    script: './dist/js'
    static: './dist'
  }
}

WEBPACK_CONF = {
  entry: './src/assets/coffee/index.coffee'
  output: {
    path: CONF.dest.script
    publicPath: './'
    sourcePrefix: '  '
    filename: 'app.js'
  }
  externals: {
    'bluebird': 'Promise'
  }
  target: 'web'
  cache: ! RELEASE
  debug: ! RELEASE
  devtool: if RELEASE then false else '#source-map'
  # devtool: if RELEASE then false else '#inline-source-map'
  # devtool: if RELEASE then false else '#eval'
  stats: {
    colors: true
    reasons: ! RELEASE
  }
  plugins: [
    new webpack.optimize.OccurenceOrderPlugin()
  ].concat(if ! RELEASE then [] else [
    new webpack.optimize.DedupePlugin()
    new webpack.optimize.UglifyJsPlugin()
    new webpack.optimize.AggressiveMergingPlugin()
  ])
  resolve: {
    extensions: ['', '.js', '.jsx', '.coffee', '.cjsx']
  },
  module: {
    preLoaders: [
      {
        test: /\.js$/
        exclude: /node_modules/
        loader: 'eslint-loader'
      }
    ]
    loaders: [
      {
        test: /\.coffee?$/
        loader: 'coffee-loader'
      }
    ]
  }
}

module.exports = {
  RELEASE: RELEASE
  watch: false

  browserSync: {
    logPrefix: 'BS'
    server: {
      baseDir: CONF.dest.html
    }
  }

  webpack: WEBPACK_CONF

  markup: {
    src: CONF.src.html
    dest: CONF.dest.html
  }
  styles: {
    src: CONF.src.style
    dest: CONF.dest.style
  }
  script: {
    src: CONF.src.script
    dest: CONF.dest.script
  }
  static: {
    src: CONF.src.static
    dest: CONF.dest.static
  }

  # EJS variables
  variables: {
    js: '/js',
    css: '/css',
    images: '/images',
  }
}