import 'dart:math';
import 'package:audioplayers/audioplayers.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:juego_ingeniero/controllers/asset_controller.dart';
import 'package:flutter/material.dart';
import 'package:juego_ingeniero/controllers/blade_controller.dart';
import 'package:juego_ingeniero/controllers/engineer_controller.dart';
import 'package:juego_ingeniero/controllers/pattern_controller.dart';
import 'package:juego_ingeniero/factories/factory.dart';
import 'package:juego_ingeniero/models/entity.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import '../controllers/backdrop_controller.dart';
import '../controllers/floor_controller.dart';
import '../controllers/screen_controller.dart';
import '../controllers/tower_controller.dart';
import '../models/counter.dart';
import '../models/wall.dart';
import '../utils/constants.dart';
import '../utils/globals.dart';


class GameEngineer extends StatefulWidget {
  const GameEngineer({Key? key}) : super(key: key);
  @override
  GameEngineerState createState() => GameEngineerState();
}
Game controlledGameBuilder() {
  return MyGameEngineer();
}
class GameEngineerState extends State<GameEngineer> {
  Widget buildGameWidget(BuildContext context) => const GameWidget.controlled(gameFactory: controlledGameBuilder);
  @override
  Widget build(BuildContext context) {
    return buildGameWidget(context);
  }
}

class MyGameEngineer extends Forge2DGame with TapDetector {
  MyGameEngineer(): super(zoom: 100, gravity: Vector2(0, 15));
  late List<Entity> _backdrops;
  late List<Entity> _floors;
  late Entity _tower;
  late Entity _blade;
  late Entity _wall;
  late Entity _engineer;
  late Counter _counter;

  void configCamera(){
    double width = 836;
    double height = 393;
    ScreenController.setScreenSize(Vector2(width, height));
    camera.viewport = FixedResolutionViewport(ScreenController.screenSize);
  }
  void addBackdrops(){
    _backdrops = [
      Factory.createObject('backdrop', x: 0),
      Factory.createObject('backdrop', x: BackdropController.width - 0.01)
    ];
    addAll(_backdrops);
  }
  void addFloor(){
    _floors = [
      Factory.createObject('floor', x: 0),
      Factory.createObject('floor', x: FloorController.width - 0.01)
    ];
    addAll(_floors);
  }
  void addWindTurbine(){
    double height  = (ScreenController.worldSize.y/4)*(1 + 0.5*Random().nextDouble());
    _tower = Factory.createObject('tower',height: height);
    _blade = Factory.createObject('blade',height: height/2); 
    add(_tower);
    add(_blade);
  }
  void destroyWindTurbine(){
    _tower.destroy();
    _blade.destroy();
  }
  void addWall(){
    _wall = Wall();
    add(_wall);
  }
  void addEngineer(){
    _engineer = Factory.createObject('engineer');
    add(_engineer);
  }
  void addCounter(){
    _counter = Counter();
    add(_counter);
  }

  void destroyBodies(){
    _backdrops[0].destroy();
    _backdrops[1].destroy();
    _floors[0].destroy();
    _floors[1].destroy();
    _wall.destroy();
    _tower.destroy();
    _blade.destroy();
    _engineer.destroy();    
    _counter.destroy();
  }
  void resetVelocity(){
    worldLinearVelocity = initialWorldLinearVelocity;
    bladeAngularVelocity = initialBladeAngularVelocity;
  }
  void addComponents(){
    addBackdrops();
    addFloor();
    addWindTurbine();
    addWall();
    addEngineer();
    addCounter();
  }
  void resetWorld(){
    player.play(AssetSource(loseSoundFilename));
    destroyBodies();
    resetVelocity();    
    addComponents();
  }
  @override
  Future<void> onLoad() async {
    configCamera();
    await AssetController.instance.loadAssets();
    addComponents();
  }
  @override
  void onTapDown(TapDownInfo info) {
    super.onTapDown(info);
    EngineerController.jump(_engineer);
  }
  @override
  void update(double dt) {
    super.update(dt);
    PatternController.infinityMove(_backdrops, BackdropController.width, BackdropController.y);
    PatternController.infinityMove(_floors, FloorController.width, FloorController.y);
    TowerController.move(_tower);
    BladeController.move(_blade);
    EngineerController.standUp(_engineer);
    if(TowerController.isPassingTower(_tower, _counter, player)){
      destroyWindTurbine();
      addWindTurbine();
    }
    if(EngineerController.isResettable(_engineer)){
      resetWorld();
    }
  }
  
}