import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';

import '../controllers/example_controller.dart';
import '../utils/globals.dart';

class Example extends BodyComponent {
  late double _x;
  late double _y;
  late double _width;
  late double _height;
  late double angularVelocity;
  late bool _state;

  void initializing(){
    _width = ExampleController.width;
    _height = ExampleController.height;
    _x = ExampleController.x;
    _y = ExampleController.y;
    angularVelocity  = ExampleController.angularVelocity;
    _state = true;
  }
  @override
  Body createBody() {
    initializing();
    final bodyDef = BodyDef(
      position: Vector2(_x, _y),
      type: BodyType.kinematic,
    );

    final shape = PolygonShape()..setAsBoxXY( _width, _height);
    final fixtureDef = FixtureDef(shape)
      ..density = 10
      ..restitution=.4;
    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }
  @override
  Future<void> onLoad() async {
    await super.onLoad();
    renderBody = false;
    final sprite = rock;
    add(SpriteComponent(
      sprite: sprite,
      size: Vector2(2*_width, 2*_height),
      anchor: Anchor.center
    ));
  }
  @override
  void update(double dt){
    super.update(dt);
    if(!_state){
      destroyBody();
    }
  }
  void destroy(){
    _state = false;
  }
  void destroyBody(){
    world.destroyBody(body);
    gameRef.remove(this);
  }
}