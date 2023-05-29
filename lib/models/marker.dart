class MarkerModel {
  final String name;
  final double radius;
  final double latitude;
  final double longitude;
  final String state;
  final List<SubCategory> subCategories;
  final List<Tag> tags;

  MarkerModel({
    required this.name,
    required this.radius,
    required this.latitude,
    required this.longitude,
    required this.state,
    required this.subCategories,
    required this.tags,
  });

  factory MarkerModel.fromJson(Map<String, dynamic> json) {
    return MarkerModel(
      name: json['name'],
      radius: json['radius'].toDouble(),
      latitude: json['latitude'].toDouble(),
      longitude: json['longitude'].toDouble(),
      state: json['state'],
      subCategories: (json['subCategories'] as List)
          .map((e) => SubCategory.fromJson(e))
          .toList(),
      tags: (json['tags'] as List).map((e) => Tag.fromJson(e)).toList(),
    );
  }
}

class SubCategory {
  final String name;
  final dynamic icon;
  final Category category;

  SubCategory({required this.name, this.icon, required this.category});

  factory SubCategory.fromJson(Map<String, dynamic> json) {
    return SubCategory(
      name: json['name'],
      icon: json['icon'],
      category: Category.fromJson(json['category']),
    );
  }
}

class Category {
  final String name;
  final String icon;

  Category({required this.name, required this.icon});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      name: json['name'],
      icon: json['icon'],
    );
  }
}

class Tag {
  final String name;

  Tag({required this.name});

  factory Tag.fromJson(Map<String, dynamic> json) {
    return Tag(
      name: json['name'],
    );
  }
}
