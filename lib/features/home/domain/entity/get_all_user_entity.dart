
import 'package:wechat/common/entities/user.dart';

class GetAllUserEntity {
  final List<User> users;
  final Map<String, dynamic> unseen;
  GetAllUserEntity({required this.users, required this.unseen});
}
