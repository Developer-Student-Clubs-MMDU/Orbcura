import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:vibration/vibration.dart';

enum Language {hindi, english}

Map<String, String> englishStrings = {"languageChanged": "The selected language is English"};
Map<String, String> hindiStrings = {"languageChanged": "चयनित भाषा हिन्दी है।"};

class AppState extends ChangeNotifier {
  String lastWords = '';
  final stt = SpeechToText();
  AppState() {
    stt.initialize();
  }
  final tts = FlutterTts();
  Language language = Language.english;
  

  
  void toggleLanguage() async {
    if (language == Language.english) {
      language = Language.hindi;
      await tts.setLanguage("hi");
      tts.speak(hindiStrings["languageChanged"]!);
    } else {
      language = Language.english;
      await tts.setLanguage("en");
      tts.speak(englishStrings["languageChanged"]!);
    }
    Vibration.vibrate();
    notifyListeners();
  }
}

