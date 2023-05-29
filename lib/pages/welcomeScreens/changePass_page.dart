import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:relead/pages/welcomeScreens/login_page.dart';
import 'package:relead/utils/extension.dart';

import '../../controller/passwordController/ChangePass_Controller.dart';
import '../../utils/global.colors.dart';

class ChangePass extends StatefulWidget {
  const ChangePass({super.key});

  @override
  State<ChangePass> createState() => _ChangePassState();
}

class _ChangePassState extends State<ChangePass> {
  final _formfield = GlobalKey<FormState>();
  bool _obscureText = true;
  bool _obscureText2 = true;
  final passConfirmController = TextEditingController();

  ChangePassController changePassController = Get.put( ChangePassController());

  @override
  Widget build(BuildContext context) {
    // Get the arguments passed from the previous screen
    final Map<String, dynamic> arguments = Get.arguments;
    // Get the name and age arguments
    final String email = arguments['email'];
    changePassController.email=email;
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
                //Change your password
                Text(
                  "Forgot password?".tr,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.bold,
                      color: GlobalColors.BlueColor,
                      fontSize: 15.0.sp),
                ),
                SizedBox(height: 5.0.hp),
                //password textfield
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 7.0.wp),
                  child:TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Password is required.".tr;
                      } else if (changePassController.passController.text.length < 8) {
                        return "The minimum length for this field is 8 characters."
                            .tr;
                      }
                    },
                    controller: changePassController.passController,
                    style: GoogleFonts.montserrat(
                        color: GlobalColors.BlueColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 12.0.sp),
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
                        hintText: 'Password'.tr,
                        hintStyle: GoogleFonts.montserrat(
                            color: GlobalColors.BlueColor.withOpacity(0.6),
                            fontWeight: FontWeight.w500,
                            fontSize: 11.0.sp),
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              _obscureText = !_obscureText;
                            });
                          },
                          child: Icon(
                            _obscureText
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: GlobalColors.BlueColor,
                          ),
                        )),
                    obscureText: _obscureText,
                  ),
                ),
                SizedBox(height: 2.0.hp),
                //confirm password textfield
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 7.0.wp),
                  child: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Confirm Password is required.".tr;
                      } else if (passConfirmController.text !=
                          changePassController.passController.text) {
                        return "Passwords doesn't match.".tr;
                      }
                    },
                    controller: passConfirmController,
                    style: GoogleFonts.montserrat(
                        color: GlobalColors.BlueColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 12.0.sp),
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
                        hintText: 'Confirm password'.tr,
                        hintStyle: GoogleFonts.montserrat(
                            color: GlobalColors.BlueColor.withOpacity(0.6),
                            fontWeight: FontWeight.w500,
                            fontSize: 11.0.sp),
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              _obscureText2 = !_obscureText2;
                            });
                          },
                          child: Icon(
                            _obscureText2
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: GlobalColors.BlueColor,
                          ),
                        )),
                    obscureText: _obscureText2,
                  ),
                ),
              ])),
          //continue button
          SizedBox(
            height:23.0.hp ,
            child: Center(
              child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () => {
                            if (_formfield.currentState!.validate())
                              {
                                changePassController.change(),
                                Get.back()
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
            ),
          ),
        ])));
  }
}
