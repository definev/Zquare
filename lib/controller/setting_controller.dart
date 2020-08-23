import 'package:Zquare/utils/utils.dart';
import 'package:get/get.dart';

class SettingController extends GetxController {
  static SettingStorage settingStorage = SettingStorage();
  RxBool isDark = settingStorage.isDark.obs;

  void changeMode() {
    isDark.value = !isDark.value;
    // if (isDark.value) {
    //   Get.changeTheme(ZquareTheme.dark);
    // } else {
    //   Get.changeTheme(ZquareTheme.light);
    // }
    SettingController.settingStorage.setIsDark(isDark.value);
  }
}
