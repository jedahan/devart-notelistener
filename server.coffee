{name} = require './package.json'
koa = require 'koa'
response_time = require 'koa-response-time'
logger = require 'koa-logger'
router = require 'koa-router'
body = require('koa-better-body')()

mask = require 'koa-json-mask'

monk = require 'monk'
wrap = require 'co-monk'
db = monk 'localhost/test'
notes = wrap db.get 'notes'

app = koa()

app.use response_time()
app.use logger()
app.use mask()
app.use router(app)

unixtime = -> Math.round((new Date).getTime() / 1000)

app.get '/timestamp', -->
  @body = unixtime()

app.get '/notes', -->
  since = + @request.query?.since
  limit = + @request.query?.limit
  @body = yield notes.find({timestamp: {$gte: since}}, {limit})

app.post '/', body, -->
  note = @request.body
  note.timestamp = unixtime()
  @body = yield notes.insert note

app.listen process.env.PORT or 5000, ->
  console.log "[#{process.pid}] #{name} listening on :#{+@_connectionKey.split(':')[2]}"
