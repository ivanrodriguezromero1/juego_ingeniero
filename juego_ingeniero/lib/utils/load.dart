import 'package:flame/components.dart';
import '../utils/constants.dart';
import '../utils/globals.dart';

class Assets {
  static Assets? _instance;
  Assets._();
  static Assets get instance {
    _instance ??= Assets._();
    return _instance!;
  }
  Future<void> loadAssets() async {
    if (!assetsLoaded) {    
      ingenieros = [];
      for(String filename in ingenieroFilenames) {
        ingenieros.add(await Sprite.load(filename));
      }
      floor = await Sprite.load(floorFilename);
      backdrop = await Sprite.load(backdropFilename);
      rock = await Sprite.load(rockFilename);
      tower = await Sprite.load(towerFilename);
      blade = await Sprite.load(bladeFilename);

      assetsLoaded = true;
    }
}
}