import 'package:flame/components.dart';
import 'package:juego_ingeniero/controllers/screen_controller.dart';
import '../models/floor.dart';
import '../utils/globals.dart';

class FloorController {
    static double width = ScreenController.worldSize.x;
    static double height = ScreenController.worldSize.y/3;
    static double y = 2 * ScreenController.worldSize.y/3;
    static void turnAround(Floor floor1, Floor floor2){
      if(floor1.body.position.x <= -1 * width){
        floor1.body.setTransform(Vector2(floor2.body.position.x + width, y), 0);
      }
    }
    static void infinityFloor(List<Floor> floors){
      floors[0].body.linearVelocity = worldLinearVelocity;
      floors[1].body.linearVelocity = worldLinearVelocity;
      turnAround(floors[0], floors[1]);
      turnAround(floors[1], floors[0]);
    }
}