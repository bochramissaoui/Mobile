
import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../pages/welcomeScreens/verifyMailForPass.dart';
import '../../utils/api_endpoints.dart';
import '../../utils/custom_widgets/loadingDialog.dart';
class RestPassByEmailController extends GetxController{
  TextEditingController emailController=TextEditingController();

  Future<void>send()async{
    try{
      LoadingDialog.show();
      var url=Uri.parse(ApiEndPoints.baseUrl+ApiEndPoints.authEndpoints.sendForgotPasswordToken+emailController.text.trim());
      var headers={'content-Type':'application/json'};
      http.Response response=
      await http.post(url,headers: headers);
      if(response.statusCode==200){
        LoadingDialog.hide();
        Get.off(const VerifyEmailForPass(),arguments: {'email':emailController.text});
        emailController.clear();
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























