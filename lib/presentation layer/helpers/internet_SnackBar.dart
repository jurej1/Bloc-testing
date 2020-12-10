import 'package:flutter/material.dart';
import 'package:testing_application/business%20logic/internet%20cubit/internet_cubit.dart';

void internetSnackBar({
  InternetState state,
  BuildContext context,
}) {
  if (state is Disconnected) {
    Scaffold.of(context).showSnackBar(
      SnackBar(
        content: Text('Check if the device is connected to the WIFI'),
      ),
    );
  } else if (state is InternetConnected) {
    Scaffold.of(context).showSnackBar(
      SnackBar(
        content: Text('It seems like you are connected'),
      ),
    );
  }
}
