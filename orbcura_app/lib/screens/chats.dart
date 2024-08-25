import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:orbcura_app/utils/colors.dart';
import 'package:orbcura_app/widgets/four_corner_screen.dart';
import 'package:orbcura_app/widgets/chat_item.dart';
import 'package:vibration/vibration.dart';

class ChatsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.sizeOf(context).height;
    var w = MediaQuery.sizeOf(context).height;

    final TextStyle chatIteminitalsStyle = GoogleFonts.leagueSpartan(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color: AppColors.fontColour,
    );

    final TextStyle chatItemNameStyle = GoogleFonts.leagueSpartan(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color: AppColors.fontColour,
    );

    final TextStyle chatItemMessageStyle = GoogleFonts.leagueSpartan(
      fontSize: 14,
      color: AppColors.fontColour,
    );

    final TextStyle chatItemTimeStyle = GoogleFonts.leagueSpartan(
      fontSize: 12,
      color: AppColors.fontColour,
    );

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
          () {Vibration.vibrate();
            Navigator.pop((context));},
        ),
        Scaffold(
          body: Container(
            color: AppColors.white2,
            child: Center(
              child: Column(
                children: [
                  SizedBox(
                    height: h / 11,
                  ),
                  Text(
                    "WhatsApp",
                    style: GoogleFonts.leagueSpartan(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                        color: AppColors.fontColour),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: h / 36,
                  ),
                  Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(18)),
                          border:
                              Border.all(color: AppColors.border, width: 1.5),
                          color: Colors.white),
                      //height: h/3.8,
                      width: w / 2.8,
                      child: Padding(
                        padding: EdgeInsets.all(8),
                        child: Column(
                          children: [
                            Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                    padding: EdgeInsets.all(4.5),
                                    child: Text(
                                      "Chats",
                                      style: GoogleFonts.leagueSpartan(
                                          color: AppColors.fontColour,
                                          fontSize: 14),
                                      textAlign: TextAlign.left,
                                    ))),
                            ChatItem(
                              initials: 'PS',
                              name: 'Parag Sharma',
                              message:
                                  "Hey max how's things at your end feeling better ?",
                              time: '14:35',
                              nameStyle: chatItemNameStyle,
                              messageStyle: chatItemMessageStyle,
                              timeStyle: chatItemTimeStyle,
                              initialsStyle: chatIteminitalsStyle,
                            ),
                            Divider(),
                            ChatItem(
                              initials: 'AC',
                              name: 'Aaditya Chaudhary',
                              message: "this soo dope ui broo..",
                              time: '14:35',
                              nameStyle: chatItemNameStyle,
                              messageStyle: chatItemMessageStyle,
                              timeStyle: chatItemTimeStyle,
                              initialsStyle: chatIteminitalsStyle,
                            ),
                            Divider(),
                            ChatItem(
                              initials: 'H',
                              name: 'Hemish',
                              message: "How was the idea on site ?",
                              time: '14:35',
                              nameStyle: chatItemNameStyle,
                              messageStyle: chatItemMessageStyle,
                              timeStyle: chatItemTimeStyle,
                              initialsStyle: chatIteminitalsStyle,
                            ),
                            Divider(),
                            ChatItem(
                              initials: 'S',
                              name: 'Sushant',
                              message: "Hello Bhaiya Can we go for that idea",
                              time: '14:35',
                              nameStyle: chatItemNameStyle,
                              messageStyle: chatItemMessageStyle,
                              timeStyle: chatItemTimeStyle,
                              initialsStyle: chatIteminitalsStyle,
                            ),
                            Divider(),
                            ChatItem(
                              initials: 'A',
                              name: 'Abhinav',
                              message: "2 idea has been finalized",
                              time: '14:35',
                              nameStyle: chatItemNameStyle,
                              messageStyle: chatItemMessageStyle,
                              timeStyle: chatItemTimeStyle,
                            ),
                          ],
                        ),
                      ))
                ],
              ),
            ),
          ),
        ));
  }
}
