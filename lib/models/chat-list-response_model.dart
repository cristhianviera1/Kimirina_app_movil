import 'user_model.dart';
class ChatListResponse {
  List<User> chatList;
  bool error;
  bool singleUser;
  bool userDisconnected;
  String userid;
  ChatListResponse({this.chatList,this.error,this.singleUser,this.userDisconnected,this.userid});
}
