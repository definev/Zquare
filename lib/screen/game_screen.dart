import 'package:Zquare/model/barrier.dart';
import 'package:Zquare/model/cube.dart';
import 'package:Zquare/screen/game_over_pop_up.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:Zquare/controller/game_controller.dart';
import 'package:Zquare/utils/utils.dart';
import 'package:google_fonts/google_fonts.dart';

enum Orientation {
  height,
  width,
}

double boardSize = 515;

class GameScreen extends GetWidget<GameController> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        color: ZquareColors.pinkRegular,
        child: Stack(
          children: [
            _playBoard(),
            BarrierWidget(),
            Container(
              height: (size.height - boardSize) / 2,
              alignment: Alignment.center,
              child: Obx(
                () => Text(
                  controller.currentScore.value.toString(),
                  style: GoogleFonts.cabin(
                    fontSize: 75,
                    color: ZquareColors.pinkBold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Center _playBoard() {
    return Center(
      child: Container(
        height: boardSize,
        width: boardSize,
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: ZquareColors.pinkLight,
          borderRadius: BorderRadius.circular(5),
        ),
        child: GetBuilder<GameController>(
          init: controller,
          builder: (controller) => GridView.count(
            crossAxisCount: 5,
            crossAxisSpacing: 15,
            mainAxisSpacing: 15,
            children: List.generate(
              25,
              (index) => InkWell(
                onTap: () {
                  if (index != controller.curPos) controller.changePos(index);
                  if (controller.animationController != null) {
                    if (controller.gameState == GameState.end) {
                      controller.animationController.forward();
                      controller.setStart(GameState.start);
                    }
                  }
                },
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 85),
                  decoration: BoxDecoration(
                    color: controller.getColor(index),
                    borderRadius: index == controller.curPos
                        ? BorderRadius.circular(5)
                        : BorderRadius.circular(5),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class BarrierWidget extends StatefulWidget {
  const BarrierWidget({
    Key key,
  }) : super(key: key);

  @override
  _BarrierWidgetState createState() => _BarrierWidgetState();
}

class _BarrierWidgetState extends State<BarrierWidget>
    with SingleTickerProviderStateMixin {
  GameController get controller => Get.find();

  Size size;

  double halfSize(Size size, Orientation orientation) {
    if (orientation == Orientation.width)
      return (size.width - 515) / 2;
    else
      return (size.height - 515) / 2;
  }

  int get getSpawnRowPos => controller.randSpawn % 5;

  int get getSpawnColumnPos => controller.randSpawn ~/ 5;

  int get getCurrentRowPos => controller.curPos % 5;

  int get getCurrentColumnPos => controller.curPos ~/ 5;

  void resetGame(String message) {
    if (controller.currentScore.value > controller.gameStorage.highscore)
      controller.gameStorage.setHighscore(controller.currentScore.value);
    controller.animationController.stop();
    controller.animationController.value = 0.000000004;
    if (!Get.isDialogOpen) Get.dialog(GameOverPopUp());
    controller.setStart(GameState.end);
  }

  bool looseCalculation(
    double leftBarrier,
    double rightBarrier,
    double currentLeft,
    double currentRight,
    int spawnPosition,
    int currentPosition,
  ) {
    if (((leftBarrier >= currentLeft && leftBarrier <= currentRight) ||
            (rightBarrier >= currentLeft && rightBarrier <= currentRight)) &&
        spawnPosition != currentPosition) {
      return true;
    } else {
      return false;
    }
  }

  void isLoose(double colPos, double rowPos, Size size) {
    Cube curCube = Cube(
      left: (getCurrentRowPos + 1) * 15.0 + getCurrentRowPos * 85.0,
      right: 85 + (getCurrentRowPos + 1) * 15.0 + getCurrentRowPos * 85.0,
      top: (getCurrentColumnPos + 1) * 15.0 + getCurrentColumnPos * 85.0,
      bottom:
          85 + (getCurrentColumnPos + 1) * 15.0 + getCurrentColumnPos * 85.0,
    );

    if (colPos >= halfSize(size, Orientation.width) - 85.0 &&
        colPos <= halfSize(size, Orientation.width) + 500.0) {
      colPos = colPos - (halfSize(size, Orientation.width) + 15);
      Barrier colBarrier =
          Barrier(leftBarrier: colPos, rightBarrier: colPos + 85.0);

      bool isLoose = looseCalculation(
        colBarrier.leftBarrier,
        colBarrier.rightBarrier,
        curCube.left,
        curCube.right,
        getSpawnColumnPos,
        getCurrentColumnPos,
      );
      if (isLoose) {
        resetGame("Col loose!!!");
      }
    }

    if (rowPos >= halfSize(size, Orientation.height) - 85.0 &&
        rowPos <= halfSize(size, Orientation.height) + 500) {
      rowPos = rowPos - (halfSize(size, Orientation.height) + 15);
      Barrier rowBarrier =
          Barrier(leftBarrier: rowPos, rightBarrier: rowPos + 85);

      bool isLoose = looseCalculation(
        rowBarrier.leftBarrier,
        rowBarrier.rightBarrier,
        curCube.top,
        curCube.bottom,
        getSpawnRowPos,
        getCurrentRowPos,
      );
      if (isLoose) {
        resetGame("Row loose!!!");
      }
    }
  }

  @override
  void initState() {
    super.initState();
    controller.animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: controller.timeToMove),
    );

    //Just in initState to not detect change spawn
    controller.animationController.value = 0.000004;

    controller.animationController.addListener(() {
      isLoose(
        -85 + (size.width + 85) * controller.animationController.value,
        -85 + (size.height + 85) * controller.animationController.value,
        size,
      );
      if (controller.animationController.value == 1 ||
          controller.animationController.value == 0) {
        controller.increaseCurrentScore();
        controller.setEndState();
        controller.changeSpawn();
        if (controller.animationController.value == 0)
          controller.animationController.forward();
        else
          controller.animationController.reverse();
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;

    return IgnorePointer(
      child: GetBuilder<GameController>(
        init: controller,
        builder: (controller) => Stack(
          children: [
            Positioned(
              left: -85 +
                  (size.width + 85) * controller.animationController.value,
              child: SizedBox(
                width: 85,
                height: size.height,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: halfSize(size, Orientation.height) +
                          (getSpawnColumnPos + 1) * 15 +
                          getSpawnColumnPos * 85,
                      width: 85,
                      decoration: BoxDecoration(
                        color: Colors.white54,
                        borderRadius: BorderRadius.vertical(
                          bottom: Radius.circular(3),
                        ),
                      ),
                    ),
                    Container(
                      height: halfSize(size, Orientation.height) +
                          (4 - getSpawnColumnPos + 1) * 15 +
                          (4 - getSpawnColumnPos) * 85,
                      width: 85,
                      decoration: BoxDecoration(
                        color: Colors.white54,
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(3),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: -85 +
                  (size.height + 85) * controller.animationController.value,
              child: SizedBox(
                height: 85,
                width: size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: halfSize(size, Orientation.width) +
                          (getSpawnRowPos + 1) * 15 +
                          getSpawnRowPos * 85,
                      height: 85,
                      decoration: BoxDecoration(
                        color: Colors.white54,
                        borderRadius: BorderRadius.horizontal(
                          right: Radius.circular(3),
                        ),
                      ),
                    ),
                    Container(
                      width: halfSize(size, Orientation.width) +
                          (4 - getSpawnRowPos + 1) * 15 +
                          (4 - getSpawnRowPos) * 85,
                      height: 85,
                      decoration: BoxDecoration(
                        color: Colors.white54,
                        borderRadius: BorderRadius.horizontal(
                          left: Radius.circular(3),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
