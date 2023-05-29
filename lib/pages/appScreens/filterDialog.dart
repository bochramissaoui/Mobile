import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:relead/utils/extension.dart';

import '../../controller/homeController/filterController.dart';
import '../../utils/global.colors.dart';

class FilterDialog{
  static final filterController = FilterController();

  static void show(Function(List<String>, List<String>) onApplyFilter) {
    filterController.onApplyFilter = onApplyFilter;
    Get.dialog(Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        height: 65.0.hp,
        width: 100.0.wp,
        padding: EdgeInsets.fromLTRB(6.0.wp, 3.0.hp, 6.0.wp, 4.0.hp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Filter By'.tr,
              style: GoogleFonts.montserrat(
                  color: GlobalColors.blackTextColor,
                  fontWeight: FontWeight.w700,
                  fontSize: 18.0.sp),
            ),
            SizedBox(height: 1.0.hp),
            Text(
              'Category'.tr,
              style: GoogleFonts.montserrat(
                  color: GlobalColors.blackTextColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 11.0.sp),
            ),
            SizedBox(height: 1.0.hp),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                getCategoryWidget("Cafés"),
                getCategoryWidget("Restaurents"),
                getCategoryWidget('Hotels'),
              ],
            ),
            SizedBox(height: 1.0.hp),
            Obx(() {
              if (filterController.selectedCategories.isNotEmpty) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'SubCategory'.tr,
                      style: GoogleFonts.montserrat(
                          color: GlobalColors.blackTextColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 11.0.sp),
                    ),
                    SizedBox(height: 1.0.hp),
                    getSubcategoryWidget(),SizedBox(height: 1.0.hp),
                  ],
                );
              } else {
                return const SizedBox.shrink();
              }
            }),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () =>filterController.submit(),
                  style: ButtonStyle(
                      minimumSize:
                      MaterialStateProperty.all(Size(9.0.wp, 3.5.hp)),
                      backgroundColor: MaterialStatePropertyAll<Color>(
                          GlobalColors.BlueColor),
                      shape: MaterialStateProperty.all<
                          RoundedRectangleBorder>(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(2.0.wp),
                      ))),
                  child: Text(
                    'Apply'.tr,
                    style: GoogleFonts.montserrat(
                        color: GlobalColors.WhiteColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 8.0.sp),
                  ),
                ),
                SizedBox(width: 2.0.wp),
                ElevatedButton(
                  onPressed: () =>Get.back(),
                  style: ButtonStyle(
                      minimumSize:
                      MaterialStateProperty.all(Size(9.0.wp, 3.5.hp)),
                      backgroundColor: MaterialStatePropertyAll<Color>(
                          GlobalColors.greyToWhiteColor),
                      shape: MaterialStateProperty.all<
                          RoundedRectangleBorder>(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(2.0.wp),
                      ))),
                  child: Text(
                    'Cancel'.tr,
                    style: GoogleFonts.montserrat(
                        color: GlobalColors.BlueColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 8.0.sp),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ));
  }

  static Widget getCategoryWidget(String category) {
    return Obx(() {
      bool isSelected = filterController.selectedCategories.contains(category);
      return GestureDetector(
        onTap: () {
          filterController.toggleCategory(category);
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 0,
                blurRadius: 5,
                offset: Offset(1, 3),
              ),
            ],
            border: Border.all(
              color: isSelected ? GlobalColors.blackTextColor : Colors.transparent,
              width: isSelected ? 2.1 : 0,
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Text(
            category,
            style: TextStyle(
              color: GlobalColors.blackTextColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),

      );
    });
  }

  static Widget getSubcategoryWidget() {
    List<String> subcategories = [];
    for (String category in filterController.selectedCategories) {
      switch (category) {
        case "Cafés":
          subcategories.addAll(['Cofé-resto', 'Café populaire','Buvette']);
          break;
        case 'Restaurents':
          subcategories.addAll(['Street-food', 'Grill','Croissanterie']);
          break;
        // case 'Lounge':
        //   subcategories.addAll(['Lounge_Sub1', 'Lounge_Sub2']);
        //   break;
      }
    }

    return Wrap(
      spacing: 5,
      runSpacing:7,
      children: subcategories
          .map((subcategory) => GestureDetector(
        onTap: () {
          filterController.toggleSubcategory(subcategory);
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 0,
                blurRadius: 5,
                offset: Offset(1, 3),
              ),
            ],
            border: Border.all(
              color: filterController.selectedSubcategories.contains(subcategory) ? GlobalColors.blackTextColor : Colors.transparent,
              width: filterController.selectedSubcategories.contains(subcategory) ? 2.1 : 0,
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Text(
            subcategory,
            style: TextStyle(
              color: GlobalColors.blackTextColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ))
          .toList(),
    );
  }
}