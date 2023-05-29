import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../pages/profileScreens/updateYourEmail/NewEmail.dart';
import '../../../utils/api_endpoints.dart';
import '../../../utils/custom_widgets/loadingDialog.dart';
class CurrentEmailTokenController extends GetxController{
  TextEditingController oldEmailCodeController=TextEditingController();

  Future<void>verify()async{
    LoadingDialog.show();
    try{
      var url=Uri.parse(ApiEndPoints.baseUrl+ApiEndPoints.authEndpoints.oldEmailToken+oldEmailCodeController.text);
      var headers={'content-Type':'application/json'};
      http.Response response=
      await http.post(url,headers: headers);
      if(response.statusCode==200){
        LoadingDialog.hide();
        oldEmailCodeController.clear();
        Get.off(const NewEmail());
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























