class GloveStatus {
  final int battery;
  final bool isConnected;
  final bool isCharging;

  GloveStatus({
    required this.battery,
    required this.isConnected,
    this.isCharging = false,
  });
}