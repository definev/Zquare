import 'package:Zquare/controller/game_controller.dart';
import 'package:Zquare/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends GetWidget<GameController> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        color: ZquareColors.pinkRegular,
        alignment: Alignment.center,
        child: _playBoard(),
      ),
    );
  }

  Center _playBoard() {
    return Center(
      child: Container(
        height: 515,
        width: 515,
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: ZquareColors.pinkLight,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
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
                      "High score: ",
                      style: GoogleFonts.varela(
                        fontSize: 28,
                        color: Colors.amber[600],
                      ),
                    ),
                    Text(
                      controller.gameStorage.highscore.toString(),
                      style: GoogleFonts.varela(
                        fontSize: 28,
                        color: Colors.amber[600],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 60),
            Container(
              height: 80,
              width: 250,
              decoration: BoxDecoration(
                color: ZquareColors.pinkBold,
                borderRadius: BorderRadius.circular(5),
              ),
              child: InkWell(
                onTap: () => Get.toNamed('/game'),
                child: Center(
                  child: Text(
                    "Play",
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
      ),
    );
  }
}
