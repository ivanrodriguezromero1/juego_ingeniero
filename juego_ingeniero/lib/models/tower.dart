import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';

import '../controllers/tower_controller.dart';
import '../utils/globals.dart';

class Tower extends BodyComponent {
  late double _x;
  late double _y;
  late double _width;
  late double _height;
  late double angularVelocity;
  late bool _state;

  void initializing(){
    _width = TowerController.width;
    _height = TowerController.height;
    _x = TowerController.x;
    _y = TowerController.y;
    angularVelocity  = TowerController.angularVelocity;
    _state = true;
  }
  @override
  Body createBody() {
    initializing();
    final bodyDef = BodyDef(
      position: Vector2(_x, _y),
      type: BodyType.kinematic,
    );

    final shape = EdgeShape()..set( Vector2.zero(), Vector2(_width, 0));
    final fixtureDef = FixtureDef(shape)
      ..density = 10
      ..restitution=.3;
    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }
  @override
  Future<void> onLoad() async {
    await super.onLoad();
    // renderBody = false;
    final sprite = tower;
    add(SpriteComponent(
      sprite: sprite,
      position: Vector2(_width/2,0),
      size: Vector2(_width, _height),
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