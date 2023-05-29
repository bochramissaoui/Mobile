import 'package:flutter/material.dart';
import 'package:flutter_map_tile_caching/flutter_map_tile_caching.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:relead/utils/extension.dart';
import 'package:relead/utils/global.colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login_page.dart';

class StartPage extends StatefulWidget {
  const StartPage({super.key, required this.damagedDatabaseDeleted, required this.store});
  final bool damagedDatabaseDeleted;
  final StoreDirectory store;

  @override
  State<StartPage> createState() => _StartPageState();
}

_storeGetStartedInfo() async {
  int isViewed = 0;
  SharedPreferences preferences = await SharedPreferences.getInstance();
  await preferences.setInt('StartPage', isViewed);
}

class _StartPageState extends State<StartPage> {

  late Widget _loginPage;

  @override
  void initState() {
    _loginPage=LoginPage(
        damagedDatabaseDeleted: widget.damagedDatabaseDeleted,
        store: widget.store);
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalColors.PinkColor,
      body: Column(children: [
        //image TOP
        SizedBox(height: 7.0.hp),
        Center(
          child: Image.asset(
            'assets/images/welcome_page.png',
            height: 50.0.hp,
            width: 70.0.wp,
          ),
        ),
        SizedBox(height: 7.0.hp),
        //FREE WIFI TO EVERYONE
        Text(
          'Free Wi-Fi'.tr,
          style: GoogleFonts.montserrat(
              color: Colors.white, fontWeight: FontWeight.w800, fontSize: 31.0.sp),
        ),
        Text(
          'For everyone , everywhere '.tr,
          style: GoogleFonts.montserrat(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15.0.sp),
        ),
        SizedBox(height: 7.0.hp),
        //button Get Started
        ElevatedButton(
          onPressed: () async {
            await _storeGetStartedInfo();
            Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => _loginPage));
          },
          style: ButtonStyle(
              minimumSize: MaterialStateProperty.all(Size(60.0.wp, 9.0.hp)),
              backgroundColor:
              MaterialStatePropertyAll<Color>(GlobalColors.BlueColor),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100.0.wp),
                  ))),
          child: Text(
            'Get started'.tr,
            style: GoogleFonts.montserrat(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15.0.sp),
          ),
        ),
      ]),
    );
  }
}
