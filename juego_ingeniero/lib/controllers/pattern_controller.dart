import 'package:flame/components.dart';
import '../models/entity.dart';
import '../utils/globals.dart';

class PatternController {
  static void turnAround(Entity entity1, Entity entity2, double width, double y){
    if(entity1.body.position.x <= -1 * width){
      entity1.body.setTransform(Vector2(entity2.body.position.x + width - 0.01, y), 0);
    }
  }
  static void infinityMove(List<Entity> entity, double width, double y) {
    entity[0].body.linearVelocity = worldLinearVelocity;
    entity[1].body.linearVelocity = worldLinearVelocity;
    turnAround(entity[0], entity[1], width, y);
    turnAround(entity[1], entity[0], width, y);
  }
}