import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:orbcura_app/app_state.dart';
import 'package:orbcura_app/screens/chats.dart';
import 'package:orbcura_app/screens/confirm_amount.dart';
import 'package:orbcura_app/screens/confirmation_screen.dart';
import 'package:orbcura_app/screens/home_screen.dart';
import 'package:orbcura_app/screens/language.dart';
import 'package:orbcura_app/screens/login.dart';
import 'package:orbcura_app/screens/pin_entry.dart';
import 'package:orbcura_app/screens/qr_camscan.dart';
import 'package:orbcura_app/screens/qr_scan.dart';
//import 'package:orbcura_app/screens/smart_cam.dart';
import 'package:orbcura_app/screens/splash.dart';
import 'package:orbcura_app/screens/splash_nav.dart';
import 'package:orbcura_app/utils/upi_uri_parser.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  Gemini.init(apiKey: 'AIzaSyBcuU6FiBqEQCaaGEJduwN4gZmsYkj11Ms');
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  runApp(MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => AppState())],
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,

      home: SplashScreen(),
      routes: {
        '/home': (context) => HomeScreen(),
        // '/splash':(context) => SplashScreen(),
        '/splash_nav': (context) => SplashNavScreen(),
        '/login': (context) => LoginScreen(),
        '/language': (context) => LanguagePage(),
      },
      //home: SplashNavScreen()
    );
  }
} 
