import 'package:flutter/material.dart';
import 'package:flutter_map_tile_caching/flutter_map_tile_caching.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';
import 'package:relead/utils/extension.dart';
import '../../controller/WelcomeController/VerifyEmailController.dart';
import '../../controller/WelcomeController/getInfo_controller.dart';
import '../../utils/global.colors.dart';
import '../appScreens/home_page.dart';

class VerifyEmail extends StatefulWidget {
  const VerifyEmail({super.key, required this.damagedDatabaseDeleted, required this.store});

  final bool damagedDatabaseDeleted;
  final StoreDirectory store;
  @override
  State<VerifyEmail> createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {
  final _formfield = GlobalKey<FormState>();
  final registerCodeController = TextEditingController();
  GetInfoController getInfoController = Get.put(GetInfoController());
  late VerifyEmailController _verifyEmailAfterLogin;
  @override
  void initState() {
    _verifyEmailAfterLogin = Get.put(VerifyEmailController(damagedDatabaseDeleted: widget.damagedDatabaseDeleted, store: widget.store));
    super.initState();

  }
  @override
  Widget build(BuildContext context) {


    // Get the arguments passed from the previous screen
    final Map<String, dynamic> arguments = Get.arguments;

    // Get the name and age arguments
    final String email = arguments['email'];

    return Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 7.0.wp),
          child: SingleChildScrollView(
              child: Column(children: [
                //logo
                SizedBox(height: 10.0.hp),
                Image.asset(
                  'assets/images/Mail.png',
                  height: 25.0.hp,
                  width: 50.0.wp,

                ),
                SizedBox(height: 10.0.hp),

                Form(
                    key: _formfield,
                    child: Column(children: [
                      //Change your password
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
                      Text(
                          "Please enter the 4 digit code sent to".tr,
                          style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w500,
                            color: GlobalColors.blackTextColor,
                            fontSize: 11.0.sp,
                          )),
                      Text(
                          email,
                          style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w500,
                            color: GlobalColors.blackTextColor,
                            fontSize: 11.0.sp,
                          )),

                      SizedBox(height: 7.0.hp),
                      //textfield
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 18.0.wp),
                        child: SizedBox(
                            child: Pinput(
                                controller: _verifyEmailAfterLogin.loginCodeController,
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
                                    _verifyEmailAfterLogin.verify().then((_) => getInfoController.getInfo())
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
