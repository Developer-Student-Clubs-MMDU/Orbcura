import 'package:flutter/material.dart';
import 'package:orbcura_app/app_state.dart';
import 'package:orbcura_app/widgets/four_corner_screen.dart';
import 'package:provider/provider.dart';

class LanguagePage extends StatefulWidget {
  const LanguagePage({super.key});

  @override
  State<LanguagePage> createState() => _LanguagePageState();
}

class _LanguagePageState extends State<LanguagePage> {
  @override
  Widget build(BuildContext context) {
    var pro = Provider.of<AppState>(context);

    var h = MediaQuery.sizeOf(context).height;
    return FourCornerScreen(
        CornerChild(
            Image.asset(
              "assets/mic.png",
              height: h / 16,
            ),
            () {}),
        CornerChild(
          Image.asset(
            "assets/communicate.png",
            height: h / 16,
          ),
          () {},
        ),
        CornerChild(
          Image.asset(
            "assets/account.png",
            height: h / 16,
          ),
          () {},
        ),
        CornerChild(
          Image.asset(
            "assets/login.png",
            height: h / 16,
          ),
          () {
            Navigator.of(context).pushReplacementNamed('/splash_nav');
          },
        ),
        Center(
          child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/background_splash_nav.png"),
                    fit: BoxFit.fill)),
            child: Center(
              child: Consumer<AppState>(
                builder: (context, state, child) => InkWell(
                    onLongPress: () {
                      state.toggleLanguage();
                    },
                    child: Image.asset(
                      "assets/orbcura_" + state.language.name + ".png",
                      height: h / 6,
                    )),
              ),
            ),
          ),
        ));
  }
}
