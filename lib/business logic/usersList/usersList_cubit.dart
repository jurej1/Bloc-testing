import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:testing_application/data/reposetory/databaseReposetory.dart';
import '../../data/models/user.dart' as app;

part 'usersList_state.dart';

class UsersListCubit extends Cubit<UsersListState> {
  final DatabaseReposetory databaseReposetory;

  UsersListCubit(this.databaseReposetory) : super(LoadingUsers()) {
    monitoringUsers();
  }

  monitoringUsers() {
    databaseReposetory.usersListSnapshot.listen((users) {
      if (users == null) {
        print(state);
        emit(LoadingUsers());
      } else if (users.isNotEmpty) {
        print(state);
        emit(UsersListLoaded(users));
      }
    });
  }
}
