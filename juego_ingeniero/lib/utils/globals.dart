import 'package:audioplayers/audioplayers.dart';
import 'package:flame/components.dart';
import '../models/screen.dart';

late List<Sprite> ingenierosSprites;
late Sprite floorSprite;
late Sprite backdropSprite;
late Sprite rockSprite;
late Sprite towerSprite;
late Sprite bladeSprite;
AudioPlayer player = AudioPlayer();
bool assetsLoaded = false;
Vector2 initialWorldLinearVelocity = Vector2(-4, 0);
double initialBladeAngularVelocity = radians(360);
Vector2 worldLinearVelocity = initialWorldLinearVelocity;
double bladeAngularVelocity = initialBladeAngularVelocity;
double posY0 = 2 * Screen.worldSize.y/3;
double totalWidth = 2 * Screen.worldSize.x - 0.01;