import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';
import 'package:relead/utils/extension.dart';

import '../../../controller/profileController/changeEmailController/newEmailVerif_controller.dart';
import '../../../utils/global.colors.dart';

class NewEmailVerification extends StatefulWidget {
  const NewEmailVerification({super.key});

  @override
  State<NewEmailVerification> createState() => _NewEmailVerificationState();
}

class _NewEmailVerificationState extends State<NewEmailVerification> {
  final _formfield = GlobalKey<FormState>();
  final emailController = TextEditingController();
  NewEmailVerifController newEmailVerifController = Get.put( NewEmailVerifController());


  @override
  Widget build(BuildContext context) {
    // Get the arguments passed from the previous screen
    final arguments = Get.arguments as Map<String, String>;
    final newEmail = arguments['newEmail'];
    newEmailVerifController.newEmailController=newEmail!;

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
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 7.0.wp),
            child: SingleChildScrollView(
                child: Column(children: [
                  //logo
                  SizedBox(height: 10.0.hp),
                  Image.asset(
                    'assets/images/logoRelead.jpg',
                    height: 25.0.hp,
                    width: 50.0.wp,
                  ),
                  SizedBox(height: 10.0.hp),

                  Form(
                      key: _formfield,
                      child: Column(children: [
                        //Change your email
                        Text(

                          "Check your Mail".tr,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.bold,
                              color: GlobalColors.BlueColor,
                              fontSize: 17.0.sp),
                        ),
                        SizedBox(height: 2.0.hp),
                        //Please enter the 4 digits code sent to your mail
                        RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(children: [
                              TextSpan(
                                  text: "Please enter the 4 digit code sent to ".tr,
                                  style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.w500,
                                    color: GlobalColors.blackTextColor,
                                    fontSize: 11.0.sp,
                                  )),
                              TextSpan(
                                text: newEmail,
                                style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.w500,
                                    color: GlobalColors.BlueColor,
                                    fontSize: 11.0.sp),
                              )
                            ])),

                        SizedBox(height: 7.0.hp),
                        //textfield
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 18.0.wp),
                          child: SizedBox(
                              child: Pinput(
                                controller: newEmailVerifController.newEmailCodeController,
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
                                      newEmailVerifController.verify()
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
          )),
    );
  }
}
