import '../models/engineer.dart';
import '../models/entity.dart';
import '../models/floor.dart';
import '../models/tower.dart';
import '../models/wall.dart';
import '../models/backdrop.dart';
import '../models/blade.dart';

class Factory {
  static Entity createObject(String objectType, {double x = 0, double height = 0}){
    if(objectType == "backdrop"){
      return Backdrop(x: x);
    } else if(objectType == "floor") {
      return Floor(x: x);
    } else if(objectType == "tower") {
      return Tower(height: height);
    } else if(objectType == "blade") {
      return Blade(height: height);
    } else if(objectType == "wall") {
      return Wall();
    } else if(objectType == "engineer") {
      return Engineer();
    } else {
      throw ArgumentError("Invalid object type");
    }
  }
}