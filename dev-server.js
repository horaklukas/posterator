// Creates a hot reloading development environment

const path = require('path');
const express = require('express');
const webpack = require('webpack');
const lodash = require('lodash');
const webpackDevMiddleware = require('webpack-dev-middleware');
const webpackHotMiddleware = require('webpack-hot-middleware');
const DashboardPlugin = require('webpack-dashboard/plugin');
const config = require('./config/webpack.config.development');

const app = express();
const compiler = webpack(config);

// Apply CLI dashboard for your webpack dev server
compiler.apply(new DashboardPlugin());

const host = process.env.HOST || 'localhost';
const port = process.env.PORT || 3000;

function log() {
  arguments[0] = '\nWebpack: ' + arguments[0];
  console.log.apply(console, arguments);
}

app.use(webpackDevMiddleware(compiler, {
  noInfo: true,
  publicPath: config.output.publicPath,
  stats: {
    colors: true
  },
  historyApiFallback: true
}));

app.use(webpackHotMiddleware(compiler));

const POSTERS_DATA_PATH = 'src/client/assets/data/posters';
const USER_DATA_PATH = 'src/client/assets/data/userData';

var posters = require(`./${POSTERS_DATA_PATH}/posters-meta.json`);
var titles = require(`./${USER_DATA_PATH}/titles.json`);
lodash.forEach(posters, (poster) => poster.url = `/poster/${poster.url}` );

app.use('/poster', express.static(path.join(__dirname, POSTERS_DATA_PATH)));
app.get('/backend/*', (req, res) => {
  
  if (/get-data\.php$/.test(req.path)) {
    switch (req.query.type) {
      case 'posters':
        res.json(posters);
        break;

      case 'titles':
        let posterId = req.query.poster;

        if (!posterId) { 
          res.send(403, 'Poster id not defined.');
          return 
        }

        if (titles[posterId]) {
          res.json(titles[posterId]);
        } else {
          res.json(titles);
          //res.send(500, 'Poster titles not found.');
        }
        break;

      default:
        res.send(403)
    }
  } else {
    res.send(404);
  }

});

app.get('*', (req, res) => {
  res.sendFile(path.join(__dirname, './src/client/assets/index.html'));
});

app.listen(port, host, (err) => {
  if (err) {
    log(err);
    return;
  }

  log('🚧  App is listening at http://%s:%s', host, port);
});
