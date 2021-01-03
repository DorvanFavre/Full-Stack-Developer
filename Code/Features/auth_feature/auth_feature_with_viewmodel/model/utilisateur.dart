import 'package:flutter/material.dart';


class Utilisateur {
  static final String collectionRef = 'Users';
  static final String userIdField = 'userId';
  static final String emailField = 'email';
  static final String usernameField = 'username';
  static final String imageIdField = 'imageId';
  static final String isAdminField = 'isAdmin';
  
  factory Utilisateur.fromEntity(Map<String, dynamic> data) {
    return Utilisateur(
      userId: data[userIdField] ?? 'null',
      email: data[emailField] ?? 'null',
      username: data[usernameField] ?? 'null',
      imageId: data[imageIdField] ?? 'null',
      isAdmin: data[isAdminField] ?? false,
    );
  }

  Utilisateur({
    @required this.userId,
    @required this.email,
    @required this.username,
    @required this.imageId,
    @required this.isAdmin,
  }) {
    assert(userId != null);
    assert(email != null);
    assert(username != null);
    assert(imageId != null);
    assert(isAdmin !=null);
  }

  final String userId;
  final String email;
  final String username;
  final String imageId;
  final bool isAdmin;

  Map<String, dynamic> toEntity() {
    return {
      userIdField: userId,
      emailField: email,
      usernameField: username,
      imageIdField: imageId,
      isAdminField: isAdmin,
    };
  }



}
