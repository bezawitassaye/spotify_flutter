import 'package:spotify/features/blog/domain/entities/blog.dart';

class BlogModel extends Blog {
  BlogModel({
    required super.id,
    required super.posterId,
    required super.title,
    required super.content,
    required super.imageUrl,
    required super.topics,
    required super.updatedAt,
  });

/// ✅ Create a Blog object from a Map (e.g., from database or JSON)
  factory BlogModel.fromJson(Map<String, dynamic> map) {
    return BlogModel(
      id: map['id'] ?? '',
      posterId: map['poster_id'] ?? '',
      title: map['title'] ?? '',
      content: map['content'] ?? '',
      imageUrl: map['image_url'] ?? '',
      topics: map['topics'] != null
          ? List<String>.from(map['topics'])
          : [],
      updatedAt: map['updated_at'] == null ?
          DateTime.now() :      
          DateTime.parse(map['updated_at'])
    );
  }

  /// ✅ Convert a Blog object back into a Map (for uploading/saving)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'poster_id': posterId,
      'title': title,
      'content': content,
      'image_url': imageUrl,
      'topics': topics,
      'updated_at': updatedAt.toIso8601String(),
    };
  }

}
