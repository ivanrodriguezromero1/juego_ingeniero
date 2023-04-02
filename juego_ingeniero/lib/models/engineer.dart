import 'package:flame_forge2d/flame_forge2d.dart';

class Engineer extends BodyComponent {
  @override
  Body createBody(){
    final bodyDef = BodyDef(
      position: Vector2(1,1),
      type: BodyType.dynamic,
    );
    final shape = PolygonShape()..setAsBoxXY(1, 1);
    final fixtureDef = FixtureDef(shape);
    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }
}