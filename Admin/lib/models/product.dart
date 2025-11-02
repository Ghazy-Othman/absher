//
//
//
class Product {
  ///
  int? id;

  String? name;

  int? categoryId;

  int? price;

  int? vendorId;

  String? description;

  String? image ;

  Product({this.id, this.name, this.vendorId, this.price, this.description , this.image , this.categoryId});

  ///
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      categoryId: json['category_id'],
      name: json['name'],
      vendorId: json['vendorId'],
      price: json['price'],
      description: json['description'],
      image: json['image'],
    );
  }

  ///
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'category_id' : categoryId,
      'name': name,
      'vendor_id': vendorId,
      'price': price,
      'description': description,
    };
  }



}
