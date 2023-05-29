import 'dart:async';
import 'dart:convert';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:relead/pages/profileScreens/confirmPhone/VerifyPhone.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../../utils/api_endpoints.dart';
import '../../../utils/custom_widgets/loadingDialog.dart';


class SendPhoneController extends GetxController{

  final Future<SharedPreferences> _prefs=SharedPreferences.getInstance();


  Future<void>send()async{
    LoadingDialog.show();
    try{
      final SharedPreferences prefs = await _prefs;
      String token =prefs.get('token').toString();
      String phone =prefs.get('phone').toString();
      var headers={'content-Type':'application/json','Authorization': 'Bearer $token'};
      var url=Uri.parse(ApiEndPoints.baseUrl+ApiEndPoints.authEndpoints.sendPhoneToken+phone.toString());
      http.Response response=
      await http.get(url,headers: headers);
      if(response.statusCode==200){
        LoadingDialog.hide();
        Get.to(const VerifyPhone());
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























