import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:Zquare/utils/utils.dart';

enum GameState {
  start,
  end,
}

class GameController extends GetxController {
  int randSpawn = Random().nextInt(25);
  int curPos = Random().nextInt(25);
  int timeToMove = 2800;
  RxInt currentScore = 0.obs;

  double endState = 1.0;

  ///State of game
  GameState gameState = GameState.end;

  ///Control barrier animation
  AnimationController animationController;

  ///Game storage
  GameStorage gameStorage = GameStorage();

  ///Set state of game
  void setStart(GameState value) {
    gameState = value;
    if (gameState == GameState.start) animationController.forward();
    update();
  }

  void initCurrentScore() => currentScore.value = 0;
  void increaseCurrentScore() => currentScore.value++;

  void setEndState() {
    if (endState == 1.0)
      endState = 0.0;
    else
      endState = 1.0;

    update();
  }

  Color getColor(int index) {
    if (index == curPos) {
      return Colors.red[300];
    } else if (index == randSpawn) {
      return ZquareColors.pinkMedium;
    } else {
      return ZquareColors.pinkBold;
    }
  }

  void changePos(int newPos) {
    curPos = newPos;
    update();
  }

  // void levelUp(int level) {
  //   if (level <= 10)
  //     timeToMove = 1400;
  //   else if (level <= 20)
  //     timeToMove = 1000;
  //   else if (level <= 50)
  //     timeToMove = 700;
  //   else
  //     timeToMove = 600;
  //   update();
  // }

  void changeSpawn() {
    randSpawn = Random().nextInt(25);
    while (randSpawn == curPos) randSpawn = Random().nextInt(25);
    update();
  }
}
