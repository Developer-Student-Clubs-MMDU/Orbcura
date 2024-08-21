import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:orbcura_app/app_state.dart';
import 'package:orbcura_app/screens/chats.dart';
import 'package:orbcura_app/screens/insta.dart';
import 'package:orbcura_app/screens/qr_camscan.dart';
import 'package:orbcura_app/screens/qr_scan.dart';
import 'package:orbcura_app/widgets/four_corner_screen.dart';
import 'package:provider/provider.dart';

class SplashNavScreen extends StatefulWidget {
  const SplashNavScreen({super.key});

  @override
  State<SplashNavScreen> createState() => _SplashNavScreenState();
}

class _SplashNavScreenState extends State<SplashNavScreen> {
  void _onUpiButtonTap() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => QrCamScanPage()),
    );
  }

  void _onIButtonTap() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => InstaScreen()),
    );
  }

  void _onWButtonTap() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ChatsScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.sizeOf(context).height;
    var w = MediaQuery.sizeOf(context).width;

    return FourCornerScreen(
      CornerChild(
        Image.asset(
          "assets/mic.png",
          height: h / 16,
        ),
        () {},
      ),
      CornerChild(
        Image.asset(
          "assets/communicate.png",
          height: h / 16,
        ),
        () {
          Provider.of<AppState>(context, listen: false).tts.speak(
              "Firstly, Tap on either right side or left side of the screen to open smart camera to describe what your camera sees !! Now, If you tap on the center of screen you can pay money through Smart UPI method ");
        },
      ),
      CornerChild(
        Image.asset(
          "assets/home.png",
          height: h / 16,
        ),
        () {},
      ),
      CornerChild(
        Image.asset(
          "assets/back.png",
          height: h / 16,
        ),
        () {},
      ),
      Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Image.asset(
              'assets/background_splash_nav.png',
              fit: BoxFit.cover,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Spacer(flex: 7),
                Image.asset(
                  'assets/app_logo.png',
                  width: w / 2,
                  height: h / 4,
                ),
                SizedBox(height: 20),
                InkWell(
                  onTap: _onUpiButtonTap,
                  child: Image.asset(
                    'assets/upi_button.png',
                    width: w / 2,
                    height: h / 1.5,
                  ),
                ),
                Spacer(flex: 100),
              ],
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 0), // Adjust padding if needed
                child: InkWell(
                  onTap: _onIButtonTap,
                  child: Image.asset(
                    'assets/Camera1.png',
                    width: w / 4,
                    height: h / 1.5,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: EdgeInsets.only(right: 0), // Adjust padding if needed
                child: InkWell(
                  onTap: _onWButtonTap,
                  child: Image.asset(
                    'assets/Camera2.png',
                    width: w / 4,
                    height: h / 1.5,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
