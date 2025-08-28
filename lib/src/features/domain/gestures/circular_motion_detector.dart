import 'package:flutter/foundation.dart';
import '../../../core/utils/time_utils.dart';
import '../../../core/constants.dart';

typedef OnCircle = void Function();

class CircularMotionDetector {
  final double limit;
  final double crossAxisLimit;
  final Duration stageTimeout;

  int _stage = 0;
  DateTime? _lastStageAt;

  OnCircle? onDetected;

  CircularMotionDetector({
    double? limit,
    double? crossAxisLimit,
    Duration? stageTimeout,
  }) : limit = limit ?? K.gyroThreshold,
       crossAxisLimit = crossAxisLimit ?? K.gyroThreshold * K.crossAxisFactor,
       stageTimeout = stageTimeout ?? K.stageTimeout;

  void reset() {
    _stage = 0;
    _lastStageAt = null;
  }

  void process(double x, double y) {
    if (TimeUtils.timedOut(_lastStageAt, stageTimeout)) {
      reset();
    }

    switch (_stage) {
      case 0:
        if (x > limit && y.abs() < crossAxisLimit) {
          _advance();
        }
        break;
      case 1:
        if (y > limit && x.abs() < crossAxisLimit) {
          _advance();
        }
        break;
      case 2:
        if (x < -limit && y.abs() < crossAxisLimit) {
          _advance();
        }
        break;
      case 3:
        if (y < -limit && x.abs() < crossAxisLimit) {
          _complete();
        }
        break;

      default:
        reset();
    }
  }

  void _advance() {
    _stage++;
    _lastStageAt = DateTime.now();
    if (kDebugMode) {
      print('CircularMotionDetector: advanced to stage $_stage');
    }
  }

  void _complete() {
    if (kDebugMode) {
      print('CircularMotionDetector: circle detected!');
    }
    onDetected?.call();
    reset();
  }
}
