
import 'package:flame/components.dart';
import 'package:juego_ingeniero/controllers/screen_controller.dart';
import 'package:juego_ingeniero/utils/globals.dart';
import '../models/backdrop.dart';

class BackdropController {
    static double width = 2 * ScreenController.worldSize.x;
    static double height =  (backdrop.image.height/backdrop.image.width) * width;
    static double y = 0;
    static Vector2 linearVelocity = Vector2(-3, 0);
    static void turnAround(Backdrop backdrop1, Backdrop backdrop2){
      if(backdrop1.body.position.x <= -1 * width){
        backdrop1.body.setTransform(Vector2(backdrop2.body.position.x + width, y), 0);
      }
    }
    static void infinityBackdrop(List<Backdrop> backdrops){
      // print(1024*ScreenController.worldSize.y/(3*ScreenController.worldSize.x));
      //1024x168
      backdrops[0].body.linearVelocity = linearVelocity;
      backdrops[1].body.linearVelocity = linearVelocity;
      turnAround(backdrops[0], backdrops[1]);
      turnAround(backdrops[1], backdrops[0]);
    }
}