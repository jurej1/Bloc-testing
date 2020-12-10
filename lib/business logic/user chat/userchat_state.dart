part of 'userchat_cubit.dart';

@immutable
abstract class UserChatState {}

class UserChatInitial extends UserChatState {}

class LoadingUserChat extends UserChatState {}

class UserChats extends UserChatState {}
