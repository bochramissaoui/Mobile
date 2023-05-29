import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:relead/controller/profileController/changeEmailController/currentEmailVerif_controller.dart';
import 'package:relead/pages/profileScreens/changeProfilePicture/changeProfilePicture.dart';
import 'package:relead/utils/extension.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../controller/profileController/changePasswordController/sendEmailToken_controller.dart';
import '../../controller/profileController/phoneController/sendPhoneToken.dart';
import '../../utils/global.colors.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});


  @override
  State<ProfilePage> createState() => _ProfilePageState();
}


class _ProfilePageState extends State<ProfilePage> {
  final Future<SharedPreferences> _prefs=SharedPreferences.getInstance();
  CurrentEmailVerifController  currentEmailVerifController = Get.put( CurrentEmailVerifController());
  SendEmailTokenController  sendEmailTokenController = Get.put( SendEmailTokenController());
  SendPhoneController  sendPhoneController = Get.put( SendPhoneController());



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
                    'Profile'.tr,
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
          height: 10.0.hp,
        ),

        Padding(
          padding:  EdgeInsets.symmetric(horizontal: 7.0.wp),
          child: Row(
            children: [
              Stack(
                children: <Widget>[
                  SizedBox(
                    width: 22.0.wp,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(1000),
                      child: const Image(
                        image: AssetImage(
                          'assets/images/half_circle.png',
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(2.0.wp),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(400.0),
                      child: FutureBuilder<SharedPreferences>(
                        future: _prefs,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            final imageUrl = snapshot.data!.getString('img');
                            if (imageUrl != null && imageUrl.isNotEmpty) {
                              return Image.network(
                                imageUrl,
                                height: 18.0.wp,
                                width: 18.0.wp,
                                errorBuilder: (context, error, stackTrace) {
                                  // In case the network image fails to load, display the default image
                                  return Image.network(
                                    'https://storage.googleapis.com/relead-maps.appspot.com/abed4f33-3edc-4308-95f6-44fbbfd1ee21.png',
                                    height: 18.0.wp,
                                    width: 18.0.wp,
                                  );
                                },
                              );
                            }
                          }
                          // If 'img' is null or empty, or if there's an error retrieving the shared preferences,
                          // display the default image
                          return Image.network(
                            'https://storage.googleapis.com/relead-maps.appspot.com/abed4f33-3edc-4308-95f6-44fbbfd1ee21.png',
                            height: 18.0.wp,
                            width: 18.0.wp,
                          );
                        },
                      ),
                    ),
                  ),


                ],
              ),
              //grey line
              Padding(
                padding:  EdgeInsets.fromLTRB(3.0.wp, 0, 5.0.wp, 0),
                child: Container(
                  width: 0.5.hp,
                  height: 17.5.wp,
                  decoration: BoxDecoration(
                      color: const Color(0xffF2F2F2),
                      borderRadius: BorderRadius.circular(25)),
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Icon(
                          size:6.0.wp,
                          Icons.mail_outline,
                          color: const Color(0xff737373),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 2.0.wp),
                          child:

                          FutureBuilder(
                            future: getStringValue('email'), // the key to retrieve a string from SharedPreferences
                            builder: (BuildContext context, AsyncSnapshot snapshot) {
                              if(snapshot.hasData){

                                return Text('${snapshot.data}',
                                    style: GoogleFonts.montserrat(
                                        color: const Color(0xff737373),
                                        fontWeight: FontWeight.w300,
                                        fontSize: 8.0.sp));
                              }else {return Text("loading...",
                                  style: GoogleFonts.montserrat(
                                      color: const Color(0xff737373),
                                      fontWeight: FontWeight.w300,
                                      fontSize: 8.0.sp));}
                            },
                          ),


                        )
                      ],
                    ),
                    SizedBox(
                      height: 1.0.hp,
                    ),
                    Row(
                      children: [
                        Icon(size:6.0.wp,
                          Icons.phone_android_outlined,
                          color: const Color(0xff737373),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 2.0.wp),
                          child: FutureBuilder(
                            future: getStringValue('phone'), // the key to retrieve a string from SharedPreferences
                            builder: (BuildContext context, AsyncSnapshot snapshot) {
                              if(snapshot.hasData){

                                return Text('${snapshot.data}',
                                    style: GoogleFonts.montserrat(
                                        color: const Color(0xff737373),
                                        fontWeight: FontWeight.w300,
                                        fontSize: 8.0.sp));
                              }else {return Text("loading...",
                                  style: GoogleFonts.montserrat(
                                      color: const Color(0xff737373),
                                      fontWeight: FontWeight.w300,
                                      fontSize: 8.0.sp));}
                            },
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height:3.0.hp,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 7.0.wp),
          child: Row(
            children: [
              FutureBuilder(
                future: getStringValue('lastName'), // the key to retrieve a string from SharedPreferences
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if(snapshot.hasData){
                    return Text('${snapshot.data}',
                        textAlign: TextAlign.start,
                        style: GoogleFonts.montserrat(
                            color: GlobalColors.BlueColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 35.0.sp));
                  }else {return Text('Loading',
                      textAlign: TextAlign.start,
                      style: GoogleFonts.montserrat(
                          color: GlobalColors.BlueColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 35.0.sp));}
                },
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 7.0.wp),
          child: Row(
            children: [
              FutureBuilder(
                future: getStringValue('firstName'), // the key to retrieve a string from SharedPreferences
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if(snapshot.hasData){
                    return Text('${snapshot.data}',
                        textAlign: TextAlign.start,
                        style:GoogleFonts.montserrat(
                        color: Colors.black,
                        fontWeight: FontWeight.w300,
                        fontSize: 35.0.sp));
                  }else {return Text('Loading',
                      textAlign: TextAlign.start,
                      style: GoogleFonts.montserrat(
                          color: GlobalColors.BlueColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 35.0.sp));}
                },
              ),
            ],
          ),
        ),
        //Update profile pic
        Padding(
            padding: EdgeInsets.fromLTRB(7.0.wp, 3.0.hp, 7.0.wp, 0),
            child: Row(
              children: [
                Container(
                    height: 11.5.wp,
                    width: 11.5.wp,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        color: Color(0xffCDE9FF)),
                    child:
                        Icon(Icons.person,
                            size: 8.0.wp, color: const Color(0xff0090FF))),
                SizedBox(
                  width: 4.0.wp,
                ),
                Expanded(
                  child: Text(
                    'Update your profile picture'.tr,
                    style: GoogleFonts.montserrat(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 9.0.sp),
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) =>
                        const ChangeProfilePicture()));
                  },
                  child: Container(
                    height: 11.5.wp,
                    width: 11.5.wp,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(1.8.wp)),
                        color: const Color(0xffF4F4F4)),
                    child: Icon(
                      size: 5.8.wp,
                          Icons.arrow_forward_ios,
                          color: const Color(0xff89898B),
                        )),
                )
              ],
            )),
        //update mail
        Padding(
            padding: EdgeInsets.fromLTRB(7.0.wp, 3.0.hp, 7.0.wp, 0),
            child: Row(
              children: [
                Container(
                    height: 11.5.wp,
                    width: 11.5.wp,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        color: Color(0xffFFE1F1)),
                    child:  Icon(Icons.mail_outline,
                        size: 8.0.wp, color: const Color(0xffFE6BBB))),
                SizedBox(
                  width: 4.0.wp,
                ),
                Expanded(
                  child: Text(
                    'Update your Email'.tr,
                    style: GoogleFonts.montserrat(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 9.0.sp),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    currentEmailVerifController.sendToken();
                  },
                  child: Container(
                    height: 11.5.wp,
                    width: 11.5.wp,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(1.8.wp)),
                        color: const Color(0xffF4F4F4)),
                    child: Icon(
                      size: 5.8.wp,
                      Icons.arrow_forward_ios,
                      color: const Color(0xff89898B),
                    )
                  ),
                )
              ],
            )),
        //confirm phone number
        Padding(
            padding: EdgeInsets.fromLTRB(7.0.wp, 3.0.hp, 7.0.wp, 0),
            child: Row(
              children: [
                Container(
                    height: 11.5.wp,
                    width: 11.5.wp,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        color: Color(0xffD1F7EA)),
                    child:  Icon(Icons.phone_android_outlined,
                        size: 8.0.wp, color: const Color(0xff1BD598))),
                SizedBox(
                  width: 4.0.wp,
                ),
                // Expanded(
                //   child: Text(phoneVerificationStatus ? "Phone number verified":'Confirm your phone number'.tr,
                //     style: GoogleFonts.montserrat(
                //         color: Colors.black,
                //         fontWeight: FontWeight.w500,
                //         fontSize: 9.0.sp),
                //   ),
                // ),
                FutureBuilder<String>(
                  future: getStringValue('phoneVerified'),
                  builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                    if (snapshot.hasData) {
                      final phoneVerified = snapshot.data!;
                      print('phoneVerified: $phoneVerified');

                      bool phoneVerificationStatus;
                      if (phoneVerified == 'true') {
                        phoneVerificationStatus = true;
                      } else {
                        phoneVerificationStatus = false;
                      }
                      print('phoneVerificationStatus: $phoneVerificationStatus');

                      return Expanded(
                        child: Text(phoneVerificationStatus ? "Phone number verified":'Confirm your phone number'.tr,
                          style: GoogleFonts.montserrat(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 9.0.sp),
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      return CircularProgressIndicator();
                    }
                  },
                ),


                FutureBuilder<String>(
                  future: getStringValue('phoneVerified'),
                  builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                    if (snapshot.hasData) {
                      final phoneVerified = snapshot.data!;
                      print('phoneVerified: $phoneVerified');

                      bool phoneVerificationStatus;
                      if (phoneVerified == 'true') {
                        phoneVerificationStatus = true;
                        return Container(
                                      height: 11.5.wp,
                                      width: 11.5.wp,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(Radius.circular(1.8.wp)),
                                          color: const Color(0xffF4F4F4)),
                                      child: Icon(
                                        size: 5.8.wp,
                                        Icons.check,
                                        color: const Color(0xff89898B),
                                      )
                                  );
                      } else {
                        phoneVerificationStatus = false;
                        return GestureDetector(
                                  onTap: () {
                                    sendPhoneController.send();
                                  },
                                  child: Container(
                                      height: 11.5.wp,
                                      width: 11.5.wp,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(Radius.circular(1.8.wp)),
                                          color: const Color(0xffF4F4F4)),
                                      child: Icon(
                                        size: 5.8.wp,
                                        Icons.arrow_forward_ios,
                                        color: const Color(0xff89898B),
                                      )
                                  ),
                                );
                      }


                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      return CircularProgressIndicator();
                    }
                  },
                )

              ],
            )),
        //change pass
        Padding(
            padding: EdgeInsets.fromLTRB(7.0.wp, 3.0.hp, 7.0.wp, 0),
            child: Row(
              children: [
                Container(
                    height: 11.5.wp,
                    width: 11.5.wp,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        color: Color(0xffD8D7F7)),
                    child: Padding(
                        padding: EdgeInsets.all(.0.wp),
                        child: Icon(Icons.key,
                            size: 8.0.wp, color: const Color(0xff3C37DB)))),
               SizedBox(
                  width: 4.0.wp,
                ),
                Expanded(
                  child: Text(
                    'Change your password'.tr,
                    style: GoogleFonts.montserrat(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 12),
                  ),
                ),

            GestureDetector(
                onTap: () {
                  sendEmailTokenController.send();
                },
                child: Container(
                    height: 11.5.wp,
                    width: 11.5.wp,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(1.8.wp)),
                        color: const Color(0xffF4F4F4)),
                    child: Icon(
                      size: 5.8.wp,
                      Icons.arrow_forward_ios,
                      color: const Color(0xff89898B),
                    )
                ),
              ),
                
              ],
            )),
        TextButton(onPressed: ()async{
          final SharedPreferences? prefs = await _prefs;
          String? phoneVerified =prefs?.get('phoneVerified').toString();
          String? firstName =prefs?.get('firstName').toString();
          String? lastName =prefs?.get('lastName').toString();
          String? email =prefs?.get('email').toString();
          String? phone =prefs?.get('phone').toString();
          String? img =prefs?.get('img').toString();

          print(firstName);
          print(lastName);
          print(email);
          print(phone);
          print(phoneVerified);
          print(img);
        }, child:Text("print the user info")),
        TextButton(onPressed: ()async{
          final SharedPreferences? prefs = await _prefs;
          print(prefs?.get('token'));
        }, child:Text("print the token")),
        //
        //
      ]),
    ));
  }
}

Future<String> getStringValue(String key) async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString(key) ?? '';
}