import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:juego_ingeniero/utils/globals.dart';

import '../controllers/screen_controller.dart';

class Floor extends BodyComponent {
  Floor({required number}):_number = number;
  late final int _number;
  late double _x;
  late double _y;
  late double _width;
  late double _height;
  @override
  Future<void> onLoad() async {
    await super.onLoad();
    renderBody = false;
    final sprite = floor;
    _height = ScreenController.worldSize.y;
    add(SpriteComponent(
      sprite: sprite,
      size: Vector2(_width, _height),
      position: Vector2(0,-.02),
      anchor: Anchor.topLeft
    ));
  }
  @override
  Body createBody() {
    _width = 2 * ScreenController.worldSize.x;
    _x = (_number-1)*_width;
    _y = 2*ScreenController.worldSize.y/3;
    final bodyDef = BodyDef(
      position: Vector2(_x, _y),
      type: BodyType.kinematic,
      linearVelocity: Vector2(-2, 0),
    );

    final shape = EdgeShape()..set(Vector2.zero(), Vector2(_width, 0));
    final fixtureDef = FixtureDef(shape)..density=10..friction=.5..restitution=.5;
    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }
  @override
  void update(double dt) {
    super.update(dt);
    if(body.position.x <= -1*_width){
      // print(body.position.x);
      // print(_width);
      // print("=================================");
      body.position.x = 0 + _width;
      // print(body.position.x);
      // print(_width);
      // print("---------------------------------");
    }
  }
}