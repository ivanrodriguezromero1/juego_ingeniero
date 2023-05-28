import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import '../controllers/screen_controller.dart';
import '../models/entity.dart';

import '../utils/globals.dart';

class Engineer extends Entity {
  late double _width;
  late double _height;
  late double _x;  
  late double _y;

  @override
  void initializing(){
    _width = ingenierosSprites[0].image.width/1500;
    _height = ingenierosSprites[0].image.height/1500;
    _x = 1;
    _y = ScreenController.worldSize.y/5;
  }
  @override
  Body createBody(){
    initializing();
    final bodyDef = BodyDef(
      position: Vector2(_x,0) + Vector2(_width, _y),
      type: BodyType.dynamic,
    );
    final shape = PolygonShape()..setAsBoxXY(_width,_width);
    final fixtureDef = FixtureDef(shape)
      ..density = 10
      ..restitution = 0;
    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }
  @override
  Future<void> onLoad() async {
    await super.onLoad();
    renderBody = false;
    priority = 10;
    final walkAnimation = SpriteAnimation.spriteList(ingenierosSprites, stepTime: .08, loop: true);
    add(SpriteAnimationComponent(
      animation: walkAnimation,
      size: Vector2(2*_width, 2*_height),
      position: Vector2(0,0.1),
      anchor: Anchor.center,
      removeOnFinish: false,
    ));
  }
}