import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../utils/api_endpoints.dart';
import '../../../utils/custom_widgets/loadingDialog.dart';
class ChangePassProfileController extends GetxController{
  TextEditingController passController=TextEditingController();
  final Future<SharedPreferences> _prefs=SharedPreferences.getInstance();

  Future<void>change()async{
    LoadingDialog.show();
    try{
      final SharedPreferences prefs = await _prefs;
      String email =prefs.get('email').toString();
      var headers={'content-Type':'application/json'};
      var url=Uri.parse('${ApiEndPoints.baseUrl}${ApiEndPoints.authEndpoints.newPassword}${email.trim()}&newPassword=${passController.text}');
      http.Response response=
      await http.post(url,headers: headers);
      if(response.statusCode==200){
        LoadingDialog.hide();
        passController.clear();
        Get.back();
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























