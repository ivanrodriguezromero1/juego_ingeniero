import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/material.dart';

class Counter extends BodyComponent {
  late int _count;
  late bool _state;
  void initializing(){
    _state = true;
    _count = 0;
  }
  @override
  Body createBody(){
    initializing();
    final bodyDef = BodyDef(
      position: Vector2(0.2,0.2),
      type: BodyType.static,
    );
    final shape = PolygonShape()..setAsBoxXY(0,0);
    final fixtureDef = FixtureDef(shape)
      ..density = 10
      ..restitution = .1;
    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }
  @override
  Future<void> onLoad() async {
    await super.onLoad();
    renderBody = false;
    add(TextComponent(
      position: Vector2.zero(),
      text: '$_count',
      textRenderer: TextPaint(
        style: const TextStyle(color: Colors.white, fontSize: 1)
      ),
    )..scale = Vector2(0.4, 0.4));
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