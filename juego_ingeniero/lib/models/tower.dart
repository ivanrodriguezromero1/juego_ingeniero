import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import '../models/entity.dart';
import '../controllers/screen_controller.dart';
import '../utils/globals.dart';

class Tower extends Entity {
  Tower({required height}): _height = height;
  final double _height;
  late double _x;
  late double _y;
  late double _width;

  @override
  void initializing(){
    _width = ScreenController.worldSize.x/20;
    _x = ScreenController.worldSize.x + _width/2;
    _y = 0.1 + (2*ScreenController.worldSize.y/3) - _height;
  }
  @override
  Body createBody() {
    initializing();
    final bodyDef = BodyDef(
      position: Vector2(_x, _y),
      type: BodyType.kinematic,
    );

    final shape = EdgeShape()..set( Vector2.zero(), Vector2(_width/1.7, 0));
    final fixtureDef = FixtureDef(shape)
      ..density = 10
      ..restitution=.3;  
    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }
  @override
  Future<void> onLoad() async {
    await super.onLoad();
    renderBody = false;
    priority = 1;
    final sprite = tower;
    add(SpriteComponent(
      sprite: sprite,
      position: Vector2(_width/8,_height/2),
      size: Vector2(_width, _height),
      anchor: Anchor.center
    ));
  }
}