import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:relead/pages/welcomeScreens/changePass_page.dart';
import '../../utils/api_endpoints.dart';
import '../../utils/custom_widgets/loadingDialog.dart';
class VerifyMailForPassController extends GetxController{
  TextEditingController passCodeController=TextEditingController();
  late final String email;
  Future<void>verify()async{
    LoadingDialog.show();
    try{
      var headers={'content-Type':'application/json'};
      var url=Uri.parse(ApiEndPoints.baseUrl+ApiEndPoints.authEndpoints.forgotPasswordToken+passCodeController.text);
      http.Response response=
      await http.post(url,headers: headers);
      if(response.statusCode==200){
        LoadingDialog.hide();
        Get.off(const ChangePass(),arguments: {'email':email});
        passCodeController.clear();
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























