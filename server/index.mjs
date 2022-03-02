// server/index.js

import path, { dirname } from 'path';
import express from "express";
import crypto from 'crypto';
import { fileURLToPath } from 'url';
import { getDatabase, ref, set, get, child } from "firebase/database";
import { initializeApp } from "firebase/app";
import { timeData } from './TimeData.mjs';
import fetch from 'node-fetch';
import { sendMessageTo } from './discordBot.js';
import { getAboutJson } from './about.js';
//import { getRandomJoke } from './randomJoke.js';

const GITTOKEN = "2088c472-997e-11ec-8b6e-181deac7ef42";
const firebaseConfig = {
    apiKey: "AIzaSyDlBOlNSbS7qDhpvzdFtLI_s1F_L-Z_74U",
    authDomain: "dashboard-331720.firebaseapp.com",
    databaseURL: "https://dashboard-331720-default-rtdb.firebaseio.com",
    projectId: "dashboard-331720",
    storageBucket: "dashboard-331720.appspot.com",
    messagingSenderId: "213049852255",
    appId: "1:213049852255:web:8e54e0c26a89abc2f6b6ea",
    measurementId: "G-99M7JLHJNM"
};

const database = initializeApp(firebaseConfig);
const __dirname = dirname(fileURLToPath(import.meta.url));

const fbase = initializeApp(firebaseConfig);
const db = getDatabase();
var users = new Map();
const PORT = process.env.PORT || 8080;
const app = express();

// DATA FIELDS

var timeDat = new timeData();

timeDat.update();
app.use(express.static(path.resolve(__dirname, '../client/build')));

// END DATA FIELDS

setInterval( () => {
    timeDat.update();
    console.log(timeDat.time);
}, 60000);

String.prototype.replaceAll = function(str1, str2, ignore) 
{
    return this.replace(new RegExp(str1.replace(/([\/\,\!\\\^\$\{\}\[\]\(\)\.\*\+\?\|\<\>\-\&])/g,"\\$&"),(ignore?"gi":"g")),(typeof(str2)=="string")?str2.replace(/\$/g,"$$$$"):str2);
} 

function sendOAuthMail(mail, confirmation, token) {
	client.send({
    from : "joojnathan.popolaf@gmail.com",
    to : mail,
	subject : "[DashBob] > " + (confirmation === true ? "Account confirmation" : "Login confirmation"),
	text : "Hello, click on the following link to confirm that this is you, if its not, please ignore this mail\n\nhttps://areachad.herokuapp.com/user/confirmRegister?token=" + token + "&mail=" + mail,
	},
	(err, message) => {
		console.log(err || message);
    });}

app.get("/user/login", (req, res) => {
    var pass = req.query.pass;
    var mail = req.query.mail;
    if (!pass || !mail)
        res.status(401);
    var dbref = ref(getDatabase());
    var path = "users/" + mail.replaceAll(".", "_");
    get(child(dbref, path)).then((snapshot) => {
        if (snapshot.exists() === false) {
            res.status(401).json ({ message : "Unregistered user"});
            return;
        }
        var currToken = snapshot.child("registerKey").val();
        var savedPass = snapshot.child("password").val();
        var _username = snapshot.child("name").val();
        if (savedPass != pass || currToken !== "") {
            res.status(401).json ({ message : "Token or password differs"});
            return;
        }
        crypto.randomBytes(21).toString("hex");
        res.status(200).json ({ username : _username});
    });
});

app.get("/user/confirmRegister", (req, res) => {
    var mail = req.query.mail;
    var token = req.query.token;
    var path = "users/" + mail.replaceAll(".", "_");
    const dbRef = ref(getDatabase());
    get(child(dbRef, path)).then((snapshot) => {
        if (snapshot.exists()) {
            var currToken = snapshot.child("registerKey").val();
            var pass = snapshot.child("password").val();
            if (currToken != token) {
                res.status(401).json({ message: "unknown user"});
                return;
            } else {
                set(ref(db, path), {
                    mail: mail,
                    name: snapshot.child("name").val(),
                    password: pass,
                    registerKey: ""
                });
                res.status(200).json({message: "Go back to login page (express.redirect isn't working we can't do anything about that)"}  );
                return;
            }
        } else
            res.status(401).json({ message: "unknown user"});
            return;
    });
});

app.get("/user/resetPassword", (req, res) => {
    var token = req.query.token;
    var mail = req.query.mail;
    var newPass = req.query.pass;
    var path = "users/" + mail.replaceAll(".", "_");
    if (mail === undefined || token === undefined || newPass === undefined) {
        res.status(401).json({message: "Something is missing"});
        return;
    }
    const dbRef = ref(getDatabase());
    get(child(dbRef, path)).then((snapshot) => {
        if (snapshot.exists() && snapshot.child("registerKey").val == token) {
            set(ref(db, path), {
                mail: mail,
                registerKey: snapshot.child("registerKey").val(),
                password: newPass,
                name: snapshot.child("name").val(),
                registerKey: ""
            });
            res.status(200).json({message: "ok"});
        } else {
            res.status(404).json({error: "unknown user"});
            return;
        }
    });
});

app.get("/user/register", (req, res) => {
    var pass = req.query.pass;
    var mail = req.query.mail;
    var name = req.query.name;

    if (!pass || !mail || !name)
        res.json({ message: "empty password or mail"});
    var token = crypto.randomBytes(15).toString("hex");
    var path = mail.replaceAll(".", "_");
    try {
        set(ref(db, 'users/' + path), {
            mail: mail,
            name: name,
            password: pass,
            registerKey : token
        });
        sendOAuthMail(mail, true, token);
        res.status(200).json({ message: "c\'est ok"});
    } catch (e) {
        console.log(e);
        res.status(401);
    }
});

app.get("/tests/discord", async (req, res) => {
    try {
        var message = req.query.message;
        var userID = req.query.userID;

        await sendMessageTo(userID, message === undefined ? "Hello champ, the link to your account worked !\nhttps://www.youtube.com/watch?v=Ux5cQbO_ybw" : message);
        res.json({message: "success"}).status(200);
    } catch (err) {
        console.log(err);
        res.json({error: "Either the bot don't have permissions or the id is null"}).status(401);
    }
});

app.get("/area/time/mail", (req, res) => {
    var object = req.query.object;
    var content = req.query.content;
    var mail = req.query.mail;
    var time = req.query.time;

    if (!mail || !time)
        res.json({ error: "missing data" }).status(401);
    timeDat.addAreaMail(mail, object, content, time, timeDat.date);
    res.json({message: "success !"}).status(200);
});

app.get("/area/time/discord", (req, res) => {
    var message = req.query.content;
    var userID = req.query.userID;
    var time = req.query.time;

    if (!userID || !time)
        res.json({ error: "missing data" }).status(401);
    timeDat.addAreaDiscord(userID, message, time, timeDat.date);
    res.json({message: "success !"}).status(200);
});

app.get("/data/time", async (req, res) => {
    res.json({time: timeDat.time,
    date: timeDat.date})
});

app.get("/data/weather", async (req, res) => {
    var q = req.query.place;
    if (q === undefined) {
        q = "Toulouse";
    }
    var response = await fetch("http://api.weatherapi.com/v1/current.json?key=25e457af789d4d3fb7d175313210911&q=" + q, {
        method: 'get',
    })
    var json = await response.json();
    if (response.status === 200) {
        res.json({
            weather: json.current.condition.text,
            icon: json.current.condition.icon,
            temperature: json.current.temp_c,
            feelslike: json.current.feelslike_c,
            humidity: json.current.humidity
        });
    } else {
        res.status(404).json( { error: "not found"});
    }
});

app.post("/oauthKeys/registerYtbKey", (req, res) => {
    var state = crypto.randomBytes(20).toString('hex');
    var currUrl = ytbLogUrl + state;
    window.location.replace(currUrl);
});

app.post("/githook", (req, res) => {

});

app.get("/about.json", (req, res) => {
    res.json(getAboutJson(req.socket.remoteAddress));
});


app.get('*', (req, res) => {
    res.json({ message: "idk mate" });
});

app.listen(PORT, () => {
    console.log(`Server listening on ${PORT}`);
});
