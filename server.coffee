{name} = require './package.json'
koa = require 'koa'
response_time = require 'koa-response-time'
logger = require 'koa-logger'
router = require 'koa-router'
markdown = require 'koa-markdown'
body = require('koa-better-body')()

mask = require 'json-mask'

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
  @body = yield notes.find({timestamp: {$gt: + @request.body?.since or 0}}).sort({timestamp: -1})

app.post '/note', body, -->
  note = @request.body.fields
  note.file = mask @request.body.files?.file, 'size,path'
  @body = yield notes.insert note

app.listen process.env.PORT or 5000, ->
  console.log "[#{process.pid}] #{name} listening on :#{+@_connectionKey.split(':')[2]}"
  registerNotificationChannel name

requestNotificationChannel = (id) ->
  bucket = "notesu"
  url = "https://www.googleapis.com/storage/v1beta2/b/#{bucket}/o/watch?alt=json"
  headers =
    Authorization: "Bearer #{OAuthToken}"
  json =
    token: client_token # how do I get this?
    type: 'web_hook'
    id: id
    address: "https://notelistener.dhcp.io:5000/note" # how do I get this?

  request.post {url,headers,json}, (err, res, body) ->
    console.log err or body
