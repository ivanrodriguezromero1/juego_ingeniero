import 'dart:math';
import 'package:flame/components.dart';
import 'package:audioplayers/audioplayers.dart';
import '../controllers/screen_controller.dart';
import '../models/counter.dart';
import '../models/entity.dart';
import '../utils/constants.dart';
import '../utils/globals.dart';

class TowerController {
  static bool _increase = true;
  static void move(Entity tower){
    tower.body.linearVelocity = worldLinearVelocity;
  }
  static bool isPassingTower(Entity tower, Counter counter, AudioPlayer player){
    if(tower.body.position.x <= -1*(ScreenController.worldSize.x/20)){
      counter.count.text = (int.parse(counter.count.text) + 1).toString();
      worldLinearVelocity += _getWorldLinearVelocity();
      bladeAngularVelocity = _getBladeAngularVelocity();
      player.play(AssetSource(pointSoundFilename));
      return true;
    }
    return false;
  }
  static Vector2 _getWorldLinearVelocity(){
    int signWorldLinearVelocity = _getSignWorldLinearVelocity();
    return Vector2(0.2*signWorldLinearVelocity,0);
  }
  static int _getSignWorldLinearVelocity(){
    if(worldLinearVelocity.x >= initialWorldLinearVelocity.x - 1){
      _increase = true;
      return -1;
    } else if(worldLinearVelocity.x > initialWorldLinearVelocity.x - 2 && _increase){
      return -1;
    } else {
      _increase = false;
      return 1;
    }
  }
  static double _getBladeAngularVelocity(){
    return radians(340 + Random().nextInt(41).toDouble());
  }
}