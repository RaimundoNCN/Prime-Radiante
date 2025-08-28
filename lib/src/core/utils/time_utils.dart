class TimeUtils {
  static bool timedOut(DateTime? from, Duration max) {
    if (from == null) return false;
    return DateTime.now().difference(from) > max;
  }
}
