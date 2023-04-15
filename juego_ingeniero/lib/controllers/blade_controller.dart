import 'package:flame/components.dart';
import 'package:juego_ingeniero/controllers/screen_controller.dart';
import 'package:juego_ingeniero/models/blade.dart';

import '../utils/globals.dart';

class BladeController {
  static double width = ScreenController.worldSize.x/20;
  static double x = ScreenController.worldSize.x + width/2;
  static double angularVelocity = radians(360);
  static void move(Blade blade){
    blade.body.linearVelocity = linearVelocityWorld;
    blade.body.angularVelocity = angularVelocity;
  }
}
