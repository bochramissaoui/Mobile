import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map_tile_caching/flutter_map_tile_caching.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:relead/pages/welcomeScreens/login_page.dart';

import '../../pages/appScreens/home_page.dart';
import '../../utils/api_endpoints.dart';
import '../../utils/custom_widgets/loadingDialog.dart';

class VerifyEmailController extends GetxController{
  TextEditingController loginCodeController=TextEditingController();
  late Widget loginPage;

  VerifyEmailController({required bool damagedDatabaseDeleted, required StoreDirectory store}) {
    loginPage = LoginPage(damagedDatabaseDeleted: damagedDatabaseDeleted, store: store);
  }
  Future<void>verify()async{
    LoadingDialog.show();
    try{
      var url=Uri.parse(ApiEndPoints.baseUrl+ApiEndPoints.authEndpoints.registerToken+loginCodeController.text);
      var headers={'content-Type':'application/json'};
      http.Response response=
      await http.post(url,headers: headers);
      if(response.statusCode==200){
        LoadingDialog.hide();
        loginCodeController.clear();
        Get.off(loginPage);
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























