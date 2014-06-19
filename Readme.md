devart server
=============

Setup
-----

Install node.js [node](nodejs.org)
```
sudo apt-get install build-essential
wget http://nodejs.org/dist/v0.10.29/node-v0.10.29.tar.gz
tar xf node-v0.10.29.tar.gz
cd node-v0.10.29
./configure
make
sudo make install
```

Install dependencies
```
sudo npm install -g n  # Install [n](github.com/visionmedia/n)
n latest          # Get and switch to the latest 0.11.x series of node.js, for koa
npm install       # Install latest versions of node modules for app
sudo apt-get install mongodb #install mongodb
```

Running
-------

Start running the server with `npm start`. Make sure mongod is running somewhere. Or, when developing you can use `foreman start` if you have installed [foreman](https://github.com/ddollar/foreman). You can now view this readme with `open https://localhost:5000/`.

Using
-----

### `GET /`

This readme!

### `POST /note`

Web hook for file change notifications from google cloud storage, expects

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

For testing, try `curl -X POST -F "file=@yellow_cactus.mp3;type=audio/mpeg" -F note=0 -F octave=1 -F confidence=0.778 -F diffidence=0.44 -F duration="12.22" -F station="the psychadelicatessan" -F city="stony brook, new york" -F country="merica" -F lat=-73.23 -F lon=38.14 localhost:5000/note`

### `GET /notes?since=timestamp`

Get a list of all the possible notes newer than timestamp.

For example, try for the last 5 minuts of notes, try `curl -X GET -d since=$(( `date +%s` - $((5*60)) )) https://localhost:5000/notes`

Todo
----

- sort by latest notes added
- add timestamps and ability to filter by timestamps
- update json-mask to latest stable version
