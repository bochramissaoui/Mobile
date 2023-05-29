import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_map_tile_caching/flutter_map_tile_caching.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:relead/pages/welcomeScreens/resetpassByEmail_page.dart';
import 'package:relead/pages/welcomeScreens/signup_page.dart';
import 'package:relead/utils/extension.dart';
import 'package:relead/utils/global.colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../controller/WelcomeController/getInfo_controller.dart';
import '../../controller/WelcomeController/login_controller.dart';
import '../appScreens/home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, required this.damagedDatabaseDeleted, required this.store});

  final bool damagedDatabaseDeleted;
  final StoreDirectory store;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _obscureText = true;
  final _formField = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passController = TextEditingController();

  //bool emailValid=RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_{|}~`]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(input);

  GetInfoController getInfoController = Get.put(GetInfoController());

  final Future<SharedPreferences> _prefs=SharedPreferences.getInstance();

  late LoginController _loginController;
  @override
  void initState() {
    _loginController = Get.put(LoginController(damagedDatabaseDeleted: widget.damagedDatabaseDeleted, store: widget.store));

    super.initState();

  }
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
              height: 33.0.hp,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/OopsFace.png',
                    height: 13.0.hp,
                    width: 20.0.wp,
                  ),
                  SizedBox(height: 2.0.hp),
                  Text(
                    "Close this app ?".tr,
                    style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w600,
                        color: GlobalColors.BlueColor,
                        fontSize: 10.0.sp),
                  ),SizedBox(height: 0.5.hp),

                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: 7.0.wp),
                      child: Text(
                        "are you sure to close this app ?".tr,
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
                          Navigator.of(context).pop(false)
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
                          'No'.tr,
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
                          Navigator.of(context).pop(true)
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
                          'Yes'.tr,
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
              SizedBox(height: 8.0.hp),
              Image.asset(
                'assets/images/logoRelead.jpg',
                height: 30.0.hp,
                width: 50.0.wp,
              ),
              SizedBox(height: 8.0.hp),

              Form(
                  key: _formField,
                  child: Column(children: [
                    //email text-field
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
                          controller: _loginController.emailController,
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
                    SizedBox(height: 2.0.hp),
                    //password
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 7.0.wp),
                      child: TextFormField(
                        validator: (value1) {
                          if (value1!.isEmpty) {
                            return "Enter Password".tr;
                          } else if (_loginController.passwordController.text.length < 8) {
                            return "Password length should not be less than 8 characters"
                                .tr;
                          }
                        },
                        controller: _loginController.passwordController,
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
                                borderSide: const BorderSide(
                                    color: Colors.transparent),
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
                                color:
                                GlobalColors.BlueColor.withOpacity(0.6),
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
                  ])),
              SizedBox(height: 7.0.hp),
              //sign in button
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 7.0.wp),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () => {
                            if (_formField.currentState!.validate())
                              {
                                _loginController.login().then((_) => getInfoController.getInfo())

                              },
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
                            'Log In'.tr,
                            style: GoogleFonts.montserrat(
                                color: GlobalColors.WhiteColor,
                                fontWeight: FontWeight.w500,
                                fontSize: 16.0.sp),
                          ),
                        )
                      ])),

              SizedBox(height: 2.0.hp),
              //forgot password

              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => const ResetPass()));
                },
                child: Text("Forgot password?".tr,
                    style: GoogleFonts.montserrat(color: GlobalColors.BlueColor,fontSize: 10.0.sp)),
              ),
              SizedBox(height: 10.0.hp),
              /*
              //Google and facebook login buttons
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {},
                      label: Text(
                        'Google',
                        style: GoogleFonts.montserrat(
                            color: GlobalColors.PinkColor,
                            fontWeight: FontWeight.w500,
                            fontSize: 15),
                      ),
                      icon: Icon(
                        Icons.facebook,
                        color: GlobalColors.PinkColor,
                      ),
                      style: ButtonStyle(
                          minimumSize:
                              MaterialStateProperty.all(const Size(130, 40)),
                          backgroundColor:
                              const MaterialStatePropertyAll<Color>(Colors.white),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                      side: BorderSide(
                                          color: GlobalColors.PinkColor)))),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton.icon(
                      onPressed: () {},
                      label: Text(
                        'Facebook',
                        style: GoogleFonts.montserrat(
                            color: GlobalColors.PinkColor,
                            fontWeight: FontWeight.w500,
                            fontSize: 15),
                      ),
                      icon: Icon(
                        Icons.facebook,
                        color: GlobalColors.PinkColor,
                      ),
                      style: ButtonStyle(
                          minimumSize: MaterialStateProperty.all(Size(130, 40)),
                          backgroundColor:
                              const MaterialStatePropertyAll<Color>(Colors.white),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                      side: BorderSide(
                                          color: GlobalColors.PinkColor)))),
                    )
                  ],
                ),
              ),
              */
              const SizedBox(height: 0),
              //grey rectangle
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 7.0.wp),
                child: Container(
                  margin: EdgeInsets.only(left: 27.0.wp, right: 27.0.wp),
                  padding: EdgeInsets.fromLTRB(0.5.wp, 0.2.hp, 0.5.wp, 0.2.hp),
                  decoration: BoxDecoration(
                      color: GlobalColors.GreyColor,
                      borderRadius: BorderRadius.circular(25)),
                ),
              ),
              SizedBox(height: 1.5.hp),
              // Don't have an account? Register
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 7.0.wp),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("Don't have an account? ".tr,
                        style: GoogleFonts.montserrat(
                            color: GlobalColors.BlueColor,
                            fontWeight: FontWeight.w500,
                            fontSize: 7.0.sp)),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (BuildContext context) =>
                            SignupPage(damagedDatabaseDeleted: widget.damagedDatabaseDeleted,
                                store: widget.store)));
                      },
                      child: Text("Register".tr,
                          style: GoogleFonts.montserrat(
                              color: GlobalColors.PinkColor,
                              fontWeight: FontWeight.bold,
                              fontSize:  7.0.sp)),
                    ),
                  ],
                ),
              ),
              TextButton(onPressed: ()async{
                final SharedPreferences? prefs = await _prefs;
                print(prefs?.get('token'));
              }, child:Text("print the token")),
              SizedBox(
                height: 5.0.hp,
              )
            ]),
          )),
    );
  }

//functions

}
