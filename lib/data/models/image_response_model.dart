// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

/* {
    "status": "upload successfully",
    "image_path": "/upload/images1695646568.jpg",
    "base_url": "http://localhost:8000"
} */

class ImageResponseModel {
  final String imagePath;
  final String baseUrl;
  ImageResponseModel({
    required this.imagePath,
    required this.baseUrl,
  });

  ImageResponseModel copyWith({
    String? imagePath,
    String? baseUrl,
  }) {
    return ImageResponseModel(
      imagePath: imagePath ?? this.imagePath,
      baseUrl: baseUrl ?? this.baseUrl,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'imagePath': imagePath,
      'baseUrl': baseUrl,
    };
  }

  factory ImageResponseModel.fromMap(Map<String, dynamic> map) {
    return ImageResponseModel(
      imagePath: map['image_path'] ?? '',
      baseUrl: map['base_url'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ImageResponseModel.fromJson(String source) =>
      ImageResponseModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'ImageResponseModel(imagePath: $imagePath, baseUrl: $baseUrl)';

  @override
  bool operator ==(covariant ImageResponseModel other) {
    if (identical(this, other)) return true;

    return other.imagePath == imagePath && other.baseUrl == baseUrl;
  }

  @override
  int get hashCode => imagePath.hashCode ^ baseUrl.hashCode;
}
