// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class GridViewModel {
  final int id;
  final String title;
  final String description;
  final String imageUrl;

  GridViewModel({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
  });

  GridViewModel copyWith({
    int? id,
    String? title,
    String? description,
    String? imageUrl,
  }) {
    return GridViewModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
      'imageUrl': imageUrl,
    };
  }

  factory GridViewModel.fromMap(Map<String, dynamic> map) {
    return GridViewModel(
      id: map['id'] as int,
      title: map['title'] as String,
      description: map['description'] as String,
      imageUrl: map['imageUrl'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory GridViewModel.fromJson(String source) =>
      GridViewModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'GridViewModel(id: $id, title: $title, description: $description, imageUrl: $imageUrl)';
  }

  @override
  bool operator ==(covariant GridViewModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.title == title &&
      other.description == description &&
      other.imageUrl == imageUrl;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      title.hashCode ^
      description.hashCode ^
      imageUrl.hashCode;
  }
}
