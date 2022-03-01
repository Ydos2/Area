const Discord = require("discord.js")
const client = new Discord.Client({intents: ["GUILDS", "GUILD_MESSAGES"]})
const TOKEN = "OTQ1NzAyMDY5Mzc2MDI0NjU2.YhT_rw.w6ZS3QJ0_dssHYZBScfPOtMYAfA";

client.login(TOKEN);

client.on("ready", () => {

})


module.exports.sendMessageTo = (userID, message) => {
    client.users.fetch(userID).then((user) => {      
        user.send(message);
    });
}