
import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import '../controllers/backdrop_controller.dart';
import '../utils/globals.dart';

class Backdrop extends BodyComponent {
  Backdrop({required x}):_x = x;
  late final double _x;
  late double _y;
  late double _width;
  late double _height;
  late bool _state;

  void initializing(){
    _width = BackdropController.width;
    _y = BackdropController.y;
    _state = true;
  }
  @override
  Body createBody() {
    initializing();
    final bodyDef = BodyDef(
      userData: this,
      position: Vector2(_x, _y),
      type: BodyType.kinematic,
    );

    final shape = EdgeShape()..set(Vector2.zero(), Vector2(_width, 0));
    final fixtureDef = FixtureDef(shape)
      ..density = 10
      ..friction = .6
      ..restitution = .4;
    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }
  @override
  Future<void> onLoad() async {
    await super.onLoad();
    renderBody = false;
    final sprite = backdrop;
    _height = BackdropController.height;
    add(SpriteComponent(
      sprite: sprite,
      size: Vector2(_width, _height),
      position: Vector2(0,-.02),
      anchor: Anchor.topLeft
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