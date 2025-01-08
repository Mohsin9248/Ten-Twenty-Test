import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hr_test/screens/video-player-screen.dart';
import 'package:hr_test/theme/app-colors.dart';
import 'package:hr_test/theme/fonts.dart';
import '../controller/movie-controller.dart';
import '../widgets/button-style.dart';
import 'book-ticket.dart';

class MovieDetailScreen extends StatefulWidget {
  final int movieId; // Movie ID passed from the list screen

  MovieDetailScreen({required this.movieId});

  @override
  _MovieDetailScreenState createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  late MovieController movieController;

  @override
  void initState() {
    super.initState();
    // Initialize the movie controller and fetch movie details and trailer
    movieController = Get.find<MovieController>();
    Future.delayed(Duration.zero, () {
      movieController.fetchMovieDetails(widget.movieId);
      movieController.fetchTrailer(widget.movieId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: AppColors.whiteColor,size: 16,),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Watch',style: AppFonts.textStyle(context, 16, FontWeight.w500, AppColors.whiteColor),),
      ),
      body: Obx(() {
        // Show loading indicator while fetching data
        if (movieController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        // Check if movie details are loaded
        if (!movieController.isMovieDetailsLoaded.value) {
          return Center(child: Text('Failed to load movie details.'));
        }

        // Get the movie details and trailer URL
        final movieDetails = movieController.movieDetails.value;
        final trailerUrl = movieController.trailerUrl.value;


        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Stack to show Movie Poster Image, Release Date, and Buttons
              Stack(
                children: [
                  // Movie Poster Image
                  Image.network(
                    movieDetails['poster_path'] != null
                        ? 'https://image.tmdb.org/t/p/w500${movieDetails['poster_path']}'
                        : 'https://via.placeholder.com/500x750', // Placeholder if no image
                    width: double.infinity,
                    height: 400,
                    fit: BoxFit.cover,
                  ),
                  // In-theater release date and buttons
                  Positioned(
                    bottom: 16,
                    left: 16,
                    right: 16,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // In-theater release date
                        Center(
                          child: Text(
                            'In Theaters: ${movieDetails['release_date'] ?? 'Unknown'}',
                            style: AppFonts.textStyle(context, 16, FontWeight.w500, AppColors.whiteColor)
                          ),
                        ),
                        SizedBox(height: 8),

                        // Watch Trailer and Book Ticket Buttons
                        Column(
                          children: [
                            // Watch Trailer Button
                            ElevatedButton(
                              style: customElevatedButtonStyle(
                                height: MediaQuery.of(context).size.height / 16,
                                width: MediaQuery.of(context).size.width / 1.8,
                              ),
                              onPressed: () {
                                // Navigate to booking screen (to be implemented)
                                Get.to(MovieBookingScreen());
                              },
                              child: Text('Book Ticket',style: AppFonts.textStyle(context, 14, FontWeight.w600, AppColors.whiteColor),),
                            ),
                            SizedBox(height: 12),
                            ElevatedButton(
                              style: customElevatedButtonStyleTransparent(
                                height: MediaQuery.of(context).size.height / 16,
                                width: MediaQuery.of(context).size.width / 1.8, // Fixed button width
                              ),
                              onPressed: () {
                                if (trailerUrl.isNotEmpty) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => VideoPlayerScreen(videoKey: trailerUrl),
                                    ),
                                  );
                                } else {
                                  Get.snackbar('No Trailer', 'Trailer URL not available.');
                                }
                              },
                              child: FittedBox(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center, // Center icon and text
                                  children: [
                                    Icon(
                                      Icons.play_arrow, // Play button icon
                                      color: AppColors.whiteColor,
                                      size: 20,
                                    ),
                                    SizedBox(width: 8), // Add some space between the icon and text
                                    Text(
                                      'Watch Trailer',
                                      style: AppFonts.textStyle(context, 14, FontWeight.w600, AppColors.whiteColor),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            // Book Ticket Button

                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              // Movie Title
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Genres", style: AppFonts.textStyle(context, 18, FontWeight.w500, AppColors.black)),
                    SizedBox(height: 8),

                    // Movie Genres in Tags
                    Wrap(
                      spacing: 6.0,
                      runSpacing: 2.0,
                      children: movieDetails['genres'] != null
                          ? (movieDetails['genres'] as List).asMap().entries.map((entry) {
                        int index = entry.key;
                        var genre = entry.value;

                        // Define a list of colors
                        List<Color> chipColors = [AppColors.green,AppColors.golden, AppColors.pink,AppColors.purple];

                        // Cycle through colors based on index
                        Color chipColor = chipColors[index % chipColors.length];

                        return Chip(
                          label: Text(
                            genre['name'] ?? '',
                            style: AppFonts.textStyle(
                                context, 10, FontWeight.w600, AppColors.whiteColor),
                          ),
                          backgroundColor: chipColor, // Apply different colors
                        );
                      }).toList()
                          : [Text('No Genres')],
                    ),
                    SizedBox(height: 8),
                    Divider(color: AppColors.grey,),
                    SizedBox(height: 8),
                    Text("Overview", style: AppFonts.textStyle(context, 18, FontWeight.w500, AppColors.black)),
                    SizedBox(height: 12),
                    // Movie Description
                    Text(
                      movieDetails['overview'] ?? 'No Description available.',
                      style: AppFonts.textStyle(context, 12, FontWeight.w400, AppColors.greyWritingColor),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
