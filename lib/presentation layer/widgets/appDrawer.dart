import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testing_application/business%20logic/authentication/authentication_cubit.dart';

import 'package:testing_application/presentation%20layer/screens/settings_screen.dart';

class CustomAppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          SizedBox(
            height: 40,
          ),
          ListTile(
            leading: Icon(
              Icons.settings,
              color: Theme.of(context).primaryColor,
            ),
            title: Text('Settings'),
            onTap: () {
              Navigator.of(context).pushNamed(SettingsScreen.routeName);
            },
          ),
          ListTile(
            leading: Icon(
              Icons.search,
              color: Theme.of(context).primaryColor,
            ),
            title: Text('Search'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(
              Icons.exit_to_app,
              color: Theme.of(context).primaryColor,
            ),
            title: Text('Logout'),
            onTap: () {
              BlocProvider.of<AuthenticationCubit>(context).logoutUser();
            },
          )
        ],
      ),
    );
  }
}
