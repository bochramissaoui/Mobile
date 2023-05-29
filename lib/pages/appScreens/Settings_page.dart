import 'package:app_settings/app_settings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map_tile_caching/flutter_map_tile_caching.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:relead/controller/SettingsController/app_language.dart';
import 'package:relead/utils/extension.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/global.colors.dart';
import '../welcomeScreens/login_page.dart';

class Settings extends StatefulWidget {
  const Settings({super.key, required this.damagedDatabaseDeleted, required this.store});

  final bool damagedDatabaseDeleted;
  final StoreDirectory store;
  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  List<String> items = <String>['English', 'French'];
  AppLanguageController instance = AppLanguageController();
  //String dropdownValue = instance.languageSelected() == 'fr' ? 'French' : 'English';
  String dropdownValue =GetStorage().read('lang')== 'en' ? 'English' : 'French';
  bool stateDarkMode = false;
  bool stateNotification = false;
  final Future<SharedPreferences> _prefs=SharedPreferences.getInstance();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: Column(children: [
            Padding(
              padding:EdgeInsets.fromLTRB(7.0.wp, 30, 7.0.wp, 0),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back_ios,size: 7.0.wp,),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        'Settings'.tr,
                        style: GoogleFonts.montserrat(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 16.0.sp),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 50,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 22.0.hp,
            ),
            Padding(
                padding:  EdgeInsets.symmetric(horizontal: 7.0.wp),
                child: Row(
                  children: [
                    Container(
                      height: 11.0.wp,
                      width: 11.0.wp,
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(300)),
                          color: Color(0xffFAE5EA)),
                      child: Icon(
                        size: 8.0.wp,
                        Icons.public,
                        color: GlobalColors.PinkColor,
                      ),
                    ),
                    SizedBox(
                      width: 4.0.wp,
                    ),
                    Expanded(
                      child: Text(
                        'Language'.tr,
                        style: GoogleFonts.montserrat(
                            color: GlobalColors.BlueColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 14.0.sp),
                      ),
                    ),
                    GetBuilder<AppLanguageController>(
                      init: AppLanguageController(),
                      builder: (controller) {
                        return DropdownButton<String?>(
                            icon: Icon(
                              Icons.arrow_drop_down_sharp,
                              size: 5.0.wp,
                            ),
                            onChanged: ((String? newValue) {
                              setState(() {
                                dropdownValue = newValue!;
                              });
                              if (newValue == 'English') {
                                controller.changeLanguage('en');
                                Get.updateLocale(Locale('en'));
                              } else if (newValue == 'French') {
                                controller.changeLanguage('fr');
                                Get.updateLocale(Locale('fr'));
                              }
                            }),
                            value: dropdownValue,
                            items: items.map<DropdownMenuItem<String>>(
                                  (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              },
                            ).toList());
                      },
                    ),
                  ],
                )),SizedBox(
              height: 2.0.hp,
            ),

            Padding(
                padding:  EdgeInsets.symmetric(horizontal: 7.0.wp),
                child: Row(
                  children: [
                    Container(
                        height: 11.0.wp,
                        width: 11.0.wp,
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(300)),
                            color: Color(0xffC4E5FF)),
                        child: Padding(
                          padding: EdgeInsets.all(2.4.wp),
                          child: SvgPicture.asset(
                            'assets/icons/moon.svg',
                            color: GlobalColors.BlueColor,
                          ),
                        )),
                    SizedBox(
                      width: 4.0.wp,
                    ),
                    Expanded(
                      child: Text(
                        'Dark Mode'.tr,
                        style: GoogleFonts.montserrat(
                            color: GlobalColors.BlueColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 14.0.sp),
                      ),
                    ),
                    CupertinoSwitch(
                      value: stateDarkMode,
                      onChanged: (value) {
                        stateDarkMode = value;
                        setState(
                              () {},
                        );
                      },
                      trackColor: GlobalColors.GreyColor,
                      activeColor: GlobalColors.PinkColor,
                    ),
                  ],
                )),
            SizedBox(
              height: 2.0.hp,
            ),

            Padding(
                padding:  EdgeInsets.symmetric(horizontal: 7.0.wp),
                child: Row(
                  children: [
                    Container(
                        height: 11.0.wp,
                        width: 11.0.wp,
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                            color: Color(0xffE1FFCE)),
                        child: Icon(Icons.notifications_off_outlined, size: 7.5.wp, color: const Color(0xff5C9E31))),
                    SizedBox(
                      width: 4.0.wp,
                    ),
                    Expanded(
                      child: Text(
                        'Notifications'.tr,
                        style: GoogleFonts.montserrat(
                            color: GlobalColors.BlueColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 14.0.sp),
                      ),
                    ),
                    CupertinoSwitch(
                      value: stateNotification,
                      onChanged: (value) {
                        stateNotification = value;
                        setState(
                              () {},
                        );
                      },
                      trackColor: GlobalColors.GreyColor,
                      activeColor: GlobalColors.PinkColor,
                    ),
                  ],
                )),
            SizedBox(
              height: 2.0.hp,
            ),
            Padding(
                padding:  EdgeInsets.symmetric(horizontal: 7.0.wp),
                child: Row(
                  children: [
                    Container(
                        height: 11.0.wp,
                        width: 11.0.wp,
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                            color: Color(0xffFDEEDC)),
                        child: Icon(Icons.storage, size: 7.5.wp, color: const Color(0xffF1A661))),
                    SizedBox(
                      width: 4.0.wp,
                    ),
                    Expanded(
                      child: StreamBuilder(
                          stream: widget.store.stats.watchChanges(),
                          builder: (context, _) {
                            return Text('Cache size: ${widget.store.stats.storeSize-4} Kb',style: GoogleFonts.montserrat(
                                color: GlobalColors.BlueColor,
                                fontWeight: FontWeight.w600,
                                fontSize: 14.0.sp),);
                          }),
                    ),
                    IconButton(color: const Color(0xfff73d52), onPressed: () { widget.store.manage.reset(); }, icon:Icon(Icons.delete_forever,size: 7.5.wp)),
                    SizedBox(
                      width: 1.0.wp,
                    ),
                  ],
                )),

            SizedBox(height:28.0.hp),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 7.0.wp),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: ElevatedButton.icon(
                  onPressed: (() async {
                    // Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                    //     const LoginPage()), (Route<dynamic> route) => false);
                    final SharedPreferences? prefs = await _prefs;
                    prefs?.clear();
                    Get.offAll(LoginPage(damagedDatabaseDeleted: widget.damagedDatabaseDeleted,
                        store: widget.store));
                  }),
                  style: ButtonStyle(
                      minimumSize:
                      MaterialStateProperty.all(Size(50.0.wp, 7.5.hp)),
                      backgroundColor: MaterialStatePropertyAll<Color>(
                          GlobalColors.BlueColor),
                      shape: MaterialStateProperty.all<
                          RoundedRectangleBorder>(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40.0.wp),
                      ))),
                  icon: Icon(
                    size:6.0.wp,
                    Icons.logout,
                    color: Colors.white,
                  ),
                  label: Text(
                    'Sign Out'.tr,
                    style: GoogleFonts.montserrat(
                        color: GlobalColors.WhiteColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 12.0.sp),
                  ),
                ),
              ),
            )

            //
            //
          ]),
        ));
  }
}
