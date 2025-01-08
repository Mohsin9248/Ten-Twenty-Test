import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/movie-controller.dart';
import '../theme/app-colors.dart';
import '../theme/fonts.dart';
import 'movie-detail-screen.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final MovieController movieController = Get.put(MovieController());
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Initially load the movies and filter them with an empty query
    movieController.filterMovies('');  // Ensures filteredMovies is populated at the start

    // Listen for changes in the search text and filter the movie list
    searchController.addListener(() {
      movieController.filterMovies(searchController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: AppColors.black, size: 16),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Search Movies',
          style: AppFonts.textStyle(context, 16, FontWeight.w500, AppColors.black),
        ),
      ),
      body: SingleChildScrollView(  // Wrapping the entire body in a SingleChildScrollView
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: searchController,
                style: AppFonts.body(context),
                cursorColor: AppColors.greyWritingColor,
                onChanged: (query) {
                  movieController.filterMovies(query); // Filter the movies based on input
                },
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search, color: AppColors.black),
                  hintText: 'TV shows, movies and more',
                  hintStyle: AppFonts.textStyle(context, 14, FontWeight.w400, AppColors.hintColor),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(24.0)),
                    borderSide: BorderSide(
                      color: Colors.grey,
                      width: 1,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(24.0)),
                    borderSide: BorderSide(
                      color: Colors.grey,
                      width: 1,
                    ),
                  ),
                  contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  suffixIcon: searchController.text.isNotEmpty
                      ? IconButton(
                    icon: Icon(Icons.clear, color: AppColors.black),
                    onPressed: () {
                      searchController.clear();
                      movieController.filterMovies(''); // Reset the list when cleared
                    },
                  )
                      : null,
                ),
              ),
            ),
            Obx(() {
              final filteredMovies = movieController.filteredMovies;
              final resultsCount = filteredMovies.length;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Display top results count
                  if (resultsCount > 0)
                    Padding(
                      padding: const EdgeInsets.only(left: 32.0, top: 8, bottom: 8),
                      child: Text(
                        '$resultsCount results found',
                        style: AppFonts.textStyle(context, 14, FontWeight.w400, AppColors.black),
                      ),
                    ),
                  // Divider between the search input and list
                  Divider(color: Colors.grey),
                  // Display filtered movies
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.9,  // Constrain height if necessary
                    child: ListView.builder(
                      itemCount: filteredMovies.length,
                      itemBuilder: (context, index) {
                        final movie = filteredMovies[index];
                        return GestureDetector(
                          onTap: () {
                            Get.to(MovieDetailScreen(movieId: movie.id));
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListTile(
                              leading: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  'https://image.tmdb.org/t/p/w500' + movie.posterPath,
                                  width: 100,
                                  height: 140,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              title: Text(
                                movie.title,
                                style: AppFonts.textStyle(context, 16, FontWeight.w500, AppColors.black),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            }),
          ],
        ),
      ),
    );
  }
}
