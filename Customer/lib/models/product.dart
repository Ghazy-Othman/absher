//
//
//
import 'package:mobile/constants/api_constants.dart';
import 'package:mobile/models/vendor.dart';

class Product {
  ///s
  int? id;
  String? name;
  int? vendorId;
  Vendor? vendor;
  int? price;
  String? description;
  String? image;

  ///
  Product({
    this.id,
    this.name,
    this.price,
    this.description,
    this.image,
    this.vendorId,
    this.vendor,
  });

  ///
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      price: json['price'],
      description: json['description'],
      image: json['image'],
      vendorId: json['vendor_id'],
      vendor: json['vendor'] != null ? Vendor.fromJson(json['vendor']) : null,
    );
  }

  ///
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'image': image,
    };
  }

  String get getImage {
    if (image == null || image!.isEmpty) return "";
    if (image!.startsWith("http")) return image!;
    final domain = ApiConstants.baseUrl.replaceFirst("/api/v1", "");
    return "$domain/storage/$image";
  }
}
