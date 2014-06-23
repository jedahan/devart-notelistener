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
  since = @request.query?.since
  @body = yield notes.find({timestamp: {$gte: new Date(since)}})

app.post '/', body, -->
  note = @request.body
  note.timestamp = new Date()
  @body = yield notes.insert note

app.listen process.env.PORT or 5000, ->
  console.log "[#{process.pid}] #{name} listening on :#{+@_connectionKey.split(':')[2]}"
