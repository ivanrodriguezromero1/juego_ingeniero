import 'dart:math';

import 'package:flame/components.dart';
import 'package:juego_ingeniero/controllers/screen_controller.dart';
import 'package:juego_ingeniero/models/blade.dart';
import 'package:juego_ingeniero/models/entity.dart';

import '../utils/globals.dart';

class BladeController {
  static double width = ScreenController.worldSize.x/20;
  static double x = ScreenController.worldSize.x + width/2;

  static void move(Entity blade){
    blade.body.linearVelocity = worldLinearVelocity;
    blade.body.angularVelocity = bladeAngularVelocity;
  }
}
