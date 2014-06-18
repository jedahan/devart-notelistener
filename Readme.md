devart server
=============

Setup
-----

Install [n](github.com/visionmedia/n), [node 0.11.x](nodejs.org), and [koa](koajs.org) + middleware.

```
npm install -g n && n latest
npm install
```

Running
-------

Start running the server with `npm start`. Make sure mongod is running somewhere. Or, when developing you can use `foreman start` if you have installed [foreman](). You can now view this readme with `open http://localhost:5000/`.

Using
-----

### `GET /`

This readme!

### `POST /note`

Add a new record to the database with the following data:

```
{  note: int
   octave: int
   confidence: float
   diffidence: float
   duration: float
   station: string
   city: string
   country: string
   lat: float
   long: float
   file: binary mp3 file
}
```

For example, try `curl -F "file=@myfile.mp3;type=audio/mpeg" -H "Content-Type: application/json" -d '{"note":0,"octave":1,"confidence":0.778,"diffidence":0.44,"duration":12.22,"station":"the psychadelicatessan","city":"stony brook, new york","country":"merica","lat":-73.23,"lon":38.14}'`

### `GET /note?[note=int]&[octave=int]&[limit=int]`

Get a list of all the possible notes that match note and octave, up to `limit` results. This will sort by the latest notes.
