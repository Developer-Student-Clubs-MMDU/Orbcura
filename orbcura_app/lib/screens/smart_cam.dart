import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
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
  late CameraController controller;
  final gemini = Gemini.instance;

  bool processing = false;


  @override
  void initState() {
    super.initState();
    availableCameras().then((value) {
      _cameras = value;
      controller = CameraController(_cameras[0], ResolutionPreset.max);
    controller.initialize().then((_) {
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
    controller.takePicture().then((value) {
      value.readAsBytes().then((val) {
        setState(() {
          processing = true;
        });
        () async {
          while (processing) {
            await Future.delayed(Duration(milliseconds: 200));
            Vibration.vibrate(duration: 200);
            await Future.delayed(Duration(milliseconds: 200));
          }
        }();
        gemini.textAndImage(
        text: "What does this show? dont say this picture this that. just say it directly.", /// text
        images: [val] /// list of images
      )
      .then((va) {
        setState(() {
          processing = false;
        });
         Provider.of<AppState>(context, listen: false).tts.speak(va?.content?.parts?.last.text ?? '');})
      .catchError((e) => print(e));
      });
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.sizeOf(context).height;
    if (!controller.value.isInitialized) {
      return Container();
    }
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
      body: GestureDetector(onLongPress:() {
        Vibration.vibrate();
        processing ? null : _describeImage();
      }, child: CameraPreview(controller)),
    )
        
        );
  }
}