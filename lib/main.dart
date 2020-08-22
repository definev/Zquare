import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:Zquare/controller/game_controller.dart';
import 'package:Zquare/screen/game_screen.dart';
import 'package:Zquare/screen/home_screen.dart';
import 'package:get_storage/get_storage.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(GameController());
  GetStorage.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Zquare',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.pink,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
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
    );
  }
}
