process.env.NODE_ENV = process.env.NODE_ENV || 'development'
const { CleanWebpackPlugin } = require('clean-webpack-plugin');

const environment = require('./environment')

const webpackConfig = {
  plugins: [
    new CleanWebpackPlugin(),
  ],
};
module.exports = environment.toWebpackConfig()
