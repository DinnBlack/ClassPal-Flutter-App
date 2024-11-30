import 'package:cloud_firestore/cloud_firestore.dart'; // Đảm bảo bạn đã import thư viện này

class PostModel {
  final String userId;
  final DateTime createdAt;
  final String content;
  final String? image;
  final int likes; // Số lượt thích
  final int views; // Số lượt xem

  const PostModel({
    required this.userId,
    required this.createdAt,
    required this.content,
    this.image,
    this.likes = 0, // Mặc định là 0
    this.views = 0, // Mặc định là 0
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          (other is PostModel &&
              runtimeType == other.runtimeType &&
              userId == other.userId &&
              createdAt == other.createdAt &&
              content == other.content &&
              image == other.image &&
              likes == other.likes &&
              views == other.views);

  @override
  int get hashCode =>
      userId.hashCode ^
      createdAt.hashCode ^
      content.hashCode ^
      (image?.hashCode ?? 0) ^
      likes.hashCode ^
      views.hashCode;

  @override
  String toString() {
    return 'PostModel{' +
        ' userId: $userId,' +
        ' createdAt: $createdAt,' +
        ' content: $content,' +
        ' image: $image,' +
        ' likes: $likes,' +
        ' views: $views,' +
        '}';
  }

  PostModel copyWith({
    String? userId,
    DateTime? createdAt,
    String? content,
    String? image,
    int? likes,
    int? views,
  }) {
    return PostModel(
      userId: userId ?? this.userId,
      createdAt: createdAt ?? this.createdAt,
      content: content ?? this.content,
      image: image ?? this.image,
      likes: likes ?? this.likes,
      views: views ?? this.views,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'createdAt': Timestamp.fromDate(createdAt), // Chuyển đổi DateTime sang Timestamp
      'content': content,
      'image': image,
      'likes': likes, // Thêm số lượt thích
      'views': views, // Thêm số lượt xem
    };
  }

  factory PostModel.fromMap(Map<String, dynamic> map) {
    return PostModel(
      userId: map['userId'] as String,
      createdAt: (map['createdAt'] is Timestamp)
          ? (map['createdAt'] as Timestamp).toDate() // Chuyển đổi từ Timestamp sang DateTime
          : DateTime.parse(map['createdAt'] as String), // Nếu là String, chuyển đổi
      content: map['content'] as String,
      image: map['image'] as String?,
      likes: map['likes'] as int? ?? 0, // Mặc định là 0 nếu không có
      views: map['views'] as int? ?? 0, // Mặc định là 0 nếu không có
    );
  }
}