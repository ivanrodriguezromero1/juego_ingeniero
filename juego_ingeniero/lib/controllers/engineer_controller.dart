
import 'package:flame/components.dart';
import 'package:juego_ingeniero/controllers/screen_controller.dart';
import 'package:juego_ingeniero/models/entity.dart';
import '../utils/globals.dart';
import 'floor_controller.dart';

class EngineerController {
  static final double side = ingenieros[0].image.width/1500;
  static final double width = ingenieros[0].image.width/1500;
  static final double height = ingenieros[0].image.height/1500;
  static const double x = 1;
  static final double y = ScreenController.worldSize.y/5;
  static double xReset = -1*(width/2);

  static bool _canJump(Entity engineer){
    double positionY = engineer.body.position.y;
    double positionYOnFloor = FloorController.y - height/2;
    return  positionY >= positionYOnFloor - 0.5;
  }
  static void jump(Entity engineer){
    if(_canJump(engineer)){
      engineer.body.linearVelocity = Vector2(0, -7);
    }
  }
  static void _stopSpid(Entity engineer){
      engineer.body.angularVelocity = 0;
      engineer.body.setTransform(engineer.body.position, 0);
  }
  static bool _isLying(Entity engineer){
    return engineer.body.angle.abs().round()!=0 && engineer.body.angle.abs()<=radians(360);
  }
  static void _rotation(Entity engineer){
    engineer.body.angularVelocity = radians(360);
  }
  static void standUp(Entity engineer){
    if(_canJump(engineer) && _isLying(engineer)){
      _rotation(engineer);
    } else if(_canJump(engineer) && !_isLying(engineer)){
      _stopSpid(engineer);
    }
  }
  static bool isResettable(Entity engineer){
    return engineer.body.position.x <= xReset;
  }

}
