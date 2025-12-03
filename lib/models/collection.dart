// lib/models/collection.dart
class Collection {
  final String id;
  final String name;
  final String slug;
  final String description;
  final String image;

  Collection({
    required this.id,
    required this.name,
    required this.slug,
    required this.description,
    required this.image,
  });

  factory Collection.fromJson(Map<String, dynamic> json) {
    return Collection(
      id: json['id'] as String,
      name: json['name'] as String,
      slug: json['slug'] as String,
      description: json['description'] as String,
      image: json['image'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'slug': slug,
      'description': description,
      'image': image,
    };
  }
}
