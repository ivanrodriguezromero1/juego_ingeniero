import '../models/tower.dart';
import '../models/blade.dart';

class WindTurbine {  
  late Tower _tower;
  late Blade _blade;
  final double _height;
  WindTurbine({required height}):_height=height{
    _tower = Tower(height: _height);
    _blade = Blade(height: _height);
  }   
  Tower get tower => _tower;
  Blade get blade => _blade;

}