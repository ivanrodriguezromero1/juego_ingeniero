import 'dart:math';
import 'package:audioplayers/audioplayers.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/material.dart';
import 'package:juego_ingeniero/models/engineer.dart';
import 'package:juego_ingeniero/models/floor.dart';
import 'package:juego_ingeniero/models/wind_turbine.dart';
import '../controllers/engineer_controller.dart';
import '../controllers/background_controller.dart';
import '../models/backdrop.dart';
import '../models/blade.dart';
import '../controllers/screen_controller.dart';
import '../controllers/wind_turbine_controller.dart';
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
  
  late List<Backdrop> backdrops;
  late List<Floor> floors;
  late WindTurbine windTurbine;
  late Wall wall;
  late Engineer engineer;
  late Counter counter;

  double heightRandom(){
    return (ScreenController.worldSize.y/4)*(1 + 0.5*Random().nextDouble());
  }
  void initialize(){
    // Max X 8.4
    backdrops = [Backdrop(x: 0), Backdrop(x: totalWidth)];
    floors = [Floor(x: 0), Floor(x: totalWidth)];
    double h  = heightRandom();
    windTurbine = WindTurbine(height: h);
    wall = Wall();
    engineer = Engineer();
    counter = Counter();
  }
  void addToWorld(){
    addAll(backdrops);
    addAll(floors);
    add(windTurbine.tower);
    add(windTurbine.blade);
    add(wall);
    add(engineer);
    add(counter);
  }
  void destroyBodies(){
    backdrops[0].destroy();
    backdrops[1].destroy();
    floors[0].destroy();
    floors[1].destroy();
    wall.destroy();
    windTurbine.tower.destroy();
    windTurbine.blade.destroy();
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
    BackgroundController.move(backdrops, 0);
    BackgroundController.move(floors, posY0);
    EngineerController.setCanJump(engineer);
    EngineerController.standUp(engineer);
    WindTurbineController.move(windTurbine.tower, windTurbine.blade);
    if(WindTurbineController.isPassingTower(windTurbine.tower, counter, player)){      
      windTurbine.tower.destroy();
      windTurbine.blade.destroy();
      windTurbine = WindTurbine(height: heightRandom());
      add(windTurbine.tower);
      add(windTurbine.blade);      
    }
    if(EngineerController.hasLost(engineer)){
      resetWorld();
    }
  }
  //--------------------------------------------------------------
}