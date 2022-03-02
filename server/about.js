module.exports.getAboutJson = (ip) => {
    return {
    "client": {
        "host": ip
    },
    "server": {
        "current_time": new Date(),
        "services": [{
            "name": "time",
            "actions": [{
                "name": "alarm",
                "description": "A certain time & data has been reched",
            }],
            "reactions": [{
                "name": "discord_ping",
                "description": "Send a discord message to the user (OAuth2)",
                "requirement": "The user should have joined a discord server that have the bot in OR authorize message from unknown users.",
                "params": [{
                    "time": "When the alarm should be triggered (format hh:mm)",
                    "message": "String that contains the message to be send as alarm (can be null to send default)",
                    "userID": "The discord UID, can be obtained via Oauth2 from the bot"
                },{
                    "name": "send mail",
                    "description": "Send a discord message to the user (OAuth2)",
                    "params": [{
                        "time": "When the alarm should be triggered (format hh:mm)",
                        "content": "String that contains the content of the mail (can be null to send default)",
                        "object": "String that contains the object of the mail (can be null to send default)",
                        "mail": "A mail that the alarm should be send to"
                    }]
                }]},{
                    "name": "DadJoke",
                    "action": [{
                        "name": "send_joke",
                        "description": "Send a random joke (Refresh every 5 minutes)",
                    }],
                    "reaction": [{
                        "name": "send_me_a_joke_discord",
                        "description": "Send a joke to your discord PM after X refresh",
                        "requirement": "The user should have joined a discord server that have the bot in OR authorize message from unknown users.",
                        "params": [{
                            "refreshnb": "Number of joke refresh before sending one",
                            "userID": "The discord UID, can be obtained via Oauth2 from the bot"
                        }]
                    },{
                        "name": "send_me_a_joke_mail",
                        "description": "Send a mail containing the setup as the mail object and the punchline as content after X refresh",
                        "params": [{
                            "refreshnb": "Number of joke refresh before sending one",
                            "mail": "A mail that the alarm should be send to"
                        }]
                    }]
                }
            ]}
        ]}
    }
}