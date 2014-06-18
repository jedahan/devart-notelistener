devart server
=============

Setup
-----

Install [n](github.com/visionmedia/n), [node 0.11.x](nodejs.org), and [koa](koajs.org) + middleware.

```
npm install -g n && n latest
npm install
```

Make sure /data/db exists and is writeable by your user:

```
mkdir -p /data/db
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

For example, try `curl -X POST -F "file=@yellow_cactus.mp3;type=audio/mpeg" -F note=0 -F octave=1 -F confidence=0.778 -F diffidence=0.44 -F duration="12.22" -F station="the psychadelicatessan" -F city="stony brook, new york" -F country="merica" -F lat=-73.23 -F lon=38.14 localhost:5000/note`

### `GET /note`

Get a list of all the possible notes that match whatever filters you give it.

For example, try `curl -X GET -d lon=38.14`

Todo
----

- sort by latest notes added
- add timestamps and ability to filter by timestamps
- update json-mask to latest stable version
