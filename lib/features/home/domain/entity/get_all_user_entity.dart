import 'package:wechat/common/entities/user.dart';

class GetAllUserEntity {
  final List<User> users;
  final Map<String, dynamic> unseen;
  GetAllUserEntity({required this.users, required this.unseen});
  GetAllUserEntity copyWith({List<User>? users, Map<String, int>? unseen}) {
    return GetAllUserEntity(
      users: users ?? this.users,
      unseen: unseen ?? this.unseen,
    );
  }
}
