import 'dart:math';

import 'package:flame/components.dart';
import 'package:juego_ingeniero/controllers/screen_controller.dart';

import '../models/example.dart';
import '../utils/globals.dart';

class ExampleController {
  static double width = ScreenController.worldSize.x/30;
  static double height = ScreenController.worldSize.y/28;
  static double x = 2*ScreenController.worldSize.x/3;
  static double y = 2*ScreenController.worldSize.y/3;
  static Vector2 linearVelocity = linearVelocityWorld;
  static double angularVelocity = radians(-170);
  static void spin(Example example){
    example.body.linearVelocity = linearVelocity;
    // example.body.angularVelocity = angularVelocity;
  }
  static void infinityExample(Example example){
    if(example.body.position.x <= -1*(width/2)){
      double newX = ScreenController.worldSize.x + width/2 + Random().nextDouble()*10;
      example.body.setTransform(Vector2(newX, y),0);
      // angularVelocity = -1*angularVelocity;
    }
  }
}