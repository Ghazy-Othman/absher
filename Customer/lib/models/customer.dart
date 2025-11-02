//
//
//
import 'package:mobile/constants/api_constants.dart';

class Customer {
  ///
  final int id;
  final String name;
  String? avatar;
  String? avatarPath;

  ///
  Customer({
    required this.id,
    required this.name,
    this.avatar,
    this.avatarPath,
  });

  ///
  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      id: json['id'],
      name: json['name'],
      avatar: json['avatar'] ?? "",
      avatarPath: json['avatar_path'] ?? "",
    );
  }

  ///
  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'avatar': avatar,
    "avatar_path": avatarPath,
  };


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
