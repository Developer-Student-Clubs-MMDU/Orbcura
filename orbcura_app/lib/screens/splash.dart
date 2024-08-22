import 'package:flutter/material.dart';
import 'package:orbcura_app/screens/language.dart';
import 'package:video_player/video_player.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late VideoPlayerController _controller;
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _controller = VideoPlayerController.asset('assets/splash_vid.mp4')
      ..initialize().then((_) {
        setState(() {});
        _controller.play();
      });

    // Initialize fade animation controller
    _fadeController = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    );
    _fadeAnimation = Tween(begin: 0.0, end: 1.0).animate(_fadeController);

    _controller.addListener(() {
      final isPlaying = _controller.value.isPlaying;
      final isEnding = _controller.value.position >=
          _controller.value.duration - Duration(seconds: 1);

      if (isPlaying && isEnding) {
        _fadeController.forward(); // Start the fade-in animation
      }

      if (_fadeController.isCompleted) {
        _navigateToLanguagePage(); // Navigate to the next page after the fade animation
      }
    });
  }

  void _navigateToLanguagePage() {
    Navigator.of(context).pushReplacement(_createRoute());
  }

  Route _createRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => LanguagePage(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          _controller.value.isInitialized
              ? AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: VideoPlayer(_controller),
                )
              : Center(child: CircularProgressIndicator()),
          FadeTransition(
            opacity: _fadeAnimation,
            child: Container(
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

