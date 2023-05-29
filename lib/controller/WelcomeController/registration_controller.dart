import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../pages/welcomeScreens/verifyEmail_page.dart';
import '../../utils/api_endpoints.dart';
import 'package:flutter_map_tile_caching/flutter_map_tile_caching.dart';

import '../../utils/custom_widgets/loadingDialog.dart';

class RegistrationController extends GetxController{
  TextEditingController firstNameController=TextEditingController();
  TextEditingController lastNameController=TextEditingController();
  TextEditingController emailController=TextEditingController();
  TextEditingController passwordController=TextEditingController();
  TextEditingController phoneController=TextEditingController();

  late Widget verifyEmail;
  bool? isPressed;

  RegistrationController({required bool damagedDatabaseDeleted, required StoreDirectory store}) {
    verifyEmail = VerifyEmail(damagedDatabaseDeleted: damagedDatabaseDeleted, store: store);
  }

  Future<void>register()async{
    isPressed=true;
    LoadingDialog.show();
    try{
      var url=Uri.parse(ApiEndPoints.baseUrl+ApiEndPoints.authEndpoints.register);
      var headers={'content-Type':'application/json'};
      Map body={
        "firstname": firstNameController.text,
        "lastname": lastNameController.text,
        "email": emailController.text.trim(),
        "password":passwordController.text,
        "phone": phoneController.text,
        "img":""
      };
      var email=emailController.text;
      http.Response response=
      await http.post(url,body: jsonEncode(body),headers: headers);
      if(response.statusCode==200){

        LoadingDialog.hide();

        firstNameController.clear();
        lastNameController.clear();
        emailController.clear();
        passwordController.clear();
        phoneController.clear();

        Get.off(verifyEmail,arguments: {'email': email});
        throw jsonDecode(response.body)["message"]??"Unknown Error Occurred";
      }else if(response.statusCode==404){
        LoadingDialog.hide();
        Get.off(verifyEmail,arguments: {'email':email});
        throw jsonDecode(response.body)["message"]??"Unknown Error Occurred";
      }else{
        LoadingDialog.hide();
        throw jsonDecode(response.body)["message"]??"Unknown Error Occurred";
      }
    }catch(e){
      Fluttertoast.showToast(msg:e.toString(),timeInSecForIosWeb: 5);
    }
  }
}























