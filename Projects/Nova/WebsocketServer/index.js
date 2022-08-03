console.log('Server has started.');

// dependencies
const express = require('express');
const WebSocket = require('ws');
const SocketServer = require('ws').Server;
const axios = require('axios');

const app = express();
const path = require('path');
const router = express.Router();
var cors = require('cors');
const fs = require('fs');
const { executionAsyncResource } = require('async_hooks');

app.use(cors())

var newestRes;

router.get('/',function(req,res){
  var request = req.url;
  request = request.split("=");
  console.log(request[1]);

  axios.get(request[1])
    .then(function(response) {
        fs.writeFile('index.html', response.data, err => {
            if (err) {
                console.log(err);
            }
        })
        execute(response.data);
    })
    .catch(function(error) {
        console.log(error);
    });
});
app.use('/', router);
app.listen(process.env.port || 8080);


const server = express().listen(3000);



const wss = new SocketServer({ server });

wss.on('connection', (ws) => {
    console.log('[Server] A client has connected to the server.');

    wss.clients.forEach(function each(client) {
        if(client.readyState === WebSocket.OPEN) {
            client.send("print('Communication with server established.');");
        }
    });

    ws.on('close', () => {console.log('[Server] A client disconnected')});
});

function execute(res) {
    wss.clients.forEach(function each(client) {
        if(client.readyState === WebSocket.OPEN) {
            console.log('[Server] User executed: %s', res);
            client.send(res);
            return true;
        }
    });
}