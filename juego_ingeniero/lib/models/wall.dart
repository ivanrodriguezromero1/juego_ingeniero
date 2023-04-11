import 'package:flame_forge2d/flame_forge2d.dart';
import '../controllers/wall_controller.dart';

class Wall extends BodyComponent {
  late double _x;
  late double _y;
  late double _height;
  late double angularVelocity;
  
  void initializing(){
    _height = WallController.height;
    _x = WallController.x;
    _y = WallController.y;
    angularVelocity  = WallController.angularVelocity;
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