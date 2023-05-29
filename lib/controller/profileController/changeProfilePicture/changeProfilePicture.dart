
import 'dart:convert';
import 'dart:io';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;


import '../../../utils/api_endpoints.dart';
import '../../../utils/custom_widgets/loadingDialog.dart';
import '../../WelcomeController/getInfo_controller.dart';


class ChangeProfilePictureController extends GetxController {
  final ImagePicker _picker = ImagePicker();
  Rx<File?> selectedImage = Rx<File?>(null);
  final Future<SharedPreferences> _prefs=SharedPreferences.getInstance();
  final GetInfoController getInfoCcontroller = Get.put(GetInfoController());

  Future<void> selectImageFromGallery() async {
    final pickedFile = await _picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      selectedImage.value = File(pickedFile.path);
    }
  }

  Future<void> uploadImageToAPI() async {
    if (selectedImage.value != null) {
      // Get the file from selectedImage.value
      var imageFile = selectedImage.value!;

      LoadingDialog.show();

      try {
        final SharedPreferences? prefs = await _prefs;
        String? token = prefs?.get('token').toString();

        // Create the request URL and headers
        var headers = {
          'accept': '*/*',
          'Authorization': 'Bearer $token',
        };
        var url=Uri.parse(ApiEndPoints.baseUrl+ApiEndPoints.authEndpoints.uploadImage);

        // Create a multipart request
        var request = http.MultipartRequest('POST', url);

        // Add the file to the request
        var multipartFile = await http.MultipartFile.fromPath('file', imageFile.path);
        request.files.add(multipartFile);

        // Add headers to the request
        request.headers.addAll(headers);

        // Send the request and get the response
        var response = await request.send();

        // Check the response status code
        if (response.statusCode == 200) {
          LoadingDialog.hide();
          getInfoCcontroller.getInfo();
          throw 'Image uploaded successfully';
        } else {
          LoadingDialog.hide();
          throw 'Image upload failed';
        }

      } catch (e) {
        Fluttertoast.showToast(msg: e.toString(), timeInSecForIosWeb: 5);
      }
    }
  }

}