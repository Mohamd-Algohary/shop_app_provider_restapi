extension NonNullString on String? {
  String orEmpty() {
    return this ?? '';
  }
}

extension NanNullInt on int? {
  int orZero() {
    return this ?? 0;
  }
}

extension NanNullDouble on double? {
  double orZero() {
    return this ?? 0.00;
  }
}

extension NanNullDateTime on DateTime? {
  DateTime dateTimeNow() {
    return this ?? DateTime.now();
  }
}
