import '../models/entity.dart';
import '../utils/globals.dart';

class BladeController {
  static void move(Entity blade){
    blade.body.linearVelocity = worldLinearVelocity;
    blade.body.angularVelocity = bladeAngularVelocity;
  }
}
