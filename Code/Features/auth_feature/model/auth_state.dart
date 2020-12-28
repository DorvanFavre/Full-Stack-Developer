import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

import 'utilisateur.dart';

abstract class AuthState {}

class UserLoggedIn extends AuthState {
  final ValueStream<Utilisateur> currentUserStream;

  UserLoggedIn({@required this.currentUserStream}) {
    assert(currentUserStream != null);
  }
}

class NoUserLoggedIn extends AuthState {
  NoUserLoggedIn() ;
}
