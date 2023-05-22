import 'dart:math';
import 'package:audioplayers/audioplayers.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/material.dart';
import '../controllers/blade_controller.dart';
import '../controllers/engineer_controller.dart';
import '../controllers/pattern_controller.dart';
import '../factories/factory.dart';
import '../models/entity.dart';
import '../controllers/screen_controller.dart';
import '../controllers/tower_controller.dart';
import '../models/counter.dart';
import '../models/wall.dart';
import '../utils/camera.dart';
import '../utils/constants.dart';
import '../utils/globals.dart';
import '../utils/load.dart';

class GameEngineer extends StatefulWidget {
  const GameEngineer({Key? key}) : super(key: key);
  @override
  GameEngineerState createState() => GameEngineerState();
}
Game controlledGameBuilder() {
  return MyGameEngineer();
}
class GameEngineerState extends State<GameEngineer> {
  Widget buildGameWidget(BuildContext context) => const GameWidget.controlled(
    gameFactory: controlledGameBuilder
  );
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

  void addBackdrops(){
    _backdrops = [
      Factory.createObject('backdrop', x: 0),
      Factory.createObject('backdrop', x: totalWidth - 0.01)
    ];
    addAll(_backdrops);
  }
  void addFloor(){
    _floors = [
      Factory.createObject('floor', x: 0),
      Factory.createObject('floor', x: totalWidth - 0.01)
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
    configCamera(camera);
    await Assets.instance.loadAssets();
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
    PatternController.infinityMove(_backdrops, totalWidth, 0);
    PatternController.infinityMove(_floors, totalWidth, posY0);
    TowerController.move(_tower);
    BladeController.move(_blade);
    EngineerController.setCanJump(_engineer);
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