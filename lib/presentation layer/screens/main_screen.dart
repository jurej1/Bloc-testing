import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testing_application/business%20logic/authentication/authentication_cubit.dart';
import 'package:testing_application/business%20logic/internet%20cubit/internet_cubit.dart';
import 'package:testing_application/business%20logic/usersList/usersList_cubit.dart';
import 'package:testing_application/presentation%20layer/screens/chat_screen.dart';
import 'package:testing_application/presentation%20layer/widgets/appDrawer.dart';
import '../helpers/internet_SnackBar.dart';
import '../../data/models/user.dart' as app;
import 'package:intl/intl.dart';

class MainScreen extends StatelessWidget {
  final scaffoldKey =
      GlobalKey<ScaffoldState>(debugLabel: 'Main_screen_scaffold');

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return BlocListener<InternetCubit, InternetState>(
      listener: (_, state) {
        internetSnackBar(
          state: state,
          context: context,
        );
      },
      child: Scaffold(
        drawer: CustomAppDrawer(),
        key: scaffoldKey,
        appBar: AppBar(
          actions: [
            FlatButton.icon(
              icon: Icon(Icons.exit_to_app),
              onPressed: () {
                BlocProvider.of<AuthenticationCubit>(context).logoutUser();
              },
              label: Text('Logout'),
              textColor: Colors.white,
            ),
          ],
        ),
        body: BlocBuilder<UsersListCubit, UsersListState>(
          builder: (_, state) {
            if (state is LoadingState) {
              return CircularProgressIndicator();
            } else if (state is UsersListLoaded) {
              return Container(
                height: size.height,
                width: size.width,
                child: ListView.builder(
                  itemBuilder: (_, index) {
                    app.User user = state.allUsers[index];

                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: ListTile(
                        onTap: () {
                          Navigator.of(context).pushNamed(
                            ChatScreen.routeName,
                            arguments: user,
                          );
                        },
                        leading: Container(
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Theme.of(context).primaryColor,
                            image: DecorationImage(
                              image: NetworkImage(user.photoUrl),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        title: Text(user.nickname),
                        subtitle: Text(
                          'Joined on: ${DateFormat.yMMMd().format(
                            user.joinedOn.toDate(),
                          )}',
                        ),
                      ),
                    );
                  },
                  itemCount: state.allUsers.length,
                ),
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
