import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import '../models/entity.dart';
import '../models/screen.dart';
import '../utils/globals.dart';

class Blade extends Entity {
  Blade({required height}): _height = height;
  late double _x;
  late double _y;
  late double _width;
  final double _height;
  @override
  void initializing(){
    _width = Screen.worldSize.x/20;
    _x = getXStart();
    _y = getY(_height);
  }
  double getXStart(){
    return Screen.worldSize.x + _width/2 + 0.11;
  }
  double getY(double h){
    return 0.1 + (2*Screen.worldSize.y/3) - h + 0.05;
  } 
  @override
  Body createBody() { 
    initializing();
    final bodyDef = BodyDef(
      position: Vector2(_x, _y),
      type: BodyType.kinematic,
    );

    final shape = PolygonShape()..setAsBoxXY(_width/4, _height/2);
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
    final sprite = bladeSprite;
    add(SpriteComponent(
      sprite: sprite,
      position: Vector2(0,0),
      size: Vector2(_width/2, _height),
      anchor: Anchor.center
    ));
  }
}