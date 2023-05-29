import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoadingDialog {
  static void show({String title = 'Loading...'}) {
    Get.dialog(Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Container(
          height: 40,
          child: Row(
            children: [
              const SizedBox(width: 20),
              const Center(child: CircularProgressIndicator.adaptive()),
              const SizedBox(width: 20),
              Text(title),
            ],
          ),
        ),
      ),
    ), barrierDismissible: false);
  }

  static void hide() {
    if (Get.isDialogOpen!) {
      Get.back();
    }
  }
}
