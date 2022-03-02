# Area

A new Flutter project.

## Documentation

<br/>

If you want to maintain the code, there is a simple documentation made with dartdoc, its located in ./lib/doc/index.html <br/>
You can regen the documentation with `dartdoc` command, if you dont have it use `pub global activate dartdoc` at the root of the repository <br/>

To build project on github.io :
flutter build web
cd build/web
git add *
git commit -m ""
git push
Go to "https://ydos2.github.io/Area"

## Routes

Here is a list of the actual routes, how to use them and how to extract data from them, all these data will be a simple JSON.<br>
All the calls have to be with the method GET and will return a 200 on success, otherwise see the `on error` section <br> <br>

## Data routes<br><br>

> All data have a refresh time, as the server manage them with a timer to prevent you from sending too many requests to the APIs, they only refresh after a certain period of time.<br><br>

`/data/time`<br>
Gives you the time from this place, always funny to know.<br>
`refresh time` \> 1 minute<br>
**params**<br>
`place`=(City or country to check) \=> default: Toulouse<br>
**return value**<br>
{<br>
&nbsp;&nbsp;&nbsp;&nbsp;`city:`The city (or the capital of the targeted country)<br>
&nbsp;&nbsp;&nbsp;&nbsp;`region:`The region of the targeted place<br>
&nbsp;&nbsp;&nbsp;&nbsp;`country:`The targeted country<br>
&nbsp;&nbsp;&nbsp;&nbsp;`date:`The current date in the targeted city<br>
&nbsp;&nbsp;&nbsp;&nbsp;`time:`Current time in targeted city<br>
}<br>
**on error**<br>
The response code is `404` in case no city was found<br><br>

`/weather`<br>
Gives you the weather from this place, so you can be jealous because its raining in you country \>\:\).<br>
`refresh time` \> 1 minute<br>
**params**<br>
`place`=(City or country to check) \=> default: Toulouse<br>
**return value**<br>
{<br>
&nbsp;&nbsp;&nbsp;&nbsp;`weather:`The current weather in this country<br>
&nbsp;&nbsp;&nbsp;&nbsp;`icon:`A link to a cute image that shows the weather<br>
&nbsp;&nbsp;&nbsp;&nbsp;`temperature:`The actual temperature in this place in Celsius<br>
&nbsp;&nbsp;&nbsp;&nbsp;`feelslike:`The temperature you feel when you actually go out (in Celsius)<br>
&nbsp;&nbsp;&nbsp;&nbsp;`humidity:`The humidity of the air in per cent<br>
}<br>
**on error**<br>
The response code is `404` in case no city was found<br><br>

`/data/joke` <br>
This route gives you a random "dad joke" from a wide variety <br>
`refresh time` \> 5 minutes<br>
**return value** <br>
{ <br>
&nbsp;&nbsp;&nbsp;&nbsp;`setup:` the setup of the joke  <br>
&nbsp;&nbsp;&nbsp;&nbsp;`punchline:` The punchline of the joke AKA the funny<br>
} <br><br>

## User routes <br><br>

`/user/register`<br>
Used to make a user register.
**params** <br>
&nbsp;&nbsp;&nbsp;&nbsp;`name`=How should the user be called<br>
&nbsp;&nbsp;&nbsp;&nbsp;`pass`=The user's password to register<br>
&nbsp;&nbsp;&nbsp;&nbsp;`mail`=The user's wich will recieve the confirmation mail<br>
**on error**
&nbsp;&nbsp;&nbsp;&nbsp;`401` \> If the mail has already been used.<br><br>

`/user/login`<br>
Used to identify the user, if code 200 is recieved,<br>
the user was identified successfully.
**params** <br>
&nbsp;&nbsp;&nbsp;&nbsp;`pass`=The user's password that he typed.<br>
&nbsp;&nbsp;&nbsp;&nbsp;`mail`=The user's mail he used for his registration.<br>
**on error**
&nbsp;&nbsp;&nbsp;&nbsp;`401` \> If the mail or the password is incorrect or the mail was not recognized.<br><br>

## AREA routes<br><br>

`/area/time/discord`<br>
This route will send a discord message when a certain time is reached.<br>
You can invite the bot on your discord server (by clicking here)[https://discord.com/oauth2/authorize?client_id=945702069376024656&permissions=0&scope=bot%20applications.commands]<br>
it is **mandatory** to have the bot in a server you are in.<br>
**params** <br>
&nbsp;&nbsp;&nbsp;&nbsp;`userID`=The user's discord ID tag (You can get it with discord OAuth2).<br>
&nbsp;&nbsp;&nbsp;&nbsp;`message`=A custom message you want to recieve (None for default).<br>
&nbsp;&nbsp;&nbsp;&nbsp;`time`=When should the user be pinged (exemple: `time=11:25`)<br><br>

`/area/time/discord`<br>
This route will send a mail when a certain time is reached.<br><br>
**params** <br>
&nbsp;&nbsp;&nbsp;&nbsp;`mail`=The mail that should revieve the message.<br>
&nbsp;&nbsp;&nbsp;&nbsp;`content`=The content of the mail (None for default).<br>
&nbsp;&nbsp;&nbsp;&nbsp;`object`=The mail's object (None for default).<br>
&nbsp;&nbsp;&nbsp;&nbsp;`time`=When should the user be pinged (exemple: `time=11:25`)<br><br>
