import 'package:app51_web_sandbox/features/auth_feature/view/user_builder.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

import '../model/auth_model.dart';

class AuthUserBuilder extends StatelessWidget {
  final ValueStream<AuthState> authStateStream;
  
  /// If no user is logged in
  final Widget Function() noUserBuilder;

  /// If a user is logged in but its Firestor model is not yet loaded
  final Widget Function() userLoadingBuilder;

  /// If a user is logged in
  final Widget Function(Utilisateur user) userLoggedInBuilder;

  /// Auth User Builder
  ///
  /// Switch among 3 builder methods according to the current auth state
  /// noUserLoggedIn / userLoading / userLoggedIn
  AuthUserBuilder(
      {@required this.authStateStream, this.noUserBuilder, this.userLoadingBuilder, this.userLoggedInBuilder});

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
            return UserBuilder(
              userStream: authState.currentUserStream,
              userLoadingBuilder: userLoadingBuilder,
              userLoggedInBuilder: userLoggedInBuilder,
            );
          } else
            return SizedBox.shrink();
        } else
          return SizedBox.shrink();
      },
    );
  }
}
