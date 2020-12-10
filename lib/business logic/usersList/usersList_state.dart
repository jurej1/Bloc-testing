part of 'usersList_cubit.dart';

@immutable
abstract class UsersListState {}

class LoadingUsers extends UsersListState {}

class UsersListLoaded extends UsersListState {
  final List<app.User> allUsers;

  UsersListLoaded(this.allUsers);
}
