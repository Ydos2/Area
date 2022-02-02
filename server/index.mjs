// server/index.js

import path, { dirname } from 'path';
import express from "express";
import crypto from 'crypto';
import { fileURLToPath } from 'url';
import { getDatabase, ref, set, get, child } from "firebase/database";
import { initializeApp } from "firebase/app";
import { timeData } from './TimeData.mjs';
import fetch from 'node-fetch';
import { time } from 'console';

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
timeDat.init();

// END DATA FIELDS

setInterval( () => {
    timeDat.init();
    console.log(timeDat.time);
}, 60000);



function sendOAuthMail(mail, confirmation, token) {
	client.send({
    from : "joojnathan.popolaf@gmail.com",
    to : mail,
	subject : "[DashBob] > " + (confirmation === true ? "Account confirmation" : "Login confirmation"),
	text : "Hello, click on the following link to confirm that this is you, if its not, please ignore this mail\n\nhttp://localhost:8080/confirmRegister?token=" + token + "&mail=" + mail,
	},
	(err, message) => {
		console.log(err || message);
    });
}

app.use(express.static(path.resolve(__dirname, '../client/build')));

app.get("/login", (req, res) => {
    var pass = req.query.pass;
    var mail = req.query.mail;
    if (!pass || !mail)
        res.status(401);
    var dbref = ref(getDatabase());
    var path = "users/" + mail.replace(".", "_");
    get(child(dbref, path)).then((snapshot) => {
        if (snapshot.exists() === false) {
            res.status = 401;
            res.json ({ message : "Unregistered user"});
            return;
        }
        var currToken = snapshot.child("registerKey").val();
        var savedPass = snapshot.child("password").val();
        if (savedPass != pass || currToken !== "") {
            res.status = 401;
            res.json ({ message : "Token or password differs"});
            return;
        }
        res.status(200);
        crypto.randomBytes(21).toString("hex");
        res.json ({ message : "connection success"});
    });
    });

app.get("/confirmRegister", (req, res) => {
    const dbRef = ref(getDatabase());
    var mail = req.query.mail;
    var path = "users/" + mail.replace(".", "_");
    var token = req.query.token;
    get(child(dbRef, path)).then((snapshot) => {
        if (snapshot.exists()) {
            var currToken = snapshot.child("registerKey").val();
            var pass = snapshot.child("password").val();
            if (currToken != token) {
                res.status(401)
            } else {
                set(ref(db, path), {
                    mail: mail,
                    password: pass,
                    registerKey: ""
                });
                res.status(200);
            }
        } else
            res.status(401);
    });
});

app.get("/register", (req, res) => {
    var pass = req.query.pass;
    var mail = req.query.mail;
    if (!pass || !mail)
        res.json({ message: "empty password or mail"});
    var token = crypto.randomBytes(15).toString("hex");
    var path = mail.replace(".", "_");
    set(ref(db, 'users/' + path), {
        mail: mail,
        password: pass,
        registerKey : token
      });
      sendOAuthMail(mail, true, token);
      res.status(200).json({ message: "c\'est ok"});
});

app.get("/api", (req, res) => {
    res.json({ message: "Hello from server!" });
});

app.get("/timeMail", (req, res) => {
    var object = req.query.object;
    var content = req.query.content;
    var mail = req.query.mail;
    var time = req.query.time;

    if (!mail || !time)
        res.json({ error: "missing data" }).status(401);
    timeDat.addAreaMail(mail, object, content, time, timeDat.date);
    res.json({message: "success !"}).status(200);
});

app.get("/time", async (req, res) => {
   
    res.json({time: timeDat.time,
    date: timeDat.date})
/*    var q = req.query.place;
    if (q === undefined) {
        q = "Toulouse";
    }
   
    if (response.status == 200) {*/
/*        res.json({city: json.location.name,
        region: json.location.region,
        country: json.location.country,
        date: time[0],
        time: time[1]});
    }*/
});

app.get("/weather", async (req, res) => {
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

app.post("/registerYtbKey", (req, res) => {
    var state = crypto.randomBytes(20).toString('hex');
    var currUrl = ytbLogUrl + state;
    window.location.replace(currUrl);
});

app.get('*', (req, res) => {
    res.json({ message: "idk mate" });
});

app.listen(PORT, () => {
    console.log(`Server listening on ${PORT}`);
});