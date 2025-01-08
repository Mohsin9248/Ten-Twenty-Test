import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/movie-controller.dart';
import 'movie-screen.dart';

class GenreScreen extends StatelessWidget {
  final MovieController movieController = Get.put(MovieController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Genres'),
      ),
      body: Obx(() {
        if (movieController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        return GridView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: movieController.genres.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
          ),
          itemBuilder: (context, index) {
            final genre = movieController.genres[index];
            return GestureDetector(
              onTap: () {
                // Navigate to movies list for the selected genre
                //Get.to(() => MoviesByGenreScreen(genreId: genre.id, genreName: genre.name));
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.blue,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Add an image for the genre
                    InkWell(
                      onTap: (){
                        print("https://image.tmdb.org/t/p/w500${genre.imageUrl}");
                      },
                      child: Image.network(
                        genre.imageUrl != null
                            ? 'https://image.tmdb.org/t/p/w500${genre.imageUrl}' // Actual image URL from genre object
                            : 'https://via.placeholder.com/150', // A placeholder image if no image URL is available
                        width: 50, // Set the desired width for the image
                        height: 50, // Set the desired height for the image
                        fit: BoxFit.cover, // Ensure the image fits within the bounds
                      ),
                    ),
                    SizedBox(height: 8), // Space between the image and text
                    Text(
                      genre.name,
                      style: TextStyle(color: Colors.white, fontSize: 18),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),

              ),
            );
          },
        );
      }),
    );
  }

}
