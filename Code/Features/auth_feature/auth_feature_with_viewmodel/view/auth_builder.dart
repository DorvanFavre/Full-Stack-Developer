import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

import '../model/auth_model.dart';

class AuthBuilder extends StatelessWidget {
  final ValueStream<AuthState> authStateStream;

  /// If no user is logged in
  final Widget Function() noUserBuilder;

  /// If a user is logged in
  final Widget Function(Stream<Utilisateur> user) userLoggedInBuilder;

  /// Auth Builder
  ///
  /// Switch among 2 builder methods according to the current auth state
  /// noUserLoggedIn / userLoggedIn
  AuthBuilder(
      {@required this.authStateStream, this.noUserBuilder, this.userLoggedInBuilder});


  @override
  Widget build(BuildContext context) {
    return StreamBuilder<AuthState>(
      stream: authStateStream,
      builder: (context, AsyncSnapshot<AuthState> snapshot) {
        final authState = snapshot.data;

        if (authState != null) {
          if (authState is NoUserLoggedIn) {
            return noUserBuilder != null ? noUserBuilder() : SizedBox.shrink();
          } else if (authState is UserLoggedIn) {
            return userLoggedInBuilder != null ? userLoggedInBuilder(authState.currentUserStream) : SizedBox.shrink();
          } else
            return SizedBox.shrink();
        } else
          return SizedBox.shrink();
      },
    );
  }
}
