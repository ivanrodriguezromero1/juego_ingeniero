import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:juego_ingeniero/controllers/asset_controller.dart';
import 'package:flutter/material.dart';
import 'package:juego_ingeniero/controllers/engineer_controller.dart';
import 'package:juego_ingeniero/models/backdrop.dart';
import 'package:juego_ingeniero/models/background.dart';
import 'package:juego_ingeniero/models/engineer.dart';
import 'package:juego_ingeniero/models/floor.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import '../controllers/backdrop_controller.dart';
import '../controllers/floor_controller.dart';
import '../controllers/screen_controller.dart';
import '../controllers/tower_controller.dart';
import '../models/counter.dart';
import '../models/tower.dart';
import '../models/wall.dart';

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
  late List<Backdrop> _backdrops;
  late List<Floor> _floors;
  late Tower _tower;
  late Wall _wall;
  late Engineer _engineer;
  late Counter _counter;
  
  void configCamera(){
    double width = 836;
    double height = 393;
    ScreenController.setScreenSize(Vector2(width, height));
    camera.viewport = FixedResolutionViewport(ScreenController.screenSize);
  }
  void addBackground(){
    Background.setWidthHeight(canvasSize);
    add(Background(size: ScreenController.screenSize)
      ..positionType=PositionType.viewport);
  }
  void addBackdrops(){
    _backdrops = [Backdrop(number: 1), Backdrop(number: 2)]; 
    addAll(_backdrops);
  }
  void addFloor(){
    _floors = [Floor(number: 1), Floor(number: 2)]; 
    addAll(_floors);
  }
  void addExample(){
    _tower = Tower();
    add(_tower);
  }
  void addWall(){
    _wall = Wall();
    add(_wall);
  }
  void addEngineer(){
    _engineer = Engineer();
    add(_engineer);
  }
  void addCounter(){
    _counter = Counter();
    add(_counter);
  }
  void addComponents(){
    addBackdrops();
    addFloor();
    addExample();
    addWall();
    addEngineer();
    addCounter();
  }
  void destroyBodies(){
    _backdrops[0].destroy();
    _backdrops[1].destroy();
    _floors[0].destroy();
    _floors[1].destroy();
    _tower.destroy();
    _engineer.destroy();    
    _counter.destroy();
  }
  @override
  Future<void> onLoad() async {
    configCamera();
    addBackground();
    await AssetController.loadAssets();
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
    BackdropController.infinityBackdrop(_backdrops);
    FloorController.infinityFloor(_floors);
    TowerController.infinityTower(_tower, _counter);
    TowerController.move(_tower);
    EngineerController.standUp(_engineer);
    if(EngineerController.isResettable(_engineer)){
      destroyBodies();
      addComponents();
    }
  }
  
}