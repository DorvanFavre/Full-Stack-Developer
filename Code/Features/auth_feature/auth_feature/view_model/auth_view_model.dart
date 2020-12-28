import 'package:flutter/material.dart';

import '../model/auth_model.dart';
import '../model/result.dart';

/////////////////////////////////////////////////////////////////////////////////////////////
///  Auth View Model
/////////////////////////////////////////////////////////////////////////////////////////////

class AuthViewModel {
  final AuthModel model;

  /// Auth ViewModel
  /// 
  /// Outputs :
  /// 
  ///   stackIndexNotifier,
  ///   loginEmailController,
  ///   registerEmailController,
  ///   registerUsernameController,
  ///   registerPasswordController,
  ///   registerRepeatedPasswordController,
  /// 
  /// Inputs :
  /// 
  ///   showLoginPage(),
  ///   showRegisterPage(),
  ///   login(),
  ///   register(),
  /// 
  AuthViewModel({@required this.model}) :assert(model != null);

  ////////////////////////////////////////////////////////////////
  // Outputs
  final ValueNotifier<int> stackIndexNotifier = ValueNotifier(0);

  final loginEmailController = TextEditingController();
  final loginPasswordController = TextEditingController();

  final registerEmailController = TextEditingController();
  final registerUsernameController = TextEditingController();
  final registerPasswordController = TextEditingController();
  final registerRepeatedPasswordController = TextEditingController();

  ////////////////////////////////////////////////////////////////
  // Inputs
  void showLoginPage() {stackIndexNotifier.value = 0;}
  void showRegisterPage() {stackIndexNotifier.value = 1;}

  Future<Result> login() {
    final email = loginEmailController.value.text;
    final password = loginPasswordController.value.text;

    if (email.trim().isEmpty)
      return Future.value(Failure(message: 'Please enter an email adress'));
    if (password.trim().isEmpty)
      return Future.value(Failure(message: 'Please enter a password'));

    return model.signIn(email: email, password: password);
  }

  Future<Result> register() {
    final email = registerEmailController.value.text;
    final username = registerUsernameController.value.text;
    final password = registerPasswordController.value.text;
    final repeatedPassword = registerRepeatedPasswordController.value.text;

    if (email.trim().isEmpty)
      return Future.value(Failure(message: 'Please enter an email adress'));
    if (username.trim().isEmpty)
      return Future.value(Failure(message: 'Please enter a username'));
    if (password.length < 6)
      return Future.value(Failure(
          message: 'The password has to be at least 6 characters long'));
    if (password.compareTo(repeatedPassword) != 0)
      return Future.value(Failure(message: 'The passwords do not correspond'));

    return model.createUser(email: email, password: password, username: username);
  }

  void dispose() {
    loginEmailController.dispose();
    loginPasswordController.dispose();
    registerEmailController.dispose();
    registerUsernameController.dispose();
    registerPasswordController.dispose();
    registerRepeatedPasswordController.dispose();
    stackIndexNotifier.dispose();
  }
}
