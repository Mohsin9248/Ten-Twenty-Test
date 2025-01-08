import 'package:get/get.dart';
import '../api-service/api-service.dart';
import '../models/genre.dart';

class MovieController extends GetxController {
  var movies = <Movie>[].obs;
  var genres = <Genre>[].obs;
  var isLoading = true.obs;
  RxBool isMovieDetailsLoaded = false.obs;
  RxString trailerUrl = ''.obs;
  ApiService apiService = ApiService();
  var filteredMovies = <Movie>[].obs; // Filtered movies list


  @override
  void onInit() {
    super.onInit();
  }

  // Correctly initialize movieDetails without using .obs again
  Rx<Map<String, dynamic>> movieDetails = Rx<Map<String, dynamic>>({});

  // Fetch movie details
  Future<void> fetchMovieDetails(int movieId) async {
    isLoading.value = true;
    try {
      movieDetails.value = await apiService.fetchMovieDetails(movieId);
      isMovieDetailsLoaded.value = true;
    } catch (e) {
      Get.snackbar("Error", e.toString(), snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading.value = false;
    }
  }

  // Fetch trailer URL
  Future<void> fetchTrailer(int movieId) async {
    isLoading.value = true;
    try {
      trailerUrl.value = await apiService.fetchTrailerUrl(movieId);
    } catch (e) {
      Get.snackbar("Error", e.toString(), snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading.value = false;
    }
  }

  // Fetch movies list
  void fetchMovies() async {
    isLoading(true);
    try {
      var fetchedMovies = await apiService.fetchMovies();
      movies.assignAll(fetchedMovies);
    } finally {
      isLoading(false);
    }
  }

  void filterMovies(String query) {
    if (query.isEmpty) {
      filteredMovies.assignAll(movies);
    } else {
      filteredMovies.assignAll(movies.where((movie) => movie.title.toLowerCase().contains(query.toLowerCase())).toList());
    }
  }
}
