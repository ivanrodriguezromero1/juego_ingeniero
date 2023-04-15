import 'package:flame/components.dart';
import 'package:juego_ingeniero/controllers/screen_controller.dart';
import 'package:juego_ingeniero/models/counter.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:juego_ingeniero/utils/constants.dart';
import '../models/tower.dart';
import '../utils/globals.dart';

class TowerController {
  static double width = ScreenController.worldSize.x/20;
  static double x = ScreenController.worldSize.x + width/2;
  static void move(Tower tower){
    tower.body.linearVelocity = linearVelocityWorld;
  }
  static bool isPassingTower(Tower tower, Counter counter, AudioPlayer player){
    if(tower.body.position.x <= -1*(width)){
      tower.destroy();
      counter.count.text = (int.parse(counter.count.text)+1).toString();
      linearVelocityWorld += Vector2(-0.2,0);
      player.play(AssetSource(pointSoundFilename));     
      return true;
    }
    return false;
  }
}