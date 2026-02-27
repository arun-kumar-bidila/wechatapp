import 'package:wechat/features/auth/domain/entities/user.dart';

class UserModel extends User {
  UserModel({
    required super.email,
    required super.fullName,
    required super.bio,
    required super.profilePic,
  });

  factory UserModel.fromJson(Map<String, dynamic> map) {
    return UserModel(
      email: map["email"],
      fullName: map["fullName"],
      bio: map["bio"],
      profilePic: map["profilePic"],
    );
  }
}
