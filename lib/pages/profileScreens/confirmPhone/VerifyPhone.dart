import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';
import 'package:relead/utils/extension.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../controller/profileController/phoneController/verifyPhone_controller.dart';
import '../../../utils/global.colors.dart';

class VerifyPhone extends StatefulWidget {
  const VerifyPhone({super.key});

  @override
  State<VerifyPhone> createState() => _VerifyPhoneState();
}

Future<String> getStringValue(String key) async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString(key) ?? '';
}

VerifyPhoneController verifyPhoneController = Get.put(VerifyPhoneController());

class _VerifyPhoneState extends State<VerifyPhone> {
  final _formField = GlobalKey<FormState>();
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
                      key: _formField,
                      child: Column(children: [

                        //Change your password
                        Text(

                          "Check your Phone".tr,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.bold,
                              color: GlobalColors.BlueColor,
                              fontSize: 17.0.sp),
                        ),
                        SizedBox(height: 2.0.hp),
                        //Please enter the 4 digits code sent to your mail

                              Text(
                                  "Please enter the 6 digit code sent to".tr,
                                  style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.w500,
                                    color: GlobalColors.blackTextColor,
                                    fontSize: 11.0.sp,
                                  )),

                        FutureBuilder(
                          future: getStringValue('phone'), // the key to retrieve a string from SharedPreferences
                          builder: (BuildContext context, AsyncSnapshot snapshot) {
                            if(snapshot.hasData){

                              return Text('${snapshot.data}',
                                style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.w500,
                                  color: GlobalColors.BlueColor,
                                  fontSize: 11.0.sp,),);
                            }else {return Text("loading...",
                              style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w500,
                                color: GlobalColors.BlueColor,
                                fontSize: 11.0.sp,),);}
                          },
                        ),

                        SizedBox(height: 7.0.hp),
                        //textfield
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0.wp),
                          child: SizedBox(
                              child: Pinput(
                                controller: verifyPhoneController.phoneCodeController,
                                  keyboardType: TextInputType.text,
                                  length: 6,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  defaultPinTheme: PinTheme(
                                      height: 6.5.hp,
                                      width: 6.5.hp,
                                      textStyle: GoogleFonts.montserrat(
                                          fontWeight: FontWeight.bold,
                                          color: GlobalColors.PinkColor,
                                          fontSize: 15.0.sp),
                                      decoration: BoxDecoration(
                                          color: GlobalColors.BoxColor,
                                          borderRadius: BorderRadius.circular(3.0.wp)
                                                  )
                                                  )
                                          )
                                        ),
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
                                      verifyPhoneController.confirm()
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
