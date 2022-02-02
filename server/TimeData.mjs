import fetch from 'node-fetch';
import { SMTPClient } from 'emailjs';

var hour = 0;
var minute = 0;

const client = new SMTPClient ({
	user: 'joojnathan.popolaf@gmail.com',
	password: 'Hu7,!PlYtG',
	host: 'smtp.gmail.com',
	ssl: true,
});

class areaMail {
    constructor(userMail, mailObject = null, mailContent = null, time = null, date = null) {
        this.user = userMail;
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
        this.userMailAreas = [];
    }
    

    async init() {
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
        this.checkMails();
    }

    async checkMails() {
        if (this.userMailAreas.length == 0)
            return;
        console.log(this.hour);
        console.log(this.minute);    
        this.userMailAreas.forEach(function(item, index, array) {
            if (item.isTimeTrue(hour, minute))
                item.sendMail();
        });
    }

    async checkAreas() {
        await checkMails();
    }

    addAreaMail(userMail, mailObject = null, mailContent = null, time = null, date = null) {
        this.userMailAreas.push(new areaMail(userMail, mailObject, mailContent, time, date));
        console.log("user added");
    }
}