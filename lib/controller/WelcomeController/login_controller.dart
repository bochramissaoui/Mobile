import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map_tile_caching/flutter_map_tile_caching.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:relead/pages/appScreens/home_page.dart';
import 'package:relead/pages/welcomeScreens/verifyemail_page.dart';
import 'package:relead/utils/custom_widgets/loadingDialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../utils/api_endpoints.dart';

class LoginController extends GetxController{
  TextEditingController emailController=TextEditingController();
  TextEditingController passwordController=TextEditingController();

  final Future<SharedPreferences> _prefs=SharedPreferences.getInstance();
  late Widget homePage;
  late Widget verifyEmail;

  LoginController({required bool damagedDatabaseDeleted, required StoreDirectory store}) {
    homePage = Home(damagedDatabaseDeleted: damagedDatabaseDeleted, store: store);
    verifyEmail = VerifyEmail(damagedDatabaseDeleted: damagedDatabaseDeleted, store: store);
  }
  Future<void>login()async{
    LoadingDialog.show();
    try{
      var headers={'content-Type':'application/json'};
      var url=Uri.parse(ApiEndPoints.baseUrl+ApiEndPoints.authEndpoints.login);
      Map body={
        "email": emailController.text,
        "password":passwordController.text,
      };
      http.Response response=
      await http.post(url,body: jsonEncode(body),headers: headers);
      if(response.statusCode==200){
        LoadingDialog.hide();

        final json =jsonDecode(response.body);
        var token=json["token"];
        final SharedPreferences? prefs=await _prefs;
        await prefs?.setString('token',token);

        emailController.clear();
        passwordController.clear();

        Get.off(homePage);
        throw jsonDecode(response.body)["message"]??"Unknown Error Occurred";
      }else if(response.statusCode==404){
        LoadingDialog.hide();
        Get.to(verifyEmail,arguments: {'email':emailController.text});
        throw jsonDecode(response.body)["message"]??"Unknown Error Occurred";
      }else{
        LoadingDialog.hide();
        throw jsonDecode(response.body)["message"]??"Unknown Error Occurred";
      }

    }catch(e){
      Fluttertoast.showToast(msg:e.toString(),timeInSecForIosWeb: 5);
    }




// Get markers,categories,subcategories data and save them in shared preferences

    final prefs = await SharedPreferences.getInstance();
      var headers={'content-Type':'application/json'};
      var markersUrl=Uri.parse(ApiEndPoints.baseUrl+ApiEndPoints.authEndpoints.getZones);
      http.Response markersResponse = await http.get(markersUrl, headers: headers);
      if (markersResponse.statusCode == 200) {
        final List<dynamic> markerList = json.decode(markersResponse.body);
        final jsonString = json.encode(markerList);
        await prefs.setString('markerList', jsonString);
      }


    final categoriesUrl =
    Uri.parse(ApiEndPoints.baseUrl + ApiEndPoints.authEndpoints.getCategories);
    final categoriesResponse = await http.get(categoriesUrl, headers: headers);
    if (categoriesResponse.statusCode == 200) {
      final List<dynamic> categoriesList = json.decode(categoriesResponse.body);
      final jsonString = json.encode(categoriesList);
      await prefs.setString('Categories', jsonString);
    }


    final subCategoriesUrl =
    Uri.parse(ApiEndPoints.baseUrl + ApiEndPoints.authEndpoints.getSubCategories);
    final subCategoriesResponse = await http.get(subCategoriesUrl, headers: headers);
    if (subCategoriesResponse.statusCode == 200) {
      final List<dynamic> subCategoriesList = json.decode(subCategoriesResponse.body);
      final jsonString = json.encode(subCategoriesList);
      await prefs.setString('SubCategories', jsonString);
    }


  }
}