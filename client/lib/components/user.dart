// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';

class User {
  final String username;
  final String email;
  final String profilePic;
  final String banner;
  final bool hasLoggedInBefore;

  const User({
    required this.username,
    required this.email,
    required this.profilePic,
    required this.banner,
    required this.hasLoggedInBefore,
  });

  Map<String, dynamic> toJson() => {
        'imagePath': profilePic,
        'name': username,
        'email': email,
        'banner': banner,
        'hasLoggedInBefore': hasLoggedInBefore,
      };

  static User fromJson(Map<String, dynamic> json) => User(
        profilePic: json['imagePath'],
        username: json['name'],
        email: json['email'],
        banner: json['banner'],
        hasLoggedInBefore: json['hasLoggedInBefore'],
      );

  User copy({
    String? username,
    String? email,
    String? profilePic,
    String? banner,
    bool? hasLoggedInBefore,
  }) =>
      User(
        username: username ?? this.username,
        email: email ?? this.email,
        profilePic: profilePic ?? this.profilePic,
        banner: banner ?? this.banner,
        hasLoggedInBefore: hasLoggedInBefore ?? this.hasLoggedInBefore,
      );

}
