import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Flame.device.fullScreen();
  runApp(const MaterialApp(
    home: MyApp(),
  ));
}
class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  MyAppState createState() => MyAppState();
}
class MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    double widthPiso = 7 * MediaQuery.of(context).size.width;
    double heightPiso = 2 * MediaQuery.of(context).size.height;
    Vector2 sizePiso = Vector2(widthPiso, heightPiso);
    return GameWidget(game: MyGame(sizePiso));
  }
}
class MyGame extends Game with TapDetector {
  final Vector2 _sizePiso;
  final List<Sprite> _ingenieros = [];
  double _tiempo = 0;
  int _indiceSpriteActual = 0;
  late Sprite _piso1;
  late Sprite _piso2;
  late Sprite _fondo1;
  late Sprite _fondo2;
  double widthIngeniero = 1;
  double heightIngeniero = 1;
  Vector2 _positionIngeniero = Vector2(20, 100);
  late Vector2 _sizeIngeniero;
  late Vector2 _velocityIngeniero = Vector2(0, 0);
  late Vector2 _positionPiso1;
  late Vector2 _positionPiso2;
  late Vector2 _positionFondo1;
  late Vector2 _positionFondo2;
  late Vector2 _velocityPiso;
  late Vector2 _velocityFondo;
  double widthPiso = 1;
  double heightPiso = 1;
  late final Vector2 _gravity;
  bool _canJump = true;
  final double _jumpVelocity = -700.0;
  late double widthFondo;
  late double heightFondo;
  late Vector2 _sizeFondo;
  MyGame(this._sizePiso);

  @override
  Future<void> onLoad() async {
    _ingenieros.add(await Sprite.load('ingeniero1.png'));
    _ingenieros.add(await Sprite.load('ingeniero2.png'));
    _ingenieros.add(await Sprite.load('ingeniero3.png'));
    _ingenieros.add(await Sprite.load('ingeniero4.png'));
    _ingenieros.add(await Sprite.load('ingeniero5.png'));
    _ingenieros.add(await Sprite.load('ingeniero6.png'));
    _ingenieros.add(await Sprite.load('ingeniero7.png'));
    _ingenieros.add(await Sprite.load('ingeniero8.png'));
    _ingenieros.add(await Sprite.load('ingeniero9.png'));
    _ingenieros.add(await Sprite.load('ingeniero10.png'));
    _piso1 = await Sprite.load('piso.png');
    _piso2 = await Sprite.load('piso.png');
    _fondo1 = await Sprite.load('fondo1.png');
    _fondo2 = await Sprite.load('fondo1.png');
    widthIngeniero = _ingenieros[0].image.width/6;
    heightIngeniero = _ingenieros[0].image.height/6;
    _sizeIngeniero = Vector2(widthIngeniero, heightIngeniero);
    _positionPiso1 = Vector2(0, 205 + heightIngeniero);
    _positionPiso2 = Vector2(_sizePiso.x, 205 + heightIngeniero);
    _positionFondo1 = Vector2(0, 0);
    widthFondo = _fondo1.image.width.toDouble()/3;
    heightFondo = _fondo1.image.height.toDouble()/2;
    _sizeFondo = Vector2(widthFondo, heightFondo);
    _positionFondo2 = Vector2(widthFondo, 0);
    _velocityPiso = Vector2(200, 0);
    _velocityFondo = Vector2(100, 0);
    _gravity = Vector2(0, 1500);
  }
 
 @override
  void onTapDown(TapDownInfo info) {
    if (_canJump) {
      _velocityIngeniero.y = _jumpVelocity;
      _canJump = false;
    }
  }
  
  @override
  void update(double dt) {
     _tiempo += dt;
    if (_tiempo > 0.1) { // Cambiar el sprite cada 0.1 segundos
      _indiceSpriteActual = (_indiceSpriteActual + 1) % _ingenieros.length;
      _tiempo = 0;
    }
    _velocityIngeniero += _gravity * dt;
    _positionIngeniero += _velocityIngeniero * dt;
    
    // Actualizar _canJump si el jugador está tocando el suelo
    if (_positionIngeniero.y >= 215) {
      _velocityIngeniero.y = 0;
      _positionIngeniero.y = 215;
      _canJump = true;
    } else {
      _canJump = false;
    }

    _positionPiso1.x -= _velocityPiso.x * dt;
    _positionPiso2.x -= _velocityPiso.x * dt;
    _positionFondo1.x -= _velocityFondo.x * dt;
    _positionFondo2.x -= _velocityFondo.x * dt;
    if(_positionFondo1.x <= -1*widthFondo){
      _positionFondo1.x = _positionFondo2.x + widthFondo;
    }
    if(_positionFondo2.x <= -1*widthFondo){
      _positionFondo2.x = _positionFondo1.x + widthFondo;
    }
    if(_positionPiso1.x <= -1*_sizePiso.x){
      _positionPiso1.x = _positionPiso2.x + _sizePiso.x;
    }
    if(_positionPiso2.x <= -1*_sizePiso.x){
      _positionPiso2.x = _positionPiso1.x + _sizePiso.x;
    }

  }

  @override
  void render(Canvas canvas) {
      _fondo1.render(canvas, position: _positionFondo1, size: _sizeFondo);
      _fondo2.render(canvas, position: _positionFondo2, size: _sizeFondo);
      _piso1.render(canvas, position: _positionPiso1, size: _sizePiso);
      _piso2.render(canvas, position: _positionPiso2, size: _sizePiso);
     _ingenieros[_indiceSpriteActual].render(canvas, position: _positionIngeniero, size: _sizeIngeniero);
  }
}

