import 'package:cloud_firestore/cloud_firestore.dart';
import '../../user/model/user_model.dart';

class PostModel {
  final UserModel user;
  final DateTime createdAt;
  final String content;
  final String? image;
  final int likes;
  final int views;

  const PostModel({
    required this.user,
    required this.createdAt,
    required this.content,
    this.image,
    this.likes = 0,
    this.views = 0,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          (other is PostModel &&
              runtimeType == other.runtimeType &&
              user == other.user &&
              createdAt == other.createdAt &&
              content == other.content &&
              image == other.image &&
              likes == other.likes &&
              views == other.views);

  @override
  int get hashCode =>
      user.hashCode ^
      createdAt.hashCode ^
      content.hashCode ^
      (image?.hashCode ?? 0) ^
      likes.hashCode ^
      views.hashCode;

  @override
  String toString() {
    return 'PostModel{' +
        ' user: ${user.toMap()},' +
        ' createdAt: $createdAt,' +
        ' content: $content,' +
        ' image: $image,' +
        ' likes: $likes,' +
        ' views: $views,' +
        '}';
  }

  PostModel copyWith({
    UserModel? user,
    DateTime? createdAt,
    String? content,
    String? image,
    int? likes,
    int? views,
  }) {
    return PostModel(
      user: user ?? this.user,
      createdAt: createdAt ?? this.createdAt,
      content: content ?? this.content,
      image: image ?? this.image,
      likes: likes ?? this.likes,
      views: views ?? this.views,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'user': user.toMap(), // Chuyển đổi UserModel sang Map
      'createdAt': Timestamp.fromDate(createdAt),
      'content': content,
      'image': image,
      'likes': likes,
      'views': views,
    };
  }

  factory PostModel.fromMap(Map<String, dynamic> map) {
    return PostModel(
      user: UserModel.fromMap(map['user'] as Map<String, dynamic>), // Chuyển đổi từ Map sang UserModel
      createdAt: (map['createdAt'] is Timestamp)
          ? (map['createdAt'] as Timestamp).toDate()
          : DateTime.parse(map['createdAt'] as String),
      content: map['content'] as String,
      image: map['image'] as String?,
      likes: map['likes'] as int? ?? 0,
      views: map['views'] as int? ?? 0,
    );
  }
}
