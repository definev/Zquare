import 'package:Zquare/controller/game_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GameOverPopUp extends GetWidget<GameController> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        controller.initCurrentScore();
        Get.back();
      },
      child: Container(
        color: Colors.transparent,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Center(
          child: Material(
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
                        style: Get.textTheme.headline1,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Score: ",
                            style: Get.textTheme.bodyText1,
                          ),
                          Text(
                            controller.currentScore.value.toString(),
                            style: Get.textTheme.bodyText1,
                          ),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        height: 80,
                        width: 250,
                        decoration: BoxDecoration(
                          color: Get.theme.buttonColor,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: InkWell(
                          onTap: () {
                            controller.initCurrentScore();
                            Get.back();
                          },
                          child: Center(
                            child: Text(
                              "Play again",
                              style: Get.textTheme.button,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 15),
                      Container(
                        height: 80,
                        width: 250,
                        decoration: BoxDecoration(
                          color: Get.theme.buttonColor,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: InkWell(
                          onTap: () {
                            controller.initCurrentScore();
                            Get.offAllNamed('/');
                          },
                          child: Center(
                            child: Text(
                              "Home",
                              style: Get.textTheme.button,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
