//
//
//
import 'package:mobile/constants/api_constants.dart';

class User {
  final int id;
  final String name;
  final String email;
  final String? avatar;
  final String? address;

  final String? avatarPath;

  User({
    required this.id,
    required this.name,
    required this.email,
    this.avatar,
    this.address,
    this.avatarPath,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json['id'],
    name: json['name'] ?? 'name',
    email: json['email'] ?? 'email',
    avatar: json['avatar'] ?? "",
    address: json['address'] ?? "",
    avatarPath: json['avatar_path'] ?? "",
  );

  String get image {
    if (avatarPath != null && avatarPath!.isNotEmpty) {
      return avatarPath!.replaceFirst(
        "http://127.0.0.1:8000/",
        ApiConstants.baseUrl.replaceFirst("api/v1", ""),
      );
    }
    return "";
  }
}
