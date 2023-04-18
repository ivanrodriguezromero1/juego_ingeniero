import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:juego_ingeniero/controllers/floor_controller.dart';
import 'package:juego_ingeniero/models/entity.dart';
import 'package:juego_ingeniero/utils/globals.dart';

class Floor extends Entity {
  Floor({required x}):_x = x;
  late final double _x;
  late double _y;
  late double _width;
  late double _height;

  @override
  void initializing(){
    _width = FloorController.width;
    _y = FloorController.y;
  }
  @override
  Body createBody() {
    initializing();
    final bodyDef = BodyDef(
      position: Vector2(_x, _y),
      type: BodyType.kinematic,
    );

    final shape = EdgeShape()..set(Vector2.zero(), Vector2(_width, 0));
    final fixtureDef = FixtureDef(shape)
      ..density = 100
      ..friction = 0.5
      ..restitution = 0;
    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }
  @override
  Future<void> onLoad() async {
    await super.onLoad();
    renderBody = false;
    final sprite = floor;
    _height = FloorController.height;
    add(SpriteComponent(
      sprite: sprite,
      size: Vector2(_width, _height),
      position: Vector2(0,-.02),
      anchor: Anchor.topLeft
    ));
  }
}