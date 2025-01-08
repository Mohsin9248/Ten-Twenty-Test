import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/genre.dart';


class ApiService {
  final String baseUrl = 'https://api.themoviedb.org/3'; // Example API
  final String apiKey = 'bc099c494408cf40ac32367e5cbc39a6'; // Replace with your API key from TMDb

  // Fetch Movies by Genre ID
  Future<List<Movie>> fetchMovies() async {
    final response = await http.get(
      Uri.parse('$baseUrl/movie/upcoming?api_key=$apiKey'),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      List<Movie> movies = (data['results'] as List)
          .map((movieJson) => Movie.fromJson(movieJson))
          .toList();
      return movies;
    } else {
      throw Exception('Failed to load movies');
    }
  }


  // Fetch movie details
  Future<Map<String, dynamic>> fetchMovieDetails(int movieId) async {
    final response = await http.get(
      Uri.parse('https://api.themoviedb.org/3/movie/$movieId?api_key=$apiKey'),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);  // Return the movie details as a map
    } else {
      throw Exception('Failed to load movie details');
    }
  }

  // Fetch trailer URL
  Future<String> fetchTrailerUrl(int movieId) async {
    final response = await http.get(
      Uri.parse('https://api.themoviedb.org/3/movie/$movieId/videos?api_key=$apiKey'),
    );

    print(Uri.parse('https://api.themoviedb.org/3/movie/$movieId/videos?api_key=$apiKey'));

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      print(jsonResponse);
      print("jsonResponse");
      if (jsonResponse['results'].isNotEmpty) {
        return jsonResponse['results'][0]['key'];  // Return the trailer key
      } else {
        throw Exception('Trailer not found');
      }
    } else {
      throw Exception('Failed to load trailer');
    }
  }

  // Fetch Genres
  Future<List<Genre>> fetchGenres() async {
    final response = await http.get(
      Uri.parse('$baseUrl/genre/movie/list?api_key=$apiKey&language=en-US'),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      List<Genre> genres = (data['genres'] as List)
          .map((genreJson) => Genre.fromJson(genreJson))
          .toList();
      return genres;
    } else {
      throw Exception('Failed to load genres');
    }
  }
}
