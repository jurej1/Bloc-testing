import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  static const routeName = '/Settings_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Settings Screen'),
      ),
    );
  }
}
