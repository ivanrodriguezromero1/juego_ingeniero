import 'package:flame/components.dart';
import '../models/entity.dart';
import '../utils/globals.dart';

class EngineerController {
  static late bool _canJump;
  static void setCanJump(Entity engineer){
    double positionY = engineer.body.position.y;
    double positionYOnFloor = posY0 - ingenierosSprites[0].image.height/1500/2;
    _canJump = positionY >= positionYOnFloor - 0.5;
  }
  static void jump(Entity engineer){
    if(_canJump){
      engineer.body.linearVelocity = Vector2(0, -7);
    }
  }
  static void standUp(Entity engineer){
    if(_canJump){
      bool condition = engineer.body.angle.abs().round()!=0 && engineer.body.angle.abs()<=radians(360);
      if(condition){
        engineer.body.angularVelocity = radians(360);
      } else if(!condition){
        engineer.body.angularVelocity = 0;
        engineer.body.setTransform(engineer.body.position, 0);
      }
    }
  }
  static bool hasLost(Entity engineer){
    return engineer.body.position.x <= -1*(ingenierosSprites[0].image.width/1500/2);
  }

}
