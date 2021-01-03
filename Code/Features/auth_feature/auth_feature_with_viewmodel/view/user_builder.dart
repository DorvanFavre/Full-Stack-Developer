import 'package:flutter/material.dart';

import 'package:app51_web_sandbox/features/auth_feature/model/auth_model.dart';
import 'package:rxdart/rxdart.dart';

class UserBuilder extends StatelessWidget {
  final ValueStream<Utilisateur> userStream;
  final Widget Function() userLoadingBuilder;
  final Widget Function(Utilisateur user) userLoggedInBuilder;

  UserBuilder(
      {@required this.userStream,
      this.userLoadingBuilder,
      this.userLoggedInBuilder});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Utilisateur>(
      stream: userStream,
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
  }
}
