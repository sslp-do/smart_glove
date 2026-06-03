class GloveStatus {
  final int battery;
  final bool isConnected;
  final bool isCharging;

  GloveStatus({
    required this.battery,
    required this.isConnected,
    this.isCharging = false,
  });

  factory GloveStatus.fromJson(Map<String, dynamic> json) {
    return GloveStatus(
      battery: json['battery'] ?? 0,
      isConnected: json['isConnected'] ?? false,
      isCharging: json['isCharging'] ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
    'battery': battery,
    'isConnected': isConnected,
    'isCharging': isCharging,
  };

}