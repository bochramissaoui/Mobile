import 'package:get/get.dart';

class FilterController extends GetxController {
  final selectedCategories = <String>[].obs;
  final selectedSubcategories = <String>[].obs;
  late Function(List<String>, List<String>) onApplyFilter;



  void toggleCategory(String category) {
    if (selectedCategories.contains(category)) {
      selectedCategories.remove(category);
      selectedSubcategories.removeWhere((subcategory) => subcategory.startsWith(category));
    } else {
      selectedCategories.add(category);
    }
  }

  void toggleSubcategory(String subcategory) {
    if (selectedSubcategories.contains(subcategory)) {
      selectedSubcategories.remove(subcategory);
    } else {
      selectedSubcategories.add(subcategory);
    }
  }

  void submit() {
    print('Selected Categories: $selectedCategories');
    print('Selected Subcategories: $selectedSubcategories');
    onApplyFilter(selectedCategories, selectedSubcategories);
    Get.back(); // Close the filter dialog
  }
}