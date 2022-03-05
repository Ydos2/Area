// ignore_for_file: camel_case_types, unnecessary_null_comparison, deprecated_member_use

import 'dart:io';

import 'package:area/components/user.dart';
import 'package:area/components/user_pref.dart';
import 'package:area/constants.dart';
import 'package:area/screens/pages/profile/buildAppBar.dart';
import 'package:area/screens/pages/profile/profile_widget.dart';
import 'package:area/screens/pages/profile/textfield_widget.dart';
import 'package:area/settings.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:area/screens/pages/profile/type.dart';

class profilePage extends StatefulWidget {
  const profilePage({Key? key}) : super(key: key);

  @override
  State<profilePage> createState() => _profilePageState();
}

class _profilePageState extends State<profilePage> {
  bool _dark = settings.dark_mode;
  late User user;
  File? newImage;

  Future chooseImage(ImageSource source) async {
    try {
      final image = await ImagePicker().getImage(source: source);
      if (image == null) return null;
      final directory = await getApplicationDocumentsDirectory();
      final name = basename(image.path);
      final imageFile = File('${directory.path}/$name');
      final newImage = await File(image.path).copy(imageFile.path);
      setState(() {
        if (useless.type == "Image")
          user = user.copy(profilePic: newImage.path);
        if (useless.type == "Banner") user = user.copy(banner: newImage.path);
      });
    } on PlatformException catch (e) {
      print("Failed to pick image:$e");
    }
  }

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
      backgroundColor: settings.dark_mode ? pf2 : pc1,
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          ProfileWidget(
              imagePath: user.profilePic,
              bannerPath: user.banner,
              onClicked: () async {
                showModalBottomSheet(
                  context: context,
                  builder: (context) => Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ListTile(
                        leading: const Icon(Icons.camera_alt),
                        title: const Text("Camera"),
                        onTap: () {
                          chooseImage(ImageSource.camera);
                          Navigator.of(context).pop();
                        },
                      ),
                      ListTile(
                        leading: const Icon(Icons.image),
                        title: const Text("Gallery"),
                        onTap: () {
                          chooseImage(ImageSource.gallery);
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                );
              }),
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
            onChanged: (email) {
              user = user.copy(email: email);
            },
          ),
          const SizedBox(height: 24),
          GestureDetector(
            onTap: () {
              if (!EmailValidator.validate(user.email)) {
                showDialog(
                    context: context,
                    // ignore: prefer_const_constructors
                    builder: (context) => const AlertDialog(
                          title: Center(child: Text('Email is invalid')),
                          titleTextStyle: TextStyle(
                            fontFamily: "Raleway",
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                          ),
                        ));
              } else {
                UserPreferences.setUser(user);
                Navigator.of(context).pop();
              }
            },
            child: Container(
              width: 200,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: settings.dark_mode ? ps5 : ps10,
              ),
              child: Center(
                child: Text(
                  'Save',
                  style: TextStyle(
                    fontFamily: "Raleway",
                    fontWeight: FontWeight.w800,
                    fontSize: 25,
                    color: settings.dark_mode ? pc1 : pf1,
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
