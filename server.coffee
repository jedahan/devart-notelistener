koa = require 'koa'
response_time = require 'koa-response-time'
logger = require 'koa-logger'
router = require 'koa-router'
markdown = require 'koa-markdown'
body = require('koa-better-body')()

monk = require 'monk'
wrap = require 'co-monk'
db = monk 'localhost/test'
notes = wrap db.get 'notes'

app = koa()

app.use response_time()
app.use logger()
app.use router(app)
app.get '/', markdown baseUrl: '/', root: __dirname, indexName: 'Readme'
app.get '/note', body, -->
  @body = yield notes.find @request.body

app.post '/note', body, -->
  # TODO: save mp3 from body to file, and place filename into record
  @body = yield notes.insert @request.body

app.listen process.env.PORT or 5000, ->
  console.log "[#{process.pid}] listening on :#{+@_connectionKey.split(':')[2]}"
