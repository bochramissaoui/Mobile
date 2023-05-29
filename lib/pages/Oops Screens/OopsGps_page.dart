import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:relead/utils/extension.dart';

import '../../utils/global.colors.dart';

class OopsGps extends StatefulWidget {
  const OopsGps({super.key});

  @override
  State<OopsGps> createState() => _OopsGpsState();
}

class _OopsGpsState extends State<OopsGps> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50),
          child: Center(
            child: SingleChildScrollView(
                child: Column(children: [
              Text(
                'Oops !!'.tr,
                style: GoogleFonts.montserrat(
                    color: GlobalColors.BlueColor,
                    fontWeight: FontWeight.w700,
                    fontSize: 49),
              ),
              const SizedBox(height: 29),
              Image.asset(
                'assets/images/OopsFace.png',
                height: 130,
                width: 130,
              ),
              const SizedBox(height: 21),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                        text: "Please provide ".tr,
                        style: GoogleFonts.montserrat(
                            color: GlobalColors.BlueColor,
                            fontWeight: FontWeight.w500,
                            fontSize: 23)),
                    TextSpan(
                        text: 'GPS'.tr,
                        style: GoogleFonts.montserrat(
                            color: GlobalColors.BlueColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 23)),
                    TextSpan(
                        text: ' permission'.tr,
                        style: GoogleFonts.montserrat(
                            color: GlobalColors.BlueColor,
                            fontWeight: FontWeight.w500,
                            fontSize: 23)),
                  ],
                ),
              )
                ,SizedBox(height: 2.0.hp),
              //Enter the email address associated with your account
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 7.0.wp),
                  child: Text(
                    "Let Relead access your location to find Free Wi-Fi nearby".tr,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w500,
                      color: GlobalColors.blackTextColor,
                      fontSize: 11.0.sp,
                    ),
                  )),
              const SizedBox(height: 25),
              ElevatedButton(
                onPressed: (() {
                  AppSettings.openAppSettings();
                }),
                style: ButtonStyle(
                    minimumSize: MaterialStateProperty.all(const Size(140, 45)),
                    backgroundColor:
                        MaterialStatePropertyAll<Color>(GlobalColors.PinkColor),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40),
                    ))),
                child: Text(
                  'Allow access'.tr,
                  style: GoogleFonts.montserrat(
                      color: GlobalColors.WhiteColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
              )
            ])),
          ),
        ));
  }
}
