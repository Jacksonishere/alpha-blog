const { environment } = require('@rails/webpacker')

//required for bootsrap, and it says to read in jquery and popper extensions and to be able to understand and use them.
const webpack = require("webpack")

environment.plugins.append("Provide", new webpack.ProvidePlugin({
    $: 'jquery',
    jQuery: 'jquery',
    Popper: ['popper.js', 'default']
}))


module.exports = environment
