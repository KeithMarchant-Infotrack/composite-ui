'use strict';

const express = require('express');
const path = require('path');

// Constants
const PORT = 80;
const HOST = '0.0.0.0';

// App
const app = express();
app.get('/', (req, res) => {
    console.log(new Date().toString() + " : Menu requested.");
    res.sendFile(path.join(__dirname + '/menu.html'));
    console.log(new Date().toString() + " : Request finished.");
});

app.listen(PORT, HOST);
console.log(`Running on http://${HOST}:${PORT}`);