// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

/* {
    "name" : "Mie Gacoan 33 4",
    "description" : "Mie ini enak sekali",
    "price" : 15000,
    "image_url": "https://via.placeholder.com/200x200.png/005577?text=amet",
    "category_id": 2
} */

class ProductRequestModel {
  final String name;
  final String description;
  final int price;
  final String imageUrl;
  final int categoryId;
  ProductRequestModel({
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.categoryId,
  });

  ProductRequestModel copyWith({
    String? name,
    String? description,
    int? price,
    String? imageUrl,
    int? categoryId,
  }) {
    return ProductRequestModel(
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      imageUrl: imageUrl ?? this.imageUrl,
      categoryId: categoryId ?? this.categoryId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'description': description,
      'price': price,
      'image_Url': imageUrl,
      'category_id': categoryId,
    };
  }

  factory ProductRequestModel.fromMap(Map<String, dynamic> map) {
    return ProductRequestModel(
      name: map['name'] as String,
      description: map['description'] as String,
      price: map['price'] as int,
      imageUrl: map['imageUrl'] as String,
      categoryId: map['categoryId'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductRequestModel.fromJson(String source) =>
      ProductRequestModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ProductRequestModel(name: $name, description: $description, price: $price, imageUrl: $imageUrl, categoryId: $categoryId)';
  }

  @override
  bool operator ==(covariant ProductRequestModel other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.description == description &&
        other.price == price &&
        other.imageUrl == imageUrl &&
        other.categoryId == categoryId;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        description.hashCode ^
        price.hashCode ^
        imageUrl.hashCode ^
        categoryId.hashCode;
  }
}
