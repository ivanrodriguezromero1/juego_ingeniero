import 'package:flame/components.dart';
import 'package:juego_ingeniero/utils/constants.dart';
import 'package:juego_ingeniero/utils/globals.dart';

Future<void> loadAssets() async {
  if (!assetsLoaded) {    
    ingenieros = [];
    for(String filename in ingenieroFilenames) {
      ingenieros.add(await Sprite.load(filename));
    }
    floor = await Sprite.load(floorFilename);
    fondo = await Sprite.load(fondoFilename);
    assetsLoaded = true;
  }
}