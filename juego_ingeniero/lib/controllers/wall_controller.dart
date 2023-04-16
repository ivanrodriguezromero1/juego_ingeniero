import 'package:flame/components.dart';
import 'package:juego_ingeniero/controllers/screen_controller.dart';

import '../utils/globals.dart';

class WallController {
  static double height = ScreenController.worldSize.y;
  static double x = ScreenController.worldSize.x + 0.1;
  static double y = ScreenController.worldSize.y;
  static Vector2 linearVelocity = worldLinearVelocity;

}