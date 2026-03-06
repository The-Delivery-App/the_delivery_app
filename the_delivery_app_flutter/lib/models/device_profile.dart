class DeviceProfile {
  final int screenResolutionX;
  final int screenResolutionY;
  final double dpi;
  final double dataTransferRateMbps;

  const DeviceProfile({
    required this.screenResolutionX,
    required this.screenResolutionY,
    required this.dpi,
    required this.dataTransferRateMbps,
  });
}
