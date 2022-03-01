import 'dart:io';

import 'package:area/screens/home/home_screen.dart';
import 'package:flutter/material.dart';

import 'package:area/screens/settings/settings_screen.dart';
import 'package:area/screens/pages/discord/discord.dart';
import 'package:area/screens/pages/github/github.dart';
import 'package:area/screens/pages/insta/insta.dart';
import 'package:area/screens/pages/twitch/twitch.dart';
import 'package:area/screens/pages/youtube/youtube.dart';
import 'package:area/screens/Login/home_view.dart';

class NavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        // Remove padding
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text('Oflutter.com'),
            accountEmail: Text('example@gmail.com'),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Image.asset(
                  "assets/images/lonk.jpg",
                  fit: BoxFit.cover,
                  width: 90,
                  height: 90,
                ),
              ),
            ),
            decoration: const BoxDecoration(
              color: Colors.blue,
              image: DecorationImage(
                  fit: BoxFit.fill,
                  image: NetworkImage(
                      'https://media.istockphoto.com/photos/colour-smoke-background-horror-halloween-mystery-magic-picture-id1059499980?k=20&m=1059499980&s=170667a&w=0&h=9kPwHbDoPWk5qA1P4Se6TYWMzt7sxcmMcwy6V_nV5pg=')),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return Home();
                  },
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.notifications),
            title: const Text('Notifications'),
            onTap: () => null,
            trailing: ClipOval(
              child: Container(
                color: Colors.red,
                width: 20,
                height: 20,
                child: const Center(
                  child: Text(
                    '8',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const Divider(),
          ListTile(
            leading: Icon(Icons.person),
            title: const Text('Youtube'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return YoutubeState();
                  },
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.discord),
            title: const Text('Discord'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return DiscordState();
                  },
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.facebook),
            title: const Text('Instagram'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return InstagramState();
                  },
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.code),
            title: const Text('Github'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return GithubState();
                  },
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.support_agent),
            title: const Text('Twitch'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return TwitchState();
                  },
                ),
              );
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return SettingsState();
                  },
                ),
              );
            },
          ),
          ListTile(
              title: const Text('Logout'),
              leading: const Icon(Icons.exit_to_app),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return HomeView();
                    },
                  ),
                );
              }),
        ],
      ),
    );
  }
}
