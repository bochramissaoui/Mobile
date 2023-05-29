import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:equatable/equatable.dart';
import 'package:relead/controller/profileController/changeEmailController/newEmailToken_controller.dart';
import 'package:relead/utils/extension.dart';
import 'package:relead/utils/global.colors.dart';

import 'NewEmailVerification.dart';

class NewEmail extends StatefulWidget {
  const NewEmail({super.key});

  @override
  State<NewEmail> createState() => _NewEmailState();
}

class _NewEmailState extends State<NewEmail> {
  final _formfield = GlobalKey<FormState>();
  NewEmailTokenController newEmailTokenController = Get.put( NewEmailTokenController());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{
        final value=await showDialog<bool>(context: context, builder:(context){
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(1.0.hp)
            ),
            child: SizedBox(
              height: 17.0.hp,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Cancel".tr,
                    style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w600,
                        color: GlobalColors.BlueColor,
                        fontSize: 13.0.sp),
                  ),SizedBox(height: 1.0.hp),
                  //Enter the email address associated with your account
                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: 7.0.wp),
                      child: Text(
                        "are you sure to cancel this action?".tr,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w300,
                          color: GlobalColors.blackTextColor,
                          fontSize: 8.0.sp,
                        ),
                      )),
                  SizedBox(height: 2.0.hp),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center, //Center Row contents horizontally,
                    children: [
                      ElevatedButton(
                        onPressed: () => {
                          Navigator.of(context).pop(true)
                        },
                        style: ButtonStyle(
                            minimumSize:
                            MaterialStateProperty.all(Size(21.0.wp, 3.5.hp)),
                            backgroundColor: MaterialStatePropertyAll<Color>(
                                GlobalColors.BlueColor),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(2.0.wp),
                            ))),
                        child: Text(
                          'Okey'.tr,
                          style: GoogleFonts.montserrat(
                              color: GlobalColors.WhiteColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 10.0.sp),
                        ),
                      ),
                      SizedBox(
                        width: 3.5.wp,
                      ),
                      ElevatedButton(
                        onPressed: () => {
                          Navigator.of(context).pop(false)
                        },
                        style: ButtonStyle(
                            minimumSize:
                            MaterialStateProperty.all(Size(21.0.wp, 3.5.hp)),
                            backgroundColor: const MaterialStatePropertyAll<Color>(
                                Color(0xffE9E9E9)),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(2.0.wp),
                            ))),
                        child: Text(
                          'Return'.tr,
                          style: GoogleFonts.montserrat(
                              color: GlobalColors.BlueColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 10.0.sp),
                        ),
                      )
                    ],
                  )
                ],
              ),

            ),
          );
        });
        if(value!=null){
          return Future.value(value);
        }
        else{
          return Future.value(false);
        }
      },
      child: Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
              child: Column(children: [
            //logo
                SizedBox(height: 10.0.hp),
                Image.asset(
                  'assets/images/Registration.png',
                  height: 40.0.hp,
                  width: 60.0.wp,
                ),
                SizedBox(height: 3.0.hp),
            //Enter your new email
            Text(
              "Update your email".tr,
              style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.bold,
                  color: GlobalColors.BlueColor,
                  fontSize: 14.0.sp),
            ),
                SizedBox(height: 2.0.hp),
            //Please enter the 4 digits code sent to your mail
            Text(
                      "Please enter a new email".tr,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w500,
                        color: GlobalColors.blackTextColor,
                        fontSize: 11.0.sp,
                      )),
                SizedBox(height: 7.0.hp),
            Form(
                key: _formfield,
                child: Column(children: [
                  //email textfield
                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: 7.0.wp),
                      child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Email is required.";
                          }
                          bool emailValid = RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_{|}~`]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(value);
                          if (!emailValid) {
                            return "Please enter a valid email address.";
                          }
                        },
                        controller: newEmailTokenController.newEmailController,
                        style: GoogleFonts.montserrat(
                            color: GlobalColors.BlueColor,
                            fontWeight: FontWeight.w500,
                            fontSize: 12.0.sp),
                        keyboardType: TextInputType.emailAddress,
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
                            hintText: 'Email'.tr,
                            hintStyle: GoogleFonts.montserrat(
                                color: GlobalColors.BlueColor.withOpacity(0.6),
                                fontWeight: FontWeight.w500,
                                fontSize: 11.0.sp)),
                      )),
                  SizedBox(height:3.0.hp),
                  //sign up button
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: () => {
                                if (_formfield.currentState!.validate())
                                  {
                                    newEmailTokenController.verify()
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
                                'Confirm'.tr,
                                style: GoogleFonts.montserrat(
                                    color: GlobalColors.WhiteColor,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16.0.sp),
                              ),
                            )
                          ])),
                  SizedBox(height: 2.0.hp),
                ]))
          ]))),
    );
  }
}
