// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class CarouselModel {
  final String title;
  final String imageUrl;
  final String locationTitle;
  
  CarouselModel({
    required this.title,
    required this.imageUrl,
    required this.locationTitle,
  });

  CarouselModel copyWith({
    String? title,
    String? imageUrl,
    String? locationTitle,
  }) {
    return CarouselModel(
      title: title ?? this.title,
      imageUrl: imageUrl ?? this.imageUrl,
      locationTitle: locationTitle ?? this.locationTitle,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'imageUrl': imageUrl,
      'locationTitle': locationTitle,
    };
  }

  factory CarouselModel.fromMap(Map<String, dynamic> map) {
    return CarouselModel(
      title: map['title'] as String,
      imageUrl: map['imageUrl'] as String,
      locationTitle: map['locationTitle'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory CarouselModel.fromJson(String source) =>
      CarouselModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'CarouselModel(title: $title, imageUrl: $imageUrl, locationTitle: $locationTitle)';

  @override
  bool operator ==(covariant CarouselModel other) {
    if (identical(this, other)) return true;

    return other.title == title &&
        other.imageUrl == imageUrl &&
        other.locationTitle == locationTitle;
  }

  @override
  int get hashCode =>
      title.hashCode ^ imageUrl.hashCode ^ locationTitle.hashCode;
}
