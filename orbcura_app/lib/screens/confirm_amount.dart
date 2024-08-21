import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:orbcura_app/app_state.dart';
import 'package:orbcura_app/screens/pin_entry.dart';
import 'package:orbcura_app/utils/colors.dart';
import 'package:orbcura_app/widgets/four_corner_screen.dart';
import 'package:orbcura_app/utils/upi_uri_parser.dart';
import 'package:provider/provider.dart';

class ConfirmAmountPage extends StatelessWidget {
  final _amountController = TextEditingController();
  final UPIDetails details;
  ConfirmAmountPage(this.details);
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
          body: Container(
            color: AppColors.white2,
            child: Center(
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.sizeOf(context).height / 16,
                  ),
                  Image.asset(
                    "assets/bhim.png",
                    width: MediaQuery.sizeOf(context).width / 4.5,
                  ),
                  SizedBox(height: h / 20),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                          padding: EdgeInsets.only(left: w / 12),
                          child: Text(
                            "Amount to pay",
                            style: GoogleFonts.leagueSpartan(
                                fontSize: 12, fontWeight: FontWeight.w400),
                            textAlign: TextAlign.left,
                          ))),
                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: w / 14),
                      child: TextField(
                        controller: _amountController,
                        decoration: InputDecoration(
                            constraints: BoxConstraints.loose(
                                Size(double.infinity, h / 12)),
                            fillColor: AppColors.white,
                            filled: true,
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 1.5, color: AppColors.border),
                                borderRadius: BorderRadius.circular(15))),
                      )),
                  SizedBox(
                    height: h / 12,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(18)),
                        border: Border.all(color: AppColors.border, width: 1.5),
                        color: Colors.white),
                    height: h / 2.2,
                    width: w / 2.5,
                    child: Center(
                        child: InkWell(
                      onTap: () {
                        details.amount = int.parse(_amountController.text);
                        details.payeeName != null ? Provider.of<AppState>(context).tts.speak(details.payeeName!) : null;
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PinEntryPage(
                                      details,
                                      digits: 6,
                                    )));
                      },
                      child: ConstrainedBox(
                        constraints:
                            BoxConstraints.loose(Size(w / 4, double.infinity)),
                        child: Text(
                          "Tap to confirm amount",
                          style: GoogleFonts.leagueSpartan(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: AppColors.fontColour,
                              height: 0.8),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    )),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
