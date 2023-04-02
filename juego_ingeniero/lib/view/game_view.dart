import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:juego_ingeniero/controllers/asset_controller.dart';
import 'package:flutter/material.dart';
import 'package:juego_ingeniero/models/background.dart';
import 'package:juego_ingeniero/models/engineer.dart';
import 'package:juego_ingeniero/models/floor.dart';
import 'package:juego_ingeniero/utils/globals.dart';
import 'package:flame_forge2d/flame_forge2d.dart';

import '../controllers/floor_controller.dart';
import '../controllers/screen_controller.dart';

class GameEngineer extends StatefulWidget {
  const GameEngineer({Key? key}) : super(key: key);
  @override
  GameEngineerState createState() => GameEngineerState();
}
Game controlledGameBuilder() {
  return MyGameEngineer();
}
class GameEngineerState extends State<GameEngineer> {
  Widget buildGameWidget() => const GameWidget.controlled(gameFactory: controlledGameBuilder);
  @override
  Widget build(BuildContext context) {
    return buildGameWidget();
  }
}
class MyGameEngineer extends Forge2DGame with TapDetector {
  MyGameEngineer(): super(zoom: 100, gravity: Vector2(0, 15));
  late double _tiempo;
  late int _indiceSpriteActual;
  late double widthIngeniero;
  late double heightIngeniero;
  late Vector2 _positionIngeniero;
  late Vector2 _sizeIngeniero;
  late Vector2 _velocityIngeniero;
  late Vector2 _positionPiso1;
  late Vector2 _positionPiso2;
  late Vector2 _positionFondo1;
  late Vector2 _positionFondo2;
  late Vector2 _velocityPiso;
  late Vector2 _velocityFondo;
  late final Vector2 _gravity;
  late bool _canJump;
  late final double _jumpVelocity;
  late double widthFondo;
  late double heightFondo;
  late Vector2 _sizeFondo;
  late Engineer _engineer;
  late List<Floor> floor;
  
  void addCamera(){
    ScreenController.setScreenSize(canvasSize);
    camera.viewport= FixedResolutionViewport(ScreenController.screenSize);
  }
  void addBackground(){
    Background.setWidthHeight(canvasSize);
    add(Background(size: ScreenController.screenSize)..positionType=PositionType.viewport);
  }
  @override
  Future<void> onLoad() async {
    addCamera();
    addBackground();
    await loadAssets();
    floor = [Floor(number: 1),Floor(number: 2)]; 
    addAll(floor);
    _engineer = Engineer();
    add(_engineer);

    _tiempo = 0;
    _indiceSpriteActual = 0;
    widthIngeniero = ingenieros[0].image.width/6;
    heightIngeniero = ingenieros[0].image.height/6;
    _sizeIngeniero = Vector2(widthIngeniero, heightIngeniero);
    _positionIngeniero = Vector2(20, 100);
    _velocityIngeniero = Vector2(0, 0);
    _positionPiso1 = Vector2(0, 205 + heightIngeniero);
    // _positionPiso2 = Vector2(_sizeFloor.x, 205 + heightIngeniero);
    _positionFondo1 = Vector2(0, 0);
    widthFondo = fondo.image.width.toDouble()/3;
    heightFondo = fondo.image.height.toDouble()/2;
    _sizeFondo = Vector2(widthFondo, heightFondo);
    _positionFondo2 = Vector2(widthFondo, 0);
    _velocityPiso = Vector2(200, 0);
    _velocityFondo = Vector2(100, 0);
    _gravity = Vector2(0, 1500);
    _canJump = true;
    _jumpVelocity = -700.0;

  }

  @override
  void onTapDown(TapDownInfo info) {
    super.onTapDown(info);
    if (_canJump) {
      _velocityIngeniero.y = _jumpVelocity;
      _canJump = false;
    }
  }
  
  @override
  void update(double dt) {
    super.update(dt);
     _tiempo += dt;
    if (_tiempo > 0.1) { // Cambiar el sprite cada 0.1 segundos
      _indiceSpriteActual = (_indiceSpriteActual + 1) % ingenieros.length;
      _tiempo = 0;
    }
    _velocityIngeniero += _gravity * dt;
    _positionIngeniero += _velocityIngeniero * dt;
    
    // Actualizar _canJump si el jugador está tocando el suelo
    if (_positionIngeniero.y >= 215) {
      _velocityIngeniero.y = 0;
      _positionIngeniero.y = 215;
      _canJump = true;
    } else {
      _canJump = false;
    }

    _positionPiso1.x -= _velocityPiso.x * dt;
    // _positionPiso2.x -= _velocityPiso.x * dt;
    _positionFondo1.x -= _velocityFondo.x * dt;
    _positionFondo2.x -= _velocityFondo.x * dt;
    if(_positionFondo1.x <= -1*widthFondo){
      _positionFondo1.x = _positionFondo2.x + widthFondo;
    }
    if(_positionFondo2.x <= -1*widthFondo){
      _positionFondo2.x = _positionFondo1.x + widthFondo;
    }
    if(floor[0].body.position.x<=-1*2 * ScreenController.worldSize.x){
      floor[0].body.setTransform(Vector2(2 * ScreenController.worldSize.x,2*ScreenController.worldSize.y/3), 0);
    }
    // if(floor[1].body.position.x<=-1*2 * ScreenController.worldSize.x){
    //   floor[1].body.setTransform(Vector2(2 * ScreenController.worldSize.x,2*ScreenController.worldSize.y/3), 0);
    // }
    // if(_positionPiso1.x <= -1*_sizeFloor.x){
    //   _positionPiso1.x = _positionPiso2.x + _sizeFloor.x;
    // }
    // if(_positionPiso2.x <= -1*_sizeFloor.x){
    //   _positionPiso2.x = _positionPiso1.x + _sizeFloor.x;
    // }
  }

  // @override
  // void render(Canvas canvas) {
  //   super.render(canvas);
  //   // fondo.render(canvas, position: _positionFondo1, size: _sizeFondo);
  //   // fondo.render(canvas, position: _positionFondo2, size: _sizeFondo);
  //   // piso.render(canvas, position: _positionPiso1, size: _sizePiso);
  //   // piso.render(canvas, position: _positionPiso2, size: _sizePiso);
  //   // ingenieros[_indiceSpriteActual].render(canvas, position: _positionIngeniero, size: _sizeIngeniero);
  // }
}