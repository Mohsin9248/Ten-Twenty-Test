import 'package:flutter/material.dart';
import 'package:hr_test/widgets/button-style.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPlayerScreen extends StatefulWidget {
  final String videoKey; // The YouTube video ID

  VideoPlayerScreen({required this.videoKey});

  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();

    // Initialize the YouTube player controller with the video ID
    _controller = YoutubePlayerController(
      initialVideoId: widget.videoKey,
      flags: YoutubePlayerFlags(
        autoPlay: true,
        mute: false,  // Mute or unmute the video
      ),
    );

    // Add a listener to check when the video ends
    _controller.addListener(() {
      if (_controller.value.playerState == PlayerState.ended) {
        // Video finished, pop the screen to return to the movie details screen
        Navigator.of(context).pop();
      }
    });
  }

  @override
  void dispose() {
    // Dispose of the controller when the screen is closed
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Remove the app bar for full-screen experience
      appBar: null,
      body: Stack(
        children: [
          // Full-screen YouTube video player
          Positioned.fill(
            child: YoutubePlayer(
              controller: _controller,
              showVideoProgressIndicator: true,
              onReady: () {
                // Auto-play video when the player is ready
                _controller.play();
              },
            ),
          ),
          // "Done" button placed at the top-left corner to manually close the player
          Positioned(
            top: 40,
            left: 16,
            child: ElevatedButton(
              style: customElevatedButtonStyle(height: MediaQuery.of(context).size.height/20, width: MediaQuery.of(context).size.width/4),
              onPressed: () {
                // Close the video player manually when "Done" is pressed
                Navigator.of(context).pop(); // Close the video player and return to details
              },
              child: Text('Done'),
            ),
          ),
        ],
      ),
    );
  }
}
