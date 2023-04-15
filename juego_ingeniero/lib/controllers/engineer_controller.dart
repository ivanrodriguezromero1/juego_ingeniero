
import 'package:flame/components.dart';
import 'package:juego_ingeniero/controllers/screen_controller.dart';

import '../models/engineer.dart';
import '../utils/globals.dart';
import 'floor_controller.dart';

class EngineerController {
  static final double side = ingenieros[0].image.width/1500;
  static final double width = ingenieros[0].image.width/1500;
  static final double height = ingenieros[0].image.height/1500;
  static const double x = 1;
  static final double y = ScreenController.worldSize.y/5;
  static double xReset = -1*(width/2);

  static bool canJump(Engineer engineer){
    double positionY = engineer.body.position.y;
    double positionYOnFloor = FloorController.y - height/2;
    return  positionY >= positionYOnFloor - 0.5;
  }
  static void jump(Engineer engineer){
    if(canJump(engineer)){
      engineer.body.linearVelocity = Vector2(0, -7);
    }
  }
  static void stopSpid(Engineer engineer){
      engineer.body.angularVelocity = 0;
      engineer.body.setTransform(engineer.body.position, 0);
  }
  static bool isLying(Engineer engineer){
    return engineer.body.angle.abs().round()!=0 && engineer.body.angle.abs()<=radians(360);
  }
  static void spid(Engineer engineer){
    engineer.body.angularVelocity = radians(360);
  }
  static void standUp(Engineer engineer){
    if(canJump(engineer) && isLying(engineer)){
      spid(engineer);
    } else if(canJump(engineer) && !isLying(engineer)){
      stopSpid(engineer);
    }
  }
  static bool isResettable(Engineer engineer){
    return engineer.body.position.x <= xReset;
  }

}
