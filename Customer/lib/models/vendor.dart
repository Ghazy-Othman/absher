//
//
//
import 'package:mobile/constants/api_constants.dart';

class Vendor {
  ///
  int? id;
  String? email;
  String? phone;
  String? name;
  String? avatar;
  String? address;
  String? avatarPath;

  ///
  Vendor({
    this.id,
    this.name,
    this.phone,
    this.email,
    this.avatar,
    this.address,
    this.avatarPath,
  });

  ///
  factory Vendor.fromJson(Map<String, dynamic> json) {
    return Vendor(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone '],
      avatar: json['avatar'],
      address: json['address'],
      avatarPath: json['avatar_path'] ?? "",
    );
  }

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
