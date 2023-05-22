import 'package:flame/game.dart';
import '../controllers/screen_controller.dart';

void configCamera(Camera camera){
    double width = 836;
    double height = 393;
    ScreenController.setScreenSize(Vector2(width, height));
    camera.viewport = FixedResolutionViewport(ScreenController.screenSize);
  }