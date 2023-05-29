import 'package:get/get.dart';
import 'package:relead/utils/langs/en.dart';
import 'package:relead/utils/langs/fr.dart';

class Translation extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {'en': en, 'fr': fr};
}
