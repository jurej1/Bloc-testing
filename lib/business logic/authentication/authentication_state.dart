part of 'authentication_cubit.dart';

@immutable
abstract class AuthenticationState {
  const AuthenticationState();
}

class UserLogedIn extends AuthenticationState {
  final app.User user;

  const UserLogedIn(this.user);
}

class UserLogedOut extends AuthenticationState {}

class LoadingState extends AuthenticationState {}

class ErrorWhileAuthentication extends AuthenticationState {
  final String errorMsg;

  ErrorWhileAuthentication(this.errorMsg);
}
