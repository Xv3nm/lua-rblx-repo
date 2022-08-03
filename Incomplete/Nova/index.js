console.log('Server has started.');

// dependencies
const express = require('express');
const WebSocket = require('ws');
const SocketServer = require('ws').Server;

const server = express().listen(3000);

const wss = new SocketServer({ server });

wss.on('connection', (ws) => {
    console.log('[Server] A client has connected to the server.');

    ws.on('close', () => {console.log('[Server] A client disconnected')});

    ws.on('message', (message) => {

        // broadcast to all clients

        console.log('[Server] Received: %s', message);
        wss.clients.forEach(function each(client) {
            if(client.readyState === WebSocket.OPEN) {
                client.send(message);
            }
        });
    });
});