import 'dart:math';
import 'package:audioplayers/audioplayers.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/material.dart';
import 'package:juego_ingeniero/models/engineer.dart';
import 'package:juego_ingeniero/models/floor.dart';
import '../controllers/blade_controller.dart';
import '../controllers/engineer_controller.dart';
import '../controllers/pattern_controller.dart';
import '../models/backdrop.dart';
import '../models/blade.dart';
import '../models/entity.dart';
import '../controllers/screen_controller.dart';
import '../controllers/tower_controller.dart';
import '../models/counter.dart';
import '../models/tower.dart';
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
  //--------------Main Code-------------------------------------------
  late List<Entity> backdrops;
  late List<Entity> floors;
  late Entity tower;
  late Entity blade;
  late Entity wall;
  late Entity engineer;
  late Counter counter;
  void initialize(){
    backdrops = [Backdrop(x: 0), Backdrop(x: totalWidth)];
    floors = [Floor(x: 0), Floor(x: totalWidth)];
    double h  = (ScreenController.worldSize.y/4)*(1 + 0.5*Random().nextDouble());
    tower = Tower(height: h);
    blade = Blade(height: h/2);
    wall = Wall();
    engineer = Engineer();
    counter = Counter();
  }
  void addToWorld(){
    addAll(backdrops);
    addAll(floors);
    add(tower);
    add(blade);
    add(wall);
    add(engineer);
    add(counter);
  }
  void addWindTurbine(){
    double height  = (ScreenController.worldSize.y/4)*(1 + 0.5*Random().nextDouble());
    tower = Tower(height: height);
    blade = Blade(height: height/2); 
    add(tower);
    add(blade);
  }
  void destroyWindTurbine(){
    tower.destroy();
    blade.destroy();
  }
  void destroyBodies(){
    backdrops[0].destroy();
    backdrops[1].destroy();
    floors[0].destroy();
    floors[1].destroy();
    wall.destroy();
    tower.destroy();
    blade.destroy();
    engineer.destroy();
    counter.destroy();
  }
  void resetVelocity(){
    worldLinearVelocity = initialWorldLinearVelocity;
    bladeAngularVelocity = initialBladeAngularVelocity;
  }
  void addComponents(){
    initialize();
    addToWorld();
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
    EngineerController.jump(engineer);
  }
  @override
  void update(double dt) {
    super.update(dt);
    PatternController.infinityMove(backdrops, totalWidth, 0);
    PatternController.infinityMove(floors, totalWidth, posY0);
    TowerController.move(tower);
    BladeController.move(blade);
    EngineerController.setCanJump(engineer);
    EngineerController.standUp(engineer);
    if(TowerController.isPassingTower(tower, counter, player)){
      destroyWindTurbine();
      addWindTurbine();
    }
    if(EngineerController.isResettable(engineer)){
      resetWorld();
    }
  }
  //--------------------------------------------------------------
}