import 'dart:io';

import 'package:flutter/material.dart';
import 'package:area/screens/pages/profile/type.dart';

class ProfileWidget extends StatelessWidget {
  final String imagePath;
  final VoidCallback onClicked;
  final String bannerPath;

  const ProfileWidget({
    Key? key,
    required this.imagePath,
    required this.onClicked,
    required this.bannerPath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.primary;

    return Center(
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          buildBanner(context),
          Positioned(
            top: 70,
            right: MediaQuery.of(context).size.width / 3,
            child: buildImage(context),
          ),
          Positioned(
            top: 160,
            right: MediaQuery.of(context).size.width / 3,
            child: buildEditIcon(color, "Image"),
          ),
          Positioned(
            right: 0,
            child: buildEditIcon(color, "Banner"),
          ),
        ],
      ),
    );
  }

  Widget buildImage(BuildContext context) {
    final image = imagePath.contains('https://')
        ? NetworkImage(imagePath)
        : FileImage(File(imagePath));

    return ClipOval(
      child: Material(
        color: Colors.transparent,
        child: Ink.image(
          image: image as ImageProvider,
          fit: BoxFit.cover,
          width: 128,
          height: 128,
          child: InkWell(
            onTap: () {
              useless.type = "Image";
              onClicked();
            },
          ),
        ),
      ),
    );
  }

  Widget buildBanner(BuildContext context) {
    final banner = bannerPath.contains('https://')
        ? NetworkImage(bannerPath)
        : FileImage(File(bannerPath));

    return Material(
      color: Colors.transparent,
      child: Ink.image(
        image: banner as ImageProvider,
        child: InkWell(
          onTap: () {
            useless.type = "Banner";
            onClicked();
          },
        ),
        fit: BoxFit.cover,
        width: MediaQuery.of(context).size.width - 5,
        height: 180,
      ),
    );
  }

  Widget buildEditIcon(Color color, String type) => buildCircle(
        color: Colors.white,
        all: 2,
        child: buildCircle(
          color: color,
          all: 0,
          child: IconButton(
            onPressed: () {
              useless.type = type;
              onClicked();
            },
            icon: const Icon(Icons.camera_alt_outlined),
            color: Colors.white,
            iconSize: 20,
          ),
        ),
      );

  Widget buildCircle({
    required Widget child,
    required double all,
    required Color color,
  }) =>
      ClipOval(
        child: Container(
          child: child,
          color: color,
          padding: EdgeInsets.all(all),
        ),
      );
}
