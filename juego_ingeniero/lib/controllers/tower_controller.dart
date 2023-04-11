import 'dart:math';

import 'package:flame/components.dart';
import 'package:juego_ingeniero/controllers/screen_controller.dart';

import '../models/tower.dart';

class TowerController {
  static double width = ScreenController.worldSize.x/20;
  static double height = ScreenController.worldSize.y/2;
  static double x = 3*ScreenController.worldSize.x/4;
  static double y = (2*ScreenController.worldSize.y/3) - height/2;
  static Vector2 linearVelocity = Vector2(-3, 0);
  static double angularVelocity = radians(-170);
  static void move(Tower tower){
    tower.body.linearVelocity = linearVelocity;
  }
  static void infinityTower(Tower tower){
    if(tower.body.position.x <= -1*(width)){
      double newX = ScreenController.worldSize.x + width/2 + Random().nextDouble()*10;
      tower.body.setTransform(Vector2(newX, y),0);
    }
  }
}