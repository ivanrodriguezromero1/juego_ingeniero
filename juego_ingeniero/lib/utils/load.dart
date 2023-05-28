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
      ingenierosSprites = [];
      for(String filename in ingenieroFilenames) {
        ingenierosSprites.add(await Sprite.load(filename));
      }
      floorSprite = await Sprite.load(floorFilename);
      backdropSprite = await Sprite.load(backdropFilename);
      rockSprite = await Sprite.load(rockFilename);
      towerSprite = await Sprite.load(towerFilename);
      bladeSprite = await Sprite.load(bladeFilename);

      assetsLoaded = true;
    }
}
}