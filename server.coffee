{name} = require './package.json'
koa = require 'koa'
response_time = require 'koa-response-time'
logger = require 'koa-logger'
router = require 'koa-router'
markdown = require 'koa-markdown'
body = require('koa-better-body')()
https = require 'https'
serve = require 'koa-static'

monk = require 'monk'
wrap = require 'co-monk'
db = monk 'localhost/test'
notes = wrap db.get 'notes'

app = koa()

app.use response_time()
app.use logger()
app.use router(app)
app.use serve 'public'

app.get '/', markdown baseUrl: '/', root: __dirname, indexName: 'Readme'

app.get '/note', body, -->
  @body = yield notes.find({timestamp: {$gt: + @request.body?.since or 0}}).sort({timestamp: -1})

app.post '/note', body, -->
  console.log @request
  note = @request.body.fields
  @body = yield notes.insert note

https.createServer(app.callback()).listen(443)

app.listen process.env.PORT or 5000, ->
  console.log "[#{process.pid}] #{name} listening on :#{+@_connectionKey.split(':')[2]}"
