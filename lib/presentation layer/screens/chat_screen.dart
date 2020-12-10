import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testing_application/business%20logic/internet%20cubit/internet_cubit.dart';
import 'package:testing_application/business%20logic/user%20chat/userchat_cubit.dart';
import '../helpers/internet_SnackBar.dart' as sc;

import '../../data/models/user.dart' as app;

class ChatScreen extends StatefulWidget {
  static const routeName = '/chat_screen';

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  app.User recieverData;

  bool dataLoaded = false;
  @override
  void initState() {
    super.initState();
  }

  void getUsersChat() {
    recieverData = ModalRoute.of(context).settings.arguments as app.User;
  }

  @override
  Widget build(BuildContext context) {
    getUsersChat();
    return Scaffold(
      appBar: AppBar(),
      body: BlocListener<InternetCubit, InternetState>(
        listener: (_, state) {
          sc.internetSnackBar(state: state);
        },
        child: BlocBuilder<UserChatCubit, UserChatState>(
          builder: (_, state) {
            return Container(
              height: 200,
              width: 200,
              color: Colors.blue,
              child: Text(
                recieverData.nickname,
              ),
            );
          },
        ),
      ),
    );
  }
}
