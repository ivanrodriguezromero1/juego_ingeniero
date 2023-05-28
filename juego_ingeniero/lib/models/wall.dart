import 'package:flame_forge2d/flame_forge2d.dart';
import '../models/screen.dart';
import '../models/entity.dart';

class Wall extends Entity {
  late double _x;
  late double _y;
  late double _height;
  
  @override
  void initializing(){
    _height = Screen.worldSize.y;
    _x = Screen.worldSize.x + 0.1;
    _y = Screen.worldSize.y;
  }
  @override
  Body createBody() {
    initializing();
    final bodyDef = BodyDef(
      position: Vector2(_x, _y),
      type: BodyType.kinematic,
    );

    final shape = EdgeShape()..set(Vector2.zero(), Vector2(0, -1*_height));
    final fixtureDef = FixtureDef(shape)
      ..density=10
      ..restitution=.01;
    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }
  @override
  Future<void> onLoad() async {
    await super.onLoad();
    renderBody = false;
  }
}