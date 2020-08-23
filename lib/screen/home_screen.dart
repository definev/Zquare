import 'package:Zquare/controller/game_controller.dart';
import 'package:Zquare/controller/setting_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  final GameController gameController = GetInstance().find<GameController>();
  final SettingController settingController =
      GetInstance().find<SettingController>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        color: Theme.of(context).backgroundColor,
        alignment: Alignment.center,
        child: Center(
          child: Container(
            height: 515,
            width: 515,
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Text(
                      "Zquare",
                      style: Theme.of(context).textTheme.headline1,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "High score: ",
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                        Text(
                          gameController.gameStorage.highscore.toString(),
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                      ],
                    ),
                  ],
                ),
                Container(
                  height: 80,
                  width: 250,
                  decoration: BoxDecoration(
                    color: Theme.of(context).buttonColor,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: InkWell(
                    onTap: () => Get.toNamed('/game'),
                    child: Center(
                      child: Text(
                        "Play",
                        style: Theme.of(context).textTheme.button,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 250,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Dark mode",
                        style: Theme.of(context).textTheme.bodyText1.copyWith(
                              color:
                                  Theme.of(context).textTheme.headline1.color,
                            ),
                      ),
                      Obx(
                        () => CupertinoSwitch(
                          onChanged: (bool _) => settingController.changeMode(),
                          value: settingController.isDark.value,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
