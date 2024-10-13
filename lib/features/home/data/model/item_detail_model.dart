// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class DetailModel {
  final String id;
  final String title;
  final String location;
  final String category;
  final String season;
  final double rating;
  final List<String> imageUrls;
  final String description;
  final String suggestionNote;
  DetailModel({
    required this.id,
    required this.title,
    required this.location,
    required this.category,
    required this.season,
    required this.rating,
    required this.imageUrls,
    required this.description,
    required this.suggestionNote,
  });

  DetailModel copyWith({
    String? id,
    String? title,
    String? location,
    String? category,
    String? season,
    double? rating,
    List<String>? imageUrls,
    String? description,
    String? suggestionNote,
  }) {
    return DetailModel(
      id: id ?? this.id,
      title: title ?? this.title,
      location: location ?? this.location,
      category: category ?? this.category,
      season: season ?? this.season,
      rating: rating ?? this.rating,
      imageUrls: imageUrls ?? this.imageUrls,
      description: description ?? this.description,
      suggestionNote: suggestionNote ?? this.suggestionNote,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'location': location,
      'category': category,
      'season': season,
      'rating': rating,
      'imageUrls': imageUrls,
      'description': description,
      'suggestionNote': suggestionNote,
    };
  }

  factory DetailModel.fromMap(Map<String, dynamic> map) {
    return DetailModel(
      id: map['id'] as String,
      title: map['title'] as String,
      location: map['location'] as String,
      category: map['category'] as String,
      season: map['season'] as String,
      rating: map['rating'] as double,
      imageUrls: List<String>.from((map['imageUrls'] as List<String>)),
      description: map['description'] as String,
      suggestionNote: map['suggestionNote'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory DetailModel.fromJson(String source) =>
      DetailModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'DetailModel(id: $id, title: $title, location: $location, category: $category, season: $season, rating: $rating, imageUrls: $imageUrls, description: $description, suggestionNote: $suggestionNote)';
  }

  @override
  bool operator ==(covariant DetailModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.title == title &&
        other.location == location &&
        other.category == category &&
        other.season == season &&
        other.rating == rating &&
        listEquals(other.imageUrls, imageUrls) &&
        other.description == description &&
        other.suggestionNote == suggestionNote;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        location.hashCode ^
        category.hashCode ^
        season.hashCode ^
        rating.hashCode ^
        imageUrls.hashCode ^
        description.hashCode ^
        suggestionNote.hashCode;
  }
}
