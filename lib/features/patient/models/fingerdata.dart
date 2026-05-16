class FingerData {
  final double thumb;
  final double index;
  final double middle;
  final double ring;
  final double little;

  FingerData({
    required this.thumb,
    required this.index,
    required this.middle,
    required this.ring,
    required this.little,
  });

  // لتحويل البيانات القادمة من Firebase (JSON) إلى Object
  factory FingerData.fromJson(Map<String, dynamic> json) {
    return FingerData(
      thumb: (json['thumb'] ?? 0).toDouble(),
      index: (json['index'] ?? 0).toDouble(),
      middle: (json['middle'] ?? 0).toDouble(),
      ring: (json['ring'] ?? 0).toDouble(),
      little: (json['little'] ?? 0).toDouble(),
    );
  }

  // لتحويل الـ Object إلى JSON لتخزينه
  Map<String, dynamic> toJson() => {
    'thumb': thumb,
    'index': index,
    'middle': middle,
    'ring': ring,
    'little': little,
  };
}