import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:testing_application/data/exception/exception.dart';

//Reposetory
import 'package:testing_application/data/reposetory/authReposetory.dart';

//Models
import 'package:testing_application/data/models/user.dart' as app;

part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  final AuthReposetory authReposetory;

  AuthenticationCubit(this.authReposetory) : super(UserLogedOut()) {
    checkIfTheUserIsLoggedIn();
  }

  Future<void> checkIfTheUserIsLoggedIn() async {
    emit(LoadingState());

    app.User user = await authReposetory.checkUser();

    if (user == null) {
      emit(UserLogedOut());
    } else {
      emit(UserLogedIn(user));
    }
  }

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    emit(LoadingState());
    try {
      app.User userData = await authReposetory.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      emit(UserLogedIn(userData));
    } catch (error) {
      emit(ErrorWhileAuthentication(error.toString()));
    }
  }

  Future<void> logoutUser() async {
    emit(LoadingState());
    await authReposetory.logoutUser();

    emit(UserLogedOut());
  }
}
