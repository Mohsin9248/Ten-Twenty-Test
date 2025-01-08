import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// Genre Model
class Genre {
  final int id;
  final String name;
  final String? imageUrl; // Optional field for image URL

  Genre({required this.id, required this.name, this.imageUrl});

  factory Genre.fromJson(Map<String, dynamic> json) {
    return Genre(
      id: json['id'],
      name: json['name'],
      imageUrl: json['backdrop_path'] != null
          ? json['backdrop_path']
          : json['backdrop_path'], // Or use 'poster_path' if needed
    );
  }
}

// Movie Model
class Movie {
  final int id;
  final String title;
  final String posterPath;

  Movie({required this.id,required this.title, required this.posterPath});

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'],
      title: json['title'],
      posterPath: json['poster_path'],
    );
  }
}

