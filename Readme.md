devart server
=============

Setup
-----

Install node.js [node](nodejs.org)
```bash
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

### `GET /notes?since=timestamp&limit=#toreturn&fields=fieldmask`

Get a list of **limit** notes newer than **timestamp**

Fieldmask uses [json-mask](https://github.com/nemtsov/json-mask) to reduce the load over the wire.

To get just the medialink, name, and owner entityId of the last note

    curl https://devartplaytheworld.com/notes\?limit\=1&fields\=\(mediaLink,name,owner/entityId\)

For the last 5 minutes of notes

    curl https://devartplaytheworld.com/notes\?since\=$((`date +%s` - $((5*60)) ))

For the last 10 notes

    curl https://devartplaytheworld.com/notes\?limit\=10

Todo
----

- sort by latest notes added
- add timestamps and ability to filter by timestamps
- update json-mask to latest stable version
