class PlatformInfoModel {
  final String? stationName;
  final List<String> color;
  final String platform;
  final bool isInterChange;
  const PlatformInfoModel({
    this.stationName,
    required this.color,
    required this.platform,
    required this.isInterChange,
  });
}
