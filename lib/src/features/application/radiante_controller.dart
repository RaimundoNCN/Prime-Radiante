import 'dart:async';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:flutter/foundation.dart';
import '../domain/radiant_state.dart';
import '../../core/constants.dart';
import '../infrastructure/sensor_service.dart';
import '../domain/gestures/circular_motion_detector.dart';

class RadianteController extends ChangeNotifier {
  final SensorService _sensor;
  final CircularMotionDetector _detector;

  RadiantState _state = RadiantState.idle;
  RadiantState get state => _state;

  Timer? _doubleTapTimer;
  bool _doubleTapWindowOpen = false;

  GyroscopeEvent? lastGyro;

  RadianteController(this._sensor) : _detector = CircularMotionDetector() {
    _detector.onDetected = _onCircleDetected;
    _sensor.listenGyroscope(_onGyro);
  }

  void _onGyro(GyroscopeEvent e) {
    lastGyro = e;
    _detector.process(e.x, e.y);
  }

  void _onCircleDetected() {
    if (_state == RadiantState.idle) {
      _state = RadiantState.prontoParaToque;
      _openDoubleTapWindow();
      notifyListeners();
    }
  }

  void _openDoubleTapWindow() {
    _doubleTapWindowOpen = true;
    _doubleTapTimer?.cancel();
    _doubleTapTimer = Timer(K.doubleTapWindow, () {
      _doubleTapWindowOpen = false;
      if (_state == RadiantState.prontoParaToque) {
        reset();
      }
    });
  }

  void onDoubleTap() {
    if (_state == RadiantState.prontoParaToque && _doubleTapWindowOpen) {
      _state = RadiantState.ativo;
      _doubleTapWindowOpen = false;
      _doubleTapTimer?.cancel();
      notifyListeners();
    }
  }

  void reset() {
    _state = RadiantState.idle;
    _doubleTapWindowOpen = false;
    _doubleTapTimer?.cancel();
    _detector.reset();
    notifyListeners();
  }

  @override
  void dispose() {
    _doubleTapTimer?.cancel();
    super.dispose();
  }
}
