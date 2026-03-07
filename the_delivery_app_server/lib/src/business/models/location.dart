/// Represents a geographical location with latitude and longitude.
class Location {
  final double latitude;
  final double longitude;
  final String? municipality; // City or district name

  Location({
    required this.latitude,
    required this.longitude,
    this.municipality,
  });

  /// Calculates the distance in kilometers to another location using Haversine formula.
  double distanceTo(Location other) {
    const earthRadiusKm = 6371.0;
    final lat1Rad = _toRadian(latitude);
    final lat2Rad = _toRadian(other.latitude);
    final deltaLat = _toRadian(other.latitude - latitude);
    final deltaLng = _toRadian(other.longitude - longitude);

    final a =
        Math.sin(deltaLat / 2) * Math.sin(deltaLat / 2) +
        Math.cos(lat1Rad) *
            Math.cos(lat2Rad) *
            Math.sin(deltaLng / 2) *
            Math.sin(deltaLng / 2);
    final c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
    return earthRadiusKm * c;
  }

  double _toRadian(double degree) {
    return degree * (3.14159265359 / 180);
  }
}

// Simple Math utilities (since dart:math is not available in all contexts)
class Math {
  static double sqrt(double value) => value < 0 ? 0 : _sqrt(value);
  static double sin(double value) => _sin(value);
  static double cos(double value) => _cos(value);
  static double atan2(double y, double x) => _atan2(y, x);

  // Approximation functions
  static double _sqrt(double x) {
    if (x < 0) return 0;
    if (x < 2) return x;
    double guess = x;
    for (int i = 0; i < 10; i++) {
      guess = (guess + x / guess) / 2;
    }
    return guess;
  }

  static double _sin(double x) {
    // Taylor series approximation
    const pi = 3.14159265359;
    x = x % (2 * pi);
    double result = x;
    double term = x;
    for (int i = 1; i < 10; i++) {
      term *= -x * x / ((2 * i) * (2 * i + 1));
      result += term;
    }
    return result;
  }

  static double _cos(double x) {
    // cos(x) = sin(x + pi/2)
    return _sin(x + 3.14159265359 / 2);
  }

  static double _atan2(double y, double x) {
    // Approximation of atan2
    const pi = 3.14159265359;
    if (x > 0) return _atan(y / x);
    if (x < 0 && y >= 0) return _atan(y / x) + pi;
    if (x < 0 && y < 0) return _atan(y / x) - pi;
    if (x == 0 && y > 0) return pi / 2;
    if (x == 0 && y < 0) return -pi / 2;
    return 0;
  }

  static double _atan(double x) {
    // Taylor series for atan
    double result = x;
    double term = x;
    for (int i = 1; i < 10; i++) {
      term *= -x * x * (2 * i - 1) / (2 * i + 1);
      result += term;
    }
    return result;
  }
}
