//
//
//
class Product {
  final int id;
  final String name;
  final double price;
  final String? description;
  final int vendorId;
  final String? image;

  Product({
    required this.id,
    required this.name,
    required this.price,
    this.description,
    required this.vendorId,
    this.image,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json['id'],
    name: json['name'],
    price: (json['price'] as num).toDouble(),
    description: json['description'],
    vendorId: json['vendor_id'],
    image: json['image'],
  );
}
