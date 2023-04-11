import 'package:flame/components.dart';
import 'package:juego_ingeniero/utils/constants.dart';
import 'package:juego_ingeniero/utils/globals.dart';

class AssetController{
  static Future<void> loadAssets() async {
    if (!assetsLoaded) {    
      ingenieros = [];
      for(String filename in ingenieroFilenames) {
        ingenieros.add(await Sprite.load(filename));
      }
      floor = await Sprite.load(floorFilename);
      backdrop = await Sprite.load(backdropFilename);
      rock = await Sprite.load(rockFilename);
      tower = await Sprite.load(towerFilename);
      assetsLoaded = true;
    }
}
}