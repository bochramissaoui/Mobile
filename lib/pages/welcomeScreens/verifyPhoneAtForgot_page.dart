import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';
import 'package:relead/utils/extension.dart';

import '../../../utils/global.colors.dart';

class VerifyPhoneAtForgot extends StatefulWidget {
  const VerifyPhoneAtForgot({super.key});

  @override
  State<VerifyPhoneAtForgot> createState() => _VerifyPhoneAtForgotState();
}

class _VerifyPhoneAtForgotState extends State<VerifyPhoneAtForgot> {
  final _formfield = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 7.0.wp),
          child: SingleChildScrollView(
              child: Column(children: [
            //logo
                SizedBox(height: 10.0.hp),
            Image.asset(
              'assets/images/phoneRelead.png',
              height: 35.0.hp,
              width: 70.0.wp,
            ),
                SizedBox(height: 5.0.hp),

            Form(
                key: _formfield,
                child: Column(children: [
                  //Change your password
                  Text(
                    "Check your Phone".tr,
                    style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.bold,
                        color: GlobalColors.BlueColor,
                        fontSize: 19.0.sp),
                  ),
                  SizedBox(height: 2.0.hp),
                  //Please enter the 4 digits code sent to your mail
                  RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(children: [
                        TextSpan(
                            text: "Please enter the 4 digit code sent to".tr,
                            style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w500,
                              color: GlobalColors.blackTextColor,
                              fontSize: 11.0.sp,
                            )),
                        TextSpan(
                          text: "\n12345678",
                          style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w500,
                              color: GlobalColors.BlueColor,
                            fontSize: 11.0.sp,),
                        )
                      ])),

                  SizedBox(height: 7.0.hp),
                  //textfield
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 18.0.wp),
                    child: SizedBox(
                        child: Pinput(
                            keyboardType: TextInputType.text,
                            length: 4,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            defaultPinTheme: PinTheme(
                                height: 7.0.hp,
                                width: 20.0.wp,
                                textStyle: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.bold,
                                    color: GlobalColors.PinkColor,
                                    fontSize: 12.0.sp),
                                decoration: BoxDecoration(
                                    color: GlobalColors.BoxColor,
                                    borderRadius: BorderRadius.circular(3.0.wp))))),
                  ),
                  SizedBox(height: 5.0.hp),
                  //Resend Code
                  Text(
                    "Resend Code".tr,
                    style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w600,
                        color: GlobalColors.PinkColor,
                        fontSize: 12.0.sp),
                  ),
                  SizedBox(height: 3.0.hp),
                  //continue button
                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: 7.0.wp),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: () => {
                                Navigator.of(context).pop()
                              },
                              style: ButtonStyle(
                                  minimumSize:
                                  MaterialStateProperty.all(Size(50.0.wp, 6.5.hp)),
                                  backgroundColor: MaterialStatePropertyAll<Color>(
                                      GlobalColors.BlueColor),
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(40.0.wp),
                                  ))),
                              child: Text(
                                'Confirm'.tr,
                                style: GoogleFonts.montserrat(
                                    color: GlobalColors.WhiteColor,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16.0.sp),
                              ),
                            )
                          ])),
                ]))
          ])),
        ));
  }
}
