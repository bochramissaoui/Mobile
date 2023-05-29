import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:relead/utils/local_storage/local_storage.dart';

class AppLanguageController extends GetxController {
  var appLocale = 'fr';
  @override
  void onInit() async {
    super.onInit();
    LocalStrorage localStorage = LocalStrorage();
    appLocale = await localStorage.languageSelected == null
        ? 'fr'
        : await localStorage.languageSelected;
    Get.updateLocale(Locale(appLocale));
    update();
  }

  void changeLanguage(String type) async {
    LocalStrorage localStrorage = LocalStrorage();
    if (appLocale == type) {
      return;
    }
    if (type == 'fr') {
      appLocale = 'fr';
      localStrorage.saveLanguageToDisk('fr');
    } else {
      appLocale = 'en';
      localStrorage.saveLanguageToDisk('en');
    }
    update();
  }
  String languageSelected()  {

    return appLocale;
  }
}
