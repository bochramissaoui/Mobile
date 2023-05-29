import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:relead/utils/extension.dart';

import '../../../controller/profileController/changeProfilePicture/changeProfilePicture.dart';

class ChangeProfilePicture extends StatefulWidget {
  const ChangeProfilePicture({super.key});

  @override
  State<ChangeProfilePicture> createState() => _ChangeProfilePictureState();
}

class _ChangeProfilePictureState extends State<ChangeProfilePicture> {
  final ChangeProfilePictureController controller = Get.put(ChangeProfilePictureController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(7.0.wp, 30, 7.0.wp, 0),
            child: Row(
              children: [
                IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios,
                    size: 7.0.wp,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      'Upload'.tr,
                      style: GoogleFonts.montserrat(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 16.0.sp,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 50,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 22.0.hp,
          ),
          ElevatedButton(
            onPressed: controller.selectImageFromGallery,
            child: const Text('Select Image'),
          ),
          Obx(
                () => controller.selectedImage.value != null
                ? Image.file(controller.selectedImage.value!)
                : const SizedBox(),
          ),
          ElevatedButton(
            onPressed: controller.uploadImageToAPI,
            child: const Text('Confirm'),
          ),
        ],
      ),
    );
  }
}






































