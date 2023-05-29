import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../pages/profileScreens/updateYourEmail/NewEmailVerification.dart';
import '../../../utils/api_endpoints.dart';
import '../../../utils/custom_widgets/loadingDialog.dart';
class NewEmailTokenController extends GetxController{
  TextEditingController newEmailController=TextEditingController();
  final Future<SharedPreferences> _prefs=SharedPreferences.getInstance();
  Future<void>verify()async{
    LoadingDialog.show();
    try{
      final SharedPreferences? prefs = await _prefs;
      String? token =prefs?.get('token').toString();
      var headers={'content-Type':'application/json','Authorization': 'Bearer $token'};
      var url=Uri.parse(ApiEndPoints.baseUrl+ApiEndPoints.authEndpoints.sendNewEmailToken+newEmailController.text.trim());
      http.Response response=
      await http.post(url,headers: headers);
      if(response.statusCode==200){
        LoadingDialog.hide();
        Get.off(const NewEmailVerification(),arguments: {'newEmail':newEmailController.text});
        newEmailController.clear();
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























