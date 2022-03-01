import fetch from 'node-fetch';
import { SMTPClient } from 'emailjs';
import { sendMessageTo } from './discordBot.js';


var hour = 0;
var minute = 0;
const chadLink = "https://www.youtube.com/watch?v=Ux5cQbO_ybw";
const DISCORDID = Symbol("discord");
const USERMAIL = Symbol("mail");

const client = new SMTPClient ({
	user: 'joojnathan.popolaf@gmail.com',
	password: 'Hu7,!PlYtG',
	host: 'smtp.gmail.com',
	ssl: true,
});

class DiscordUser {
    constructor(userID, message = null, time = null, date = null) {
        this.user = userID;
        if (date == null)
            this.date = td.date;
        if (time == null)
            time = hour + ":" + minute;
        this.hour = time.split(':')[0];
        this.minute = time.split(':')[1];
        this.message = message === null ? chadLink : message;
    }

    sendMessage() {
        sendMessageTo(this.user, this.message);
    }

    isTimeTrue(hour, minutes) {
        if (minutes == this.minute && this.hour == hour)
            return true;
        return false;
    }
}

class areaMail {
    constructor(userID, mailObject = null, mailContent = null, time = null, date = null) {
        this.user = userID;
        if (date == null)
            this.date = td.date;
        if (time == null)
            time = hour + ":" + minute;
        this.hour = time.split(':')[0];
        this.minute = time.split(':')[1];
        this.object = mailObject === null ? "[Timer] > Hello champ" : mailObject;
        this.content = mailContent === null ? "Your timer has gone beep beep\n\nTime for schoo" : mailContent;
    }

    sendMail() {
        client.send({
            from : "joojnathan.popolaf@gmail.com",
            to : this.user,
            subject : this.object,
            text : this.content,
        },
        (err, message) => {
            console.log(err || message);
        })
    }
    
    isTimeTrue(hour, minutes) {
        if (minutes == this.minute && this.hour == hour)
            return true;
        return false;
    }
}

export class timeData {

    constructor() {
        this.time = 0;
        this.minute = 0;
        this.hour = 0;
        this.date = 0;
        this.userAreas = [];
    }

    async update() {
        var response = await fetch("http://api.weatherapi.com/v1/current.json?key=25e457af789d4d3fb7d175313210911&q=Toulouse", {
            method: 'get',
        })
        let json = await response.json();
        let timejs = JSON.stringify(json.location.localtime).replace("\"", "").split(" ");
        timejs[1] = timejs[1].replace("\"", "");
        this.date = timejs[0];
        this.time = timejs[1];
        this.hour = this.time.split(':')[0];
        this.minute = this.time.split(':')[1];
        minute = this.minute;
        hour = this.hour;
        this.checkAreas();
    }

    async checkAreas() {
        if (this.userAreas.length == 0)
            return;
        console.log(this.hour);
        console.log(this.minute);    
        this.userAreas.forEach(function(item, index, array) {
            if (item.isTimeTrue(hour, minute))
                item.sendMessage();
        });
    }

//    async checkAreas() {
//        await checkMails();
//    }

    addAreaMail(userMail, mailObject = null, mailContent = null, time = null, date = null) {
        this.userAreas.push(new areaMail(userMail, mailObject, mailContent, time, date));
    }

    addAreaDiscord(userID, message = null, time = null, date = null) {
        this.userAreas.push(new DiscordUser(userID, message, time, date));
    }
}