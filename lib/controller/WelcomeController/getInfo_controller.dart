import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../utils/api_endpoints.dart';

class GetInfoController extends GetxController{

  final Future<SharedPreferences> _prefs=SharedPreferences.getInstance();


  Future<void>getInfo()async{
    try{
      final SharedPreferences? prefs = await _prefs;
      String? token =prefs?.get('token').toString();
      var headers={'content-Type':'application/json','Authorization': 'Bearer $token'};
      var url=Uri.parse(ApiEndPoints.baseUrl+ApiEndPoints.authEndpoints.getCurrentUserInfo);
      http.Response response=
        await http.get(url,headers: headers);
      if(response.statusCode==200){
        final json =jsonDecode(response.body);

        bool phoneVerified=json["phoneVerified"];
        final SharedPreferences? prefsPHONEVERIFIED=await _prefs;
        await prefsPHONEVERIFIED?.setString('phoneVerified',phoneVerified.toString());

        var firstName=json["firstname"] ;
        final SharedPreferences? prefsFN=await _prefs;
        await prefsFN?.setString('firstName',firstName);

        var lastName=json["lastname"];
        final SharedPreferences? prefsLN=await _prefs;
        await prefsLN?.setString('lastName',lastName);

        var email=json["email"];
        final SharedPreferences? prefsEMAIL=await _prefs;
        await prefsEMAIL?.setString('email',email);

        int phone=json["phone"];
        final SharedPreferences? prefsPHONE=await _prefs;
        await prefsPHONE?.setString('phone',phone.toString());

        var img=json["img"];
        final SharedPreferences? prefsIMG=await _prefs;
        await prefsIMG?.setString('img',img.toString());


    }

    }catch(e){
      Fluttertoast.showToast(msg:e.toString(),timeInSecForIosWeb: 5);
    }
  }
}























