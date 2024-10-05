import 'dart:typed_data';

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
  Uint8List? image;

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

  List<Widget> _showImage(CameraController? controller, Uint8List? image) {
    if (controller == null) {
      return <Widget>[SizedBox(width: 1,)];
    } else if (image == null && processing == false) {
      return <Widget>[CameraPreview(controller), ];
    } else  if (image != null && processing == true){
      return <Widget>[Image.memory(image), Positioned.fill(child: Center(child: CircularProgressIndicator.adaptive()))];
    } else {
      return <Widget>[CameraPreview(controller), ];
    }
  }
  void _describeImage() {
    
    final pro = Provider.of<AppState>(context, listen: false);
    controller?.takePicture().then((value) {
      
      Vibration.vibrate();
      value.readAsBytes().then((val) {
        setState(() {
          processing = true;
          image = val;
        });

        () async {
      while (processing) {
        await Future.delayed(Duration(milliseconds: 200));
        Vibration.vibrate(duration: 200);
        await Future.delayed(Duration(milliseconds: 200));
      }
    } ();
        
        gemini.textAndImage(
        text: "What does this show? dont say this picture this that. Dont make it a paragraph but make it detailed enough. Respond in ${pro.language} language", /// text
        images: [val] /// list of images
      )
      .then((va) {
        setState(() {
          description = va?.content?.parts?.last.text ?? '';
          processing = false;
        });
        pro.tts.speak(va?.content?.parts?.last.text ?? '');
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
            Center(child: Stack(children: _showImage(controller, image))),
          Align(alignment: Alignment.center, child: Text(description))
          ]
        ),
      )));
  }
}