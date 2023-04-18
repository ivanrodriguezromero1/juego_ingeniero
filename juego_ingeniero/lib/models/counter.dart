import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/material.dart';
import 'package:juego_ingeniero/controllers/counter_controller.dart';
import 'package:juego_ingeniero/models/entity.dart';

class Counter extends Entity {
  late TextComponent count;
  late double _x;
  late double _y;
  late double _xScale;
  late double _yScale;
  late double _fontSize;
  
  @override
  void initializing(){
    _x = CounterController.x;
    _y = CounterController.y;
    _xScale = CounterController.xScale;
    _yScale = CounterController.yScale;
    _fontSize = CounterController.fontSize;
    count = TextComponent(
      position: Vector2.zero(),
      text: '0',
      textRenderer: TextPaint(
        style: TextStyle(color: Colors.white, fontSize: _fontSize)
      ),
    )..scale = Vector2(_xScale, _yScale);
  }
  @override
  Body createBody(){
    initializing();
    final bodyDef = BodyDef(
      position: Vector2(_x, _y),
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
    add(count);
  }
}