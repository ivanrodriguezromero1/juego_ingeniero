import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import '../models/entity.dart';
import '../controllers/screen_controller.dart';
import '../utils/globals.dart';

class Blade extends Entity {
  Blade({required height}): _height = height;
  late double _x;
  late double _y;
  late double _width;
  final double _height;

  @override
  void initializing(){
    _width = ScreenController.worldSize.x/20;
    _x = ScreenController.worldSize.x + _width/2;
    _y = 0.1 + (2*ScreenController.worldSize.y/3) - 2*_height;
  }
  @override
  Body createBody() {
    initializing();
    final bodyDef = BodyDef(
      position: Vector2(_x + 0.11, _y + 0.05),
      type: BodyType.kinematic,
    );

    final shape = PolygonShape()..setAsBoxXY(_width/4, _height);
    final fixtureDef = FixtureDef(shape)
      ..density = 10
      ..restitution=.3;  
    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }
  @override
  Future<void> onLoad() async {
    await super.onLoad();
    renderBody = false;
    priority = 2;
    final sprite = blade;
    add(SpriteComponent(
      sprite: sprite,
      position: Vector2(0,0),
      size: Vector2(_width/2, 2*_height),
      anchor: Anchor.center
    ));
  }
}