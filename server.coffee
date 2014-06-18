koa = require 'koa'
response_time = require 'koa-response-time'
logger = require 'koa-logger'
router = require 'koa-router'
markdown = require 'koa-markdown'

app = koa()

app.use response_time()
app.use logger()
app.use router(app)
app.get '/', markdown baseUrl: '/', root: __dirname, indexName: 'Readme'
app.get '/object/:id', cache(expire: oneMonth), cacheImage(), getObject
app.get '/search/:term?*', cache(expire: oneDay), cacheImage(), getIds
app.get '/search', cache(expire: oneDay), getIds

app.listen process.env.PORT or 5000, ->
  console.log "[#{process.pid}] listening on :#{+@_connectionKey.split(':')[2]}"
