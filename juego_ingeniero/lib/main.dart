import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:juego_ingeniero/view/game_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Flame.device.fullScreen();
  await Flame.device.setLandscape();
  runApp(const MaterialApp(
    home: GameEngineer(),
  ));
}