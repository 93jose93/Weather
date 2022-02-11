class Temp {
  final num day;
  final num min;
  final num max;
  final num night;
  final num eve;
  final num morn;

  Temp(
      {required this.day,
      required this.min,
      required this.max,
      required this.night,
      required this.eve,
      required this.morn});

  static Temp? fromSnapshot(Map data) {
    try {
      return Temp(
          day: data['day'],
          min: data['min'],
          max: data['max'],
          night: data['night'],
          eve: data['eve'],
          morn: data['morn']);
    } catch (e) {
      return null;
    }
  }
}
