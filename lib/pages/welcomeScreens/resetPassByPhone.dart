import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:equatable/equatable.dart';
import 'package:relead/pages/welcomeScreens/resetpassByEmail_page.dart';
import 'package:relead/pages/welcomeScreens/verifyPhoneAtForgot_page.dart';
import 'package:relead/utils/extension.dart';

import '../../utils/global.colors.dart';

class ResetPassByPhone extends StatefulWidget {
  const ResetPassByPhone({super.key});

  @override
  State<ResetPassByPhone> createState() => _ResetPassByPhoneState();
}

class _ResetPassByPhoneState extends State<ResetPassByPhone> {
  final _formfield = GlobalKey<FormState>();
  final phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            child: Column(children: [
          //logo
              SizedBox(height: 10.0.hp),

              Image.asset(
                'assets/images/Reset_password.png',
                height: 30.0.hp,
                width: 60.0.wp,
              ),
              SizedBox(height: 10.0.hp),

              Form(
                  key: _formfield,
                  child: Column(children: [
                    //Forgot password?
                    Text(
                      "Forgot password?".tr,
                      style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.bold,
                          color: GlobalColors.BlueColor,
                          fontSize: 17.0.sp),
                    ),
                    SizedBox(height: 2.0.hp),
                    //Enter the email address associated with your account
                    Padding(
                        padding: EdgeInsets.symmetric(horizontal: 7.0.wp),
                    child: Container(
                        child: Text(
                      "Enter your phone number associated with your account".tr,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w500,
                          color: GlobalColors.blackTextColor,
                          fontSize: 11.0.sp),
                    ))),
                    SizedBox(height: 5.0.hp),
                //Phone number textfield
                    Padding(
                        padding: EdgeInsets.symmetric(horizontal: 7.0.wp),
                        child: Container(
                          child: TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Enter phone number".tr;
                              } else if (phoneController.text.length != 8) {
                                return "Please enter a valid phone number".tr;
                              }
                            },
                            controller: phoneController,
                            style: GoogleFonts.montserrat(
                                color: GlobalColors.BlueColor,
                                fontWeight: FontWeight.w500,
                                fontSize: 12.0.sp),
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                contentPadding:
                                EdgeInsets.fromLTRB(5.0.wp, 2.0.hp, 5.0.wp, 2.0.hp),
                                border: OutlineInputBorder(
                                  borderSide:
                                  const BorderSide(color: Colors.transparent),
                                  borderRadius: BorderRadius.circular(50.0.wp),
                                ),
                                enabledBorder: OutlineInputBorder(
                                    borderSide:
                                    const BorderSide(color: Colors.transparent),
                                    borderRadius: BorderRadius.circular(50.0.wp)),
                                focusedBorder: OutlineInputBorder(
                                  borderSide:
                                  const BorderSide(color: Colors.transparent),
                                  borderRadius: BorderRadius.circular(50.0.wp),
                                ),
                                filled: true,
                                fillColor: GlobalColors.BoxColor,
                                hintText: 'Phone number'.tr,
                                hintStyle: GoogleFonts.montserrat(
                                    color: GlobalColors.BlueColor.withOpacity(0.6),
                                    fontWeight: FontWeight.w500,
                                    fontSize: 11.0.sp)),
                          ),
                        )),
                    SizedBox(height: 5.0.hp),
                    //try another way

                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => const ResetPass()));
                      },
                      child: Text("Try another way".tr,
                          style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w600,
                              color: GlobalColors.PinkColor,
                              fontSize: 12.0.sp)),
                    ),
                    SizedBox(height: 5.0.hp),
                //continue button




                    Padding(
                        padding: EdgeInsets.symmetric(horizontal: 7.0.wp),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                onPressed: () => {
                                  if (_formfield.currentState!.validate())
                                    {
                                      phoneController.clear(),
                                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => const VerifyPhoneAtForgot()))
                                    }
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
                                  'Continue'.tr,
                                  style: GoogleFonts.montserrat(
                                      color: GlobalColors.WhiteColor,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16.0.sp),
                                ),
                              )
                            ])),
                    SizedBox(height: 5.0.hp),
              ]))
        ])));
  }
}
