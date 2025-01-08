import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hr_test/screens/movie-detail-screen.dart';
import 'package:hr_test/screens/search-screen.dart';
import '../controller/movie-controller.dart';
import '../theme/app-colors.dart';
import '../theme/fonts.dart';

class MovieScreen extends StatefulWidget {


  MovieScreen({super.key});

  @override
  _MovieScreenState createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen> {
  final MovieController movieController = Get.put(MovieController());

  @override
  void initState() {
    super.initState();
    // Delay the fetchMoviesByGenre call until the current build cycle is done
    WidgetsBinding.instance.addPostFrameCallback((_) {
      movieController.fetchMovies(); // Fetch movies after the build phase
    });
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text('Watch',style: AppFonts.textStyle(context, 16, FontWeight.w500, AppColors.black),),
        actions: [
          IconButton(
            icon: Icon(Icons.search,color: AppColors.black),
            onPressed: () {
              Get.to(SearchScreen());
            },
          )
        ],
      ),
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,

          currentIndex: 1, // Highlight the "Watch" tab
          backgroundColor: AppColors.bottomBackgroundColor, // Set the background color
          selectedItemColor: AppColors.whiteColor, // Set the selected tab's color to white
          unselectedItemColor: AppColors.bottomUnselectedColor, // Set the unselected tabs' color
          unselectedLabelStyle: AppFonts.textStyle(context, 10, FontWeight.w700, AppColors.bottomUnselectedColor),
          selectedLabelStyle: AppFonts.textStyle(context, 10, FontWeight.w700, AppColors.whiteColor),
          items: [
            BottomNavigationBarItem(
              icon: SvgPicture.asset('assets/icons/dashboard.svg', ),
              label: 'Dashboard',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset('assets/icons/watch.svg', ),
              label: 'Watch',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset('assets/icons/media.svg',),
              label: 'Media Library',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset('assets/icons/list.svg',),
              label: 'More',
            ),
          ],
          onTap: (index) {
            // Handle tab changes
          },
        ),
      ),

        body: Obx(() {
        if (movieController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Movie Categories (Genres)
              /*Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Categories',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 120, // Height for the genres list
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: movieController.genres.length,
                  itemBuilder: (context, index) {
                    final genre = movieController.genres[index];
                    return GestureDetector(
                      onTap: () {
                        // Handle category click
                      },
                      child: Container(
                        margin: EdgeInsets.all(8),
                        width: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.blue,
                        ),
                        child: Center(
                          child: Text(
                            genre.name,
                            style: TextStyle(color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 20),*/

              ListView.builder(
                shrinkWrap: true, // Make the list fit within the scroll view
                physics: NeverScrollableScrollPhysics(), // Disable scrolling for list
                itemCount: movieController.movies.length,
                itemBuilder: (context, index) {
                  final movie = movieController.movies[index];
                  return GestureDetector(
                    onTap: () {
                     Get.to(MovieDetailScreen(movieId: movie.id));
                    },
                    child: Card(
                      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Stack(
                          children: [
                            Image.network(
                              'https://image.tmdb.org/t/p/w500' + movie.posterPath,
                              width: double.infinity,
                              height: 180, // Adjust height to your preference
                              fit: BoxFit.cover,
                            ),
                            Positioned(
                              bottom: 10,
                              left: 10,
                              child: Text(
                                movie.title,
                                style: AppFonts.textStyle(context, 18, FontWeight.w500, AppColors.whiteColor)
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        );
      }),
    );
  }

}

