class AuthStateWrapper extends StatefulWidget {
  /// Auth view model is needed
  final AuthViewModel viewModel;

  /// Widget when no user is logged in. AuthView() by default
  final Widget noUserLoggedIn;

  /// Widget when a user is logged in
  final Widget child;

  /// Widget while loading the auth state. SizedBox.shrink() by default
  final Widget waiting;

  
  AuthStateWrapper(
      {@required this.viewModel,
      @required this.child,
      Widget noUserLoggedIn,
      this.waiting = const SizedBox.shrink()})
      : this.noUserLoggedIn = noUserLoggedIn == null
            ? AuthView(viewModel: viewModel)
            : noUserLoggedIn;

  @override
  _AuthStateWrapperState createState() => _AuthStateWrapperState();
}
