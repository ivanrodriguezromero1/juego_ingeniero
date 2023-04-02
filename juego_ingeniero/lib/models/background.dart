import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class Background extends PositionComponent {
  Background({super.size});
  static late double _width;
  static late double _height;
  @override
  void onLoad(){
    super.onLoad();
    _width = size.x;
    _height = size.y;
  }
  static void setWidthHeight(Vector2 newSize){
    _width = newSize.x;
    _height = newSize.y;
  }
  @override
  void render(Canvas canvas){
    super.render(canvas);
    canvas.drawRect(Rect.fromLTWH(0, 0, _width, _height), 
      Paint()..color = const Color(0xff17223b));  
  }
}