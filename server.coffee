koa = require 'koa'
response_time = require 'koa-response-time'
logger = require 'koa-logger'
router = require 'koa-router'
markdown = require 'koa-markdown'
body = require('koa-better-body')()

mongoose = require 'mongoose'
Schema = mongoose.Schema

noteSchema = new Schema(
  note: Number
  octave: Number
  confidence: Number
  diffidence: Number
  duration: Number
  station: String
  city: String
  country: String
  lat: Number
  long: Number
  file: Buffer
)

app = koa()

app.use response_time()
app.use logger()
app.use router(app)
app.get '/', markdown baseUrl: '/', root: __dirname, indexName: 'Readme'
app.get '/note', body, -->
  @body = @request.body
app.post '/note', body, -->
  @body = @request.body

app.listen process.env.PORT or 5000, ->
  console.log "[#{process.pid}] listening on :#{+@_connectionKey.split(':')[2]}"
