
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:relead/utils/extensions.dart';

import '../../utils/global.colors.dart';

class OopsNet extends StatefulWidget {
  const OopsNet({super.key});

  @override
  State<OopsNet> createState() => _OopsNetState();
}

class _OopsNetState extends State<OopsNet> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.0.wp),
          child: Center(
            child: SingleChildScrollView(
                child: Column(children: [
                  Text(
                    'Oops !!'.tr,
                    style: GoogleFonts.montserrat(
                        color: GlobalColors.BlueColor,
                        fontWeight: FontWeight.w700,
                        fontSize: 30.0.sp),
                  ),
                  SizedBox(height: 3.0.hp),
                  Image.asset(
                    'assets/images/OopsFace.png',
                    height: 40.0.hp,
                    width: 50.0.wp,
                  ),
                  SizedBox(height: 3.0.hp),
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                            text: 'It seems like there is no ',
                            style: GoogleFonts.montserrat(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: 15.0.sp)
                        ),
                        TextSpan(
                            text: 'internet connection'.tr,


                            style: GoogleFonts.montserrat(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                                fontSize: 17.0.sp)
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10.0.hp),
                  ElevatedButton(
                    onPressed: (() {

                    }),
                    style: ButtonStyle(
                        minimumSize:
                        MaterialStateProperty.all(Size(50.0.wp, 6.5.hp)),
                        backgroundColor: MaterialStatePropertyAll<Color>(
                            GlobalColors.PinkColor),
                        shape: MaterialStateProperty.all<
                            RoundedRectangleBorder>(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40.0.wp),
                        ))),
                    child: Text(
                      'Retry',
                      style: GoogleFonts.montserrat(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0.sp),
                    ),
                  )
                ])),
          ),
        ));
  }
}
