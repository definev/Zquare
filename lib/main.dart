import 'package:Zquare/controller/setting_controller.dart';
import 'package:Zquare/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:Zquare/controller/game_controller.dart';
import 'package:Zquare/screen/game_screen.dart';
import 'package:Zquare/screen/home_screen.dart';
import 'package:get_storage/get_storage.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  GetStorage.init();
  Get.put(GameController());
  Get.put(SettingController());
  runApp(MyApp());
}

class MyApp extends GetWidget<SettingController> {
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => GetMaterialApp(
        title: 'Zquare',
        debugShowCheckedModeBanner: false,
        theme: ZquareTheme.light,
        darkTheme: ZquareTheme.dark,
        themeMode: controller.isDark.value ? ThemeMode.dark : ThemeMode.light,
        initialRoute: '/',
        getPages: [
          GetPage(
            name: '/',
            page: () => HomeScreen(),
            transition: Transition.zoom,
          ),
          GetPage(
            name: '/game',
            page: () => GameScreen(),
            transition: Transition.zoom,
          ),
        ],
      ),
    );
  }
}
