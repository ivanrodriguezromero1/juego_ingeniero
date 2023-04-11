
import 'package:flame/components.dart';
import 'package:juego_ingeniero/controllers/screen_controller.dart';
import 'package:juego_ingeniero/utils/globals.dart';

import '../models/floor.dart';

class FloorController {
    static double width = ScreenController.worldSize.x;
    static double height = (floor.image.height/floor.image.width) * width;
    static double y = 2 * ScreenController.worldSize.y/3;
    static Vector2 linearVelocity = Vector2(-3, 0);
    static void turnAround(Floor floor1, Floor floor2){
      if(floor1.body.position.x <= -1 * width){
        floor1.body.setTransform(Vector2(floor2.body.position.x + width, y), 0);
      }
    }
    static void infinityFloor(List<Floor> floors){
      floors[0].body.linearVelocity = linearVelocity;
      floors[1].body.linearVelocity = linearVelocity;
      turnAround(floors[0], floors[1]);
      turnAround(floors[1], floors[0]);
    }
}