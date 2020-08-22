import 'package:Zquare/controller/game_controller.dart';
import 'package:Zquare/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class GameOverPopUp extends GetWidget<GameController> {
  @override
  Widget build(BuildContext context) {
    return _playBoard();
  }

  Widget _playBoard() {
    return Center(
      child: Material(
        child: Container(
          height: 515,
          width: 515,
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: ZquareColors.pinkLight,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Text(
                    "Zquare",
                    style: GoogleFonts.varela(
                      fontSize: 75,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Score: ",
                        style: GoogleFonts.varela(
                          fontSize: 28,
                          color: Colors.amber[600],
                        ),
                      ),
                      Text(
                        controller.currentScore.value.toString(),
                        style: GoogleFonts.varela(
                          fontSize: 28,
                          color: Colors.amber[600],
                        ),
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
                      color: ZquareColors.pinkBold,
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
                          style: GoogleFonts.varela(
                            fontSize: 30,
                            color: ZquareColors.pinkLight,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                  Container(
                    height: 80,
                    width: 250,
                    decoration: BoxDecoration(
                      color: ZquareColors.pinkBold,
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
                          style: GoogleFonts.varela(
                            fontSize: 30,
                            color: ZquareColors.pinkLight,
                          ),
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
    );
  }
}
