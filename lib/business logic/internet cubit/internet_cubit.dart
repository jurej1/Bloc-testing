import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:connectivity_plus/connectivity_plus.dart';

part 'internet_state.dart';

class InternetCubit extends Cubit<InternetState> {
  Connectivity connectivity;

  InternetCubit(this.connectivity) : super(InternetInitial()) {
    monitorInternetConnection();
  }

  void monitorInternetConnection() {
    connectivity.onConnectivityChanged.listen((connectivityResult) {
      if (connectivityResult == ConnectivityResult.wifi) {
        emit(InternetConnected());
      } else if (connectivityResult == ConnectivityResult.none) {
        emit(Disconnected());
      } else if (connectivityResult == ConnectivityResult.mobile) {
        emit(InternetConnected());
      }
    });
  }
}
