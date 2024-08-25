import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:orbcura_app/app_state.dart';
import 'package:orbcura_app/utils/colors.dart';
import 'package:orbcura_app/widgets/four_corner_screen.dart';
import 'package:orbcura_app/utils/upi_uri_parser.dart';
import 'package:orbcura_app/utils/image_toggle_widget.dart';
import 'package:provider/provider.dart';
import 'package:vibration/vibration.dart';

class ConfirmationScreen extends StatefulWidget {
  final UPIDetails details;

  ConfirmationScreen(this.details);

  @override
  State<ConfirmationScreen> createState() => _ConfirmationScreenState();
}

class _ConfirmationScreenState extends State<ConfirmationScreen> {
  final _amountController = TextEditingController.fromValue(TextEditingValue(text: "100"));

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.sizeOf(context).height;
    var w = MediaQuery.sizeOf(context).width;

    return FourCornerScreen(
      CornerChild(
        ImageToggleWidget(
          image1: "assets/mic.png",
          image2: "assets/audio.gif",
          height: h / 16,
          onTap: () {
            // Add any additional action if needed
          },
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
              "Tap on the top left corner of app to enter the amount to be paid through speech");
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
        () {Vibration.vibrate();Navigator.pop((context));},
      ),
      Scaffold(
        body: Container(
          color: AppColors.white2,
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: h / 16,
                ),
                Image.asset(
                  "assets/bhim.png",
                  width: w / 4.5,
                ),
                SizedBox(height: h / 20),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Money Sent to Bhushan",
                    style: GoogleFonts.leagueSpartan(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: w / 5), // Shortened width padding
                  child: TextField(
  
                    controller: _amountController,
                    readOnly: true, // Prevents the keyboard from appearing
                    decoration: InputDecoration(
                      constraints:
                          BoxConstraints.loose(Size(double.infinity, h / 12)),
                      fillColor: AppColors.white,
                      filled: true,
                      border: OutlineInputBorder(
                        borderSide:
                            BorderSide(width: 1.5, color: AppColors.border),
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: h / 25,
                ),
                SizedBox(
                  height: h / 7, // Adjust the size of the image as needed
                  child: Image.asset(
                      "assets/confirm.png"), // Replace with your image asset
                ),
                SizedBox(height: h / 20),
                Column(
                  mainAxisSize: MainAxisSize
                      .min, // Minimize the column's size to its content
                  children: [
                    Text(
                      "Payment",
                      style: GoogleFonts.leagueSpartan(
                        fontSize: 32,
                        fontWeight: FontWeight.w400,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      "Successful",
                      style: GoogleFonts.leagueSpartan(
                        fontSize: 32,
                        fontWeight: FontWeight.w400,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                SizedBox(height: h / 15),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    "UPI ID - 9350236455@ibl",
                    style: GoogleFonts.leagueSpartan(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Bhushan Kumar",
                    style: GoogleFonts.leagueSpartan(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
