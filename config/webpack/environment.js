const { environment } = require('@rails/webpacker')
const { VueLoaderPlugin } = require('vue-loader')
const vue = require('./loaders/vue')

environment.plugins.prepend('VueLoaderPlugin', new VueLoaderPlugin())
environment.loaders.prepend('vue', vue)
environment.config.resolve.alias = {'vue$': 'vue/dist/vue.esm.js' }
// jQueryとBootstapのJSを使えるように
const webpack = require('webpack')
environment.plugins.prepend(
  'Provide',
  new webpack.ProvidePlugin({
    $: 'jquery',
    jQuery: 'jquery',
    Popper: 'popper.js'
  })
)
module.exports = environment

// const webpack = require('webpack')
// environment.plugins.append('Provide',new webpack.ProvidePlugin({
//   $: 'jquery',
//   jQuery: 'jquery',
//   Popper: ['popper.js', 'default']
// }))

// module.exports = environment
