import 'package:audioplayers/audioplayers.dart';
import 'package:flame/components.dart';
import '../controllers/screen_controller.dart';

late List<Sprite> ingenieros;
late Sprite floor;
late Sprite backdrop;
late Sprite rock;
late Sprite tower;
late Sprite blade;
AudioPlayer player = AudioPlayer();
bool assetsLoaded = false;
Vector2 initialWorldLinearVelocity = Vector2(-4, 0);
double initialBladeAngularVelocity = radians(360);
Vector2 worldLinearVelocity = initialWorldLinearVelocity;
double bladeAngularVelocity = initialBladeAngularVelocity;
double posY0 = 2 * ScreenController.worldSize.y/3;
double totalWidth = 2 * ScreenController.worldSize.x;