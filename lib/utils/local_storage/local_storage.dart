import 'package:get_storage/get_storage.dart';

class LocalStrorage {
  void saveLanguageToDisk(String language) async {
    await GetStorage().write('lang', language);
  }

  Future<String> get languageSelected async {
    return await GetStorage().read('lang');
  }
}
