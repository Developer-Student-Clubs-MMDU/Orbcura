import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:orbcura_app/app_state.dart';
import 'package:orbcura_app/widgets/four_corner_screen.dart';
import 'package:provider/provider.dart';
import 'package:vibration/vibration.dart';

/// CameraApp is the Main Application.
class SmartCam extends StatefulWidget {
  /// Default Constructor
  const SmartCam({super.key});

  @override
  State<SmartCam> createState() => _SmartCamState();
}

class _SmartCamState extends State<SmartCam> {
  late List<CameraDescription> _cameras;
  CameraController? controller;
  final gemini = Gemini.instance;
  bool processing = false;

  String description = '';

  @override
  void initState() {
    super.initState();
    availableCameras().then((value) {
      _cameras = value;
      controller = CameraController(_cameras[0], ResolutionPreset.max);
    controller?.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    }).catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
            // Handle access errors here.
            break;
          default:
            // Handle other errors here.
            break;
        }
      }
    });
    });
    
  }

  void _describeImage() {
    () async {
      while (processing) {
        await Future.delayed(Duration(milliseconds: 200));
        Vibration.vibrate(duration: 200);
        await Future.delayed(Duration(milliseconds: 200));
      }
    } ();
    final pro = Provider.of<AppState>(context, listen: false);
    controller?.takePicture().then((value) {
      setState(() {
        processing = true;
      });
      Vibration.vibrate();
      value.readAsBytes().then((val) {
        gemini.textAndImage(
        text: "What does this show? dont say this picture this that. Dont make it a paragraph but make it detailed enough. Respond in ${pro.language} language", /// text
        images: [val] /// list of images
      )
      .then((va) {
        setState(() {
          description = va?.content?.parts?.last.text ?? '';
        });
        pro.tts.speak(va?.content?.parts?.last.text ?? '');
        setState(() {
          processing = false;
        });
      });
          
      });
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.sizeOf(context).height;
    var w = MediaQuery.sizeOf(context).height;
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
          () {
            final pro = Provider.of<AppState>(context, listen: false);
            pro.tts.speak("Press and hold the screen till vibration to get to know about what is in front");
          },
        ),
        CornerChild(
          Image.asset(
            "assets/home.png",
            height: h / 16,
          ),
          () {Navigator.pop(context);},
        ),
        CornerChild(
          Image.asset(
            "assets/back.png",
            height: h / 16,
          ),
          () {Vibration.vibrate();Navigator.pop(context);},
        ),
        Scaffold(
      body: GestureDetector(onLongPress:() {
          _describeImage();
        }, child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Align(alignment: Alignment.center, child: Text("Press and Hold ")),
            Center(child: Stack(children: [controller == null ? SizedBox(width: 1,) :CameraPreview(controller!), processing == true ? Positioned.fill(child: CircularProgressIndicator.adaptive()) : SizedBox(width: 1,),])),
          Align(alignment: Alignment.center, child: Text(description))
          ]
        ),
      )));
  }
}