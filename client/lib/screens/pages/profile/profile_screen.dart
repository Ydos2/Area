// ignore_for_file: camel_case_types, unnecessary_null_comparison, deprecated_member_use

import 'dart:io';

import 'package:area/components/user.dart';
import 'package:area/components/user_pref.dart';
import 'package:area/constants.dart';
import 'package:area/screens/pages/profile/buildAppBar.dart';
import 'package:area/screens/pages/profile/profile_widget.dart';
import 'package:area/screens/pages/profile/textfield_widget.dart';
import 'package:area/settings.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class profilePage extends StatefulWidget {
  const profilePage({Key? key}) : super(key: key);

  @override
  State<profilePage> createState() => _profilePageState();
}

class _profilePageState extends State<profilePage> {
  bool _dark = settings.dark_mode;
  late User user;

  @override
  void initState() {
    super.initState();
    _dark = settings.dark_mode;
    user = UserPreferences.getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      backgroundColor: settings.dark_mode ? pf2 : pc3,
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          ProfileWidget(
            imagePath: user.profilePic,
            bannerPath: user.banner,
            onClicked: () async {
              final image =
                  await ImagePicker().getImage(source: ImageSource.gallery);
              if (image == null) return;
              final directory = await getApplicationDocumentsDirectory();
              final name = basename(image.path);
              final imageFile = File('${directory.path}/$name');
              final newImage = await File(image.path).copy(imageFile.path);
              setState(() {
                user = user.copy(profilePic: newImage.path);
              });
            },
          ),
          const SizedBox(height: 24),
          TextFieldWidget(
            label: 'Full Name',
            text: user.username,
            onChanged: (name) => user = user.copy(username: name),
          ),
          const SizedBox(height: 24),
          TextFieldWidget(
            label: 'Email',
            text: user.email,
            onChanged: (email) => user = user.copy(email: email),
          ),
          const SizedBox(height: 24),
          GestureDetector(
            onTap: () {
              UserPreferences.setUser(user);
              Navigator.of(context).pop();
            },
            child: Container(
              width: 200,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: pf5,
              ),
              child: const Center(
                child: Text(
                  'Save',
                  style: TextStyle(
                    fontFamily: "Raleway",
                    fontWeight: FontWeight.w800,
                    fontSize: 25,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
