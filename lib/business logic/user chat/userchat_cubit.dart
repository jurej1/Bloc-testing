import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'userchat_state.dart';

class UserChatCubit extends Cubit<UserChatState> {
  UserChatCubit() : super(UserChatInitial());
}
