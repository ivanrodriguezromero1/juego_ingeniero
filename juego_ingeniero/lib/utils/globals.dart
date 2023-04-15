import 'package:audioplayers/audioplayers.dart';
import 'package:flame/components.dart';

import 'constants.dart';

late List<Sprite> ingenieros;
late Sprite floor;
late Sprite backdrop;
late Sprite rock;
late Sprite tower;
late Sprite blade;
AudioPlayer player = AudioPlayer();

bool assetsLoaded = false;

Vector2 linearVelocityWorld = initialLinearVelocityWorld;
