import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_map_tile_caching/flutter_map_tile_caching.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:equatable/equatable.dart';
import 'package:relead/controller/WelcomeController/registration_controller.dart';
import 'package:relead/utils/global.colors.dart';
import 'package:relead/utils/extensions.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key, required this.damagedDatabaseDeleted, required this.store});

  final bool damagedDatabaseDeleted;
  final StoreDirectory store;

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {


  bool _obscureText = true;
  bool _obscureText2 = true;

  final passController = TextEditingController();
  final passConfirmController = TextEditingController();
  final emailController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();

  final _formField = GlobalKey<FormState>();

  late RegistrationController _registrationController;

  @override
  void initState() {
    _registrationController = Get.put(RegistrationController(damagedDatabaseDeleted: widget.damagedDatabaseDeleted, store: widget.store));
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(children: [
            //logo
            SizedBox(height: 4.0.hp),
            Image.asset(
              'assets/images/Registration.png',
              height: 16.0.hp,
              width: 40.0.wp,
            ),
            SizedBox(height: 4.0.hp),
            Form(
                key: _formField,
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
                        controller: _registrationController.emailController,
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
                  //first name textfield
                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: 7.0.wp),
                      child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "First Name is required.".tr;
                          }
                        },
                        controller: _registrationController.firstNameController,
                        style: GoogleFonts.montserrat(
                            color: GlobalColors.BlueColor,
                            fontWeight: FontWeight.w500,
                            fontSize: 12.0.sp),
                        keyboardType: TextInputType.name,
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
                            hintText: 'First Name'.tr,
                            hintStyle: GoogleFonts.montserrat(
                                color: GlobalColors.BlueColor.withOpacity(0.6),
                                fontWeight: FontWeight.w500,
                                fontSize: 11.0.sp)),
                      )),
                  SizedBox(height: 2.0.hp),
                  //last name text-field
                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: 7.0.wp),
                      child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Last Name is required.".tr;
                          }
                        },
                        controller: _registrationController.lastNameController,
                        style: GoogleFonts.montserrat(
                            color: GlobalColors.BlueColor,
                            fontWeight: FontWeight.w500,
                            fontSize: 12.0.sp),
                        keyboardType: TextInputType.name,
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
                            hintText: 'Last Name'.tr,
                            hintStyle: GoogleFonts.montserrat(
                                color: GlobalColors.BlueColor.withOpacity(0.6),
                                fontWeight: FontWeight.w500,
                                fontSize: 11.0.sp)),
                      )),
                  SizedBox(height: 2.0.hp),
                  //Phone number text-field
                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: 7.0.wp),
                      child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Enter phone number".tr;
                          } else if (_registrationController.phoneController.text.length != 8) {
                            return "Please enter a valid phone number".tr;
                          }
                        },
                        controller: _registrationController.phoneController,
                        style: GoogleFonts.montserrat(
                            color: GlobalColors.BlueColor,
                            fontWeight: FontWeight.w500,
                            fontSize: 12.0.sp),
                        keyboardType: TextInputType.number,
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
                            hintText: 'Phone number'.tr,
                            hintStyle: GoogleFonts.montserrat(
                                color: GlobalColors.BlueColor.withOpacity(0.6),
                                fontWeight: FontWeight.w500,
                                fontSize: 11.0.sp)),
                      )),
                  SizedBox(height: 2.0.hp),
                  //password text-field
                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: 7.0.wp),
                      child:TextFormField(
                      validator: (value1) {
                        if (value1!.isEmpty) {
                          return "Password is required.".tr;
                        } else if (_registrationController.passwordController.text.length < 8) {
                          return "The minimum length for this field is 8 characters."
                              .tr;
                        }
                      },
                        controller: _registrationController.passwordController,
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
                  //confirm password text-field
                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: 7.0.wp),
                      child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Confirm Password is required.".tr;
                        } else if (passConfirmController.text !=
                            _registrationController.passwordController.text) {
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
            SizedBox(height: 5.0.hp),
            //sign up button
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
                              _registrationController.register()
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
                          'Register'.tr,
                          style: GoogleFonts.montserrat(
                              color: GlobalColors.WhiteColor,
                              fontWeight: FontWeight.w500,
                              fontSize: 16.0.sp),
                        ),
                      )
                    ])),

            SizedBox(height: 3.0.hp),
            //forgot password
            /*Text(
              'Or Register with'.tr,
              style: GoogleFonts.montserrat(
                color: GlobalColors.BlueColor,
              ),
            ),
            SizedBox(height: 12),
            //Google and facebook login buttons
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 7.0.wp),
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
                        minimumSize: MaterialStateProperty.all(Size(130, 40)),
                        backgroundColor:
                            MaterialStatePropertyAll<Color>(Colors.white),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                    side: BorderSide(
                                        color: GlobalColors.PinkColor)))),
                  ),
                  SizedBox(width: 10),
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
                            MaterialStatePropertyAll<Color>(Colors.white),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                    side: BorderSide(
                                        color: GlobalColors.PinkColor)))),
                  )
                ],
              ),
            ),*/
            SizedBox(height: 2.0.hp),
            // grey rectangle
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
            SizedBox(height: 1.0.hp),
            // Don't have an account? Registre
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 7.0.wp),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("You already have an account? ".tr,
                      style: GoogleFonts.montserrat(
                          color: GlobalColors.BlueColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 7.0.sp)),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Text("Login".tr,
                        style: GoogleFonts.montserrat(
                            color: GlobalColors.PinkColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 7.0.sp)),
                  ),
                ],
              ),
            ),
            SizedBox(height: 2.0.hp),
          ]),
        ));
  }
}
