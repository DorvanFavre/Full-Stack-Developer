import 'package:flutter/material.dart';

import '../model/auth_model.dart';

class AuthBuilder extends StatelessWidget {


  /// If no user is logged in
  final Widget Function() noUserBuilder;

  /// If a user is logged in but its Firestor model is not yet loaded
  final Widget Function() userLoadingBuilder;

  /// If a user is logged in 
  final Widget Function(Utilisateur user) userLoggedInBuilder;

  /// Auth Builder
  /// 
  /// Switch among 3 builder methods according to the current auth state
  /// noUserLoggedIn / userLoading / userLoggedIn
  AuthBuilder(
      {this.noUserBuilder, this.userLoadingBuilder, this.userLoggedInBuilder});

  final model = AuthModel();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<AuthState>(
      stream: model.getAuthStateStream(),
      builder: (context, AsyncSnapshot<AuthState> snapshot) {
        final authState = snapshot.data;

        if (authState != null) {
          if (authState is NoUserLoggedIn) {
            return noUserBuilder != null ? noUserBuilder() : SizedBox.shrink();
          } else if (authState is UserLoggedIn) {
            return StreamBuilder<Utilisateur>(
              stream: authState.currentUserStream,
              builder: (context, AsyncSnapshot<Utilisateur> snapshot) {
                final user = snapshot.data;
                if (user != null) {
                  return userLoggedInBuilder != null
                      ? userLoggedInBuilder(user)
                      : SizedBox.shrink();
                } else {
                  return userLoadingBuilder != null
                      ? userLoadingBuilder()
                      : SizedBox.shrink();
                }
              },
            );
          } else
            return SizedBox.shrink();
        } else
          return SizedBox.shrink();
      },
    );
  }
}
