import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../model/auth_model.dart';
import '../view_model/auth_view_model.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final viewModel = AuthViewModel(model: AuthModel());

  @override
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.grey[900],
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      backgroundColor: Colors.black,

      // Main Stack
      body: Stack(
        children: [
          // Main Content
          Padding(
            padding: EdgeInsets.all(30),
            child: ValueListenableBuilder(
                valueListenable: viewModel.stackIndexNotifier,
                builder: (context, stackIndex, child) {
                  return IndexedStack(
                    // Indexed Stack
                    index: stackIndex,
                    children: [
                      // Login Page
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 30,
                          ),
                          //Welcom
                          Text(
                            'Se connecter',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 60,
                          ),

                          //email
                          customTextField(
                            controller: viewModel.loginEmailController,
                            iconData: Icons.email_outlined,
                            hintText: 'Email...',
                          ),
                          SizedBox(
                            height: 20,
                          ),

                          // Password
                          customTextField(
                            controller: viewModel.loginPasswordController,
                            iconData: Icons.lock_outline,
                            hintText: 'Password...',
                            obscure: true,
                          ),
                          Spacer(),

                          // Button Login
                          Center(
                            child: TextButton(
                              child: Text(
                                'Login',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                              onPressed: () {
                                viewModel.login().then((result) {
                                  if (result is Success) {
                                    /* showSuccessSnackBar(
                                        context: context,
                                        text: 'Login Succeed');*/
                                        print('Login Succeed');

                                    Navigator.of(context).pop();
                                  } else if (result is Failure) {
                                    /*showFailureSnackBar(
                                        context: context, text: result.message);*/
                                        print(result.message);
                                  }
                                });
                              },
                            ),
                          ),

                          Spacer(),

                          // dont have an account
                          Center(
                            child: RichText(
                              text: TextSpan(
                                  text: "Pas encore de compte ? ",
                                  style: TextStyle(color: Colors.white),
                                  children: [
                                    TextSpan(
                                        text: "S'enregister",
                                        style: TextStyle(
                                          color: Theme.of(context).primaryColor,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                            viewModel.showRegisterPage();
                                          })
                                  ]),
                            ),
                          ),
                        ],
                      ),

                      // Register Page
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 30,
                          ),
                          //Welcom
                          Text(
                            'Nouveau compte',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 60,
                          ),

                          //email
                          customTextField(
                            controller: viewModel.registerEmailController,
                            iconData: Icons.email_outlined,
                            hintText: 'Email...',
                          ),
                          SizedBox(
                            height: 20,
                          ),

                          //username
                          customTextField(
                            controller: viewModel.registerUsernameController,
                            iconData: Icons.email_outlined,
                            hintText: 'Username...',
                          ),
                          SizedBox(
                            height: 20,
                          ),

                          // Password
                          customTextField(
                            controller: viewModel.registerPasswordController,
                            iconData: Icons.lock_outline,
                            hintText: 'Password...',
                            obscure: true,
                          ),
                          SizedBox(
                            height: 20,
                          ),

                          // Repeated Password
                          customTextField(
                            controller:
                                viewModel.registerRepeatedPasswordController,
                            iconData: Icons.lock_outline,
                            hintText: 'Repeate Password...',
                            obscure: true,
                          ),
                          Spacer(),

                          // Button REgister
                          Center(
                            child: TextButton(
                              child: Text(
                                'Register',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                              onPressed: () {
                                viewModel.register().then((result) {
                                  if (result is Success) {
                                    /*showSuccessSnackBar(
                                        context: context,
                                        text: 'Login Succeed');*/

                                    Navigator.of(context).pop();
                                  } else if (result is Failure) {
                                    /*showFailureSnackBar(
                                        context: context, text: result.message);*/
                                  }
                                });
                              },
                            ),
                          ),

                          Spacer(),

                          // dont have an account
                          Center(
                            child: RichText(
                              text: TextSpan(
                                  text: "Déjà un compte ? ",
                                  style: TextStyle(color: Colors.white),
                                  children: [
                                    TextSpan(
                                        text: 'Se connecter',
                                        style: TextStyle(
                                          color: Theme.of(context).primaryColor,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                            viewModel.showLoginPage();
                                          })
                                  ]),
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                }),
          ),
        ],
      ),
    );
  }
}

Widget customTextField(
    {@required TextEditingController controller,
    @required IconData iconData,
    @required String hintText,
    bool obscure = false}) {
  return TextField(
    controller: controller,
    style: TextStyle(color: Colors.white70),
    obscureText: obscure,
    decoration: InputDecoration(
        prefixIcon: Icon(
          iconData,
          color: Colors.white70,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(width: 1, color: Colors.white70),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(
            width: 3,
            color: Colors.white70,
          ),
        ),
        hintText: hintText,
        hintStyle: TextStyle(
          color: Colors.white70,
        )),
  );
}
