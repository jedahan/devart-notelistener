{name} = require './package.json'
koa = require 'koa'
response_time = require 'koa-response-time'
logger = require 'koa-logger'
router = require 'koa-router'
body = require('koa-better-body')()

monk = require 'monk'
wrap = require 'co-monk'
db = monk 'localhost/test'
notes = wrap db.get 'notes'

app = koa()

app.use response_time()
app.use logger()
app.use router(app)

app.get '/notes', -->
  console.log since = @request.query?.since
  @body = yield notes.find()
  #{updated: {$gt: since}}).sort({updated: -1})

app.post '/', body, -->
  @body = yield notes.insert @request.body

app.listen process.env.PORT or 5000, ->
  console.log "[#{process.pid}] #{name} listening on :#{+@_connectionKey.split(':')[2]}"
