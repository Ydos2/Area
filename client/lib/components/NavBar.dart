// ignore_for_file: avoid_returning_null_for_void, file_names, unnecessary_null_comparison, prefer_conditional_assignment, unnecessary_cast

import 'dart:io';

import 'package:area/components/user.dart';
import 'package:area/components/Oauth2.dart';
import 'package:area/screens/home/home_screen.dart';
import 'package:area/settings.dart';
import 'package:flutter/material.dart';

import 'package:area/screens/settings/settings_screen.dart';
import 'package:area/screens/pages/discord/discord.dart';
import 'package:area/screens/pages/spotify/spotify.dart';
import 'package:area/screens/pages/spotify/tests.dart';
import 'package:area/screens/pages/github/github.dart';
import 'package:area/screens/pages/facebook/facebook.dart';
import 'package:area/screens/pages/twitch/twitch.dart';
import 'package:area/screens/pages/youtube/youtube.dart';
import 'package:area/screens/pages/mail/mail.dart';
import 'package:area/screens/notifications/notifications.dart';
import 'package:area/screens/Login/home_view.dart';
import 'package:get/get.dart';
import 'package:area/components/user_pref.dart';

import '../screens/Login/mobile_view/google_login_controller.dart';

class NavBar extends StatelessWidget {
  final googleController = Get.put(LoginController());
  final User user = UserPreferences.getUser();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        // Remove padding
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(user.username),
            accountEmail: Text(user.email),
            currentAccountPicture: CircleAvatar(
              backgroundImage: user.profilePic.contains('https://')
                  ? NetworkImage(user.profilePic) as ImageProvider
                  : FileImage(File(user.profilePic)) as ImageProvider,
            ),
            decoration: BoxDecoration(
              color: Colors.blue,
              image: DecorationImage(
                fit: BoxFit.fill,
                image: user.banner.contains('https://')
                    ? NetworkImage(user.banner) as ImageProvider
                    : FileImage(File(user.banner)) as ImageProvider,
              ),
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
            // ignore: avoid_returning_null_for_void
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return NotifState();
                  },
                ),
              );
            },
            trailing: ClipOval(
              child: settings.titles.length == 0
                  ? null
                  : Container(
                      color: Colors.red,
                      width: 20,
                      height: 20,
                      child: Center(
                        child: Text(
                          settings.titles.length.toString(),
                          style: const TextStyle(
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
            leading: const Icon(Icons.mail),
            title: const Text('Mail'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return MailState();
                  },
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.person),
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
            leading: const Icon(Icons.music_note),
            title: const Text('Spotify'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return SpotifyState();
                  },
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.facebook),
            title: const Text('Facebook'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return ExampleApp();
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
                googleController.logout();
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
