import 'dart:async';
import 'package:sensors_plus/sensors_plus.dart';
import '../../core/constants.dart';

class SensorService {
  StreamSubscription<GyroscopeEvent>? _gyroSub;
  DateTime _lastEmit = DateTime.fromMillisecondsSinceEpoch(0);

  void listenGyroscope(void Function(GyroscopeEvent e) onData) {
    _gyroSub?.cancel();
    _gyroSub = gyroscopeEvents.listen((e) {
      final now = DateTime.now();
      if (now.difference(_lastEmit) >= K.minSampleInterval) {
        _lastEmit = now;
        onData(e);
      }
    });
  }

  void dispose() {
    _gyroSub?.cancel();
  }
}
