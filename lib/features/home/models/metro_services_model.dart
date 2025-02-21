class MetroServicesModel {
  String id;
  bool active;
  String icon;
  String title;
  String targetScreen;
  int? targetPageIndex;

  MetroServicesModel({
    required this.id,
    required this.active,
    required this.icon,
    required this.title,
    required this.targetScreen,
    this.targetPageIndex,
  });

  static MetroServicesModel empty() => MetroServicesModel(
        id: '',
        active: false,
        icon: '',
        title: '',
        targetScreen: '',
      );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'active': active,
      'icon': icon,
      'title': title,
      'targetScreen': targetScreen,
      'targetPageIndex': targetPageIndex,
    };
  }

  factory MetroServicesModel.fromJson(Map<String, dynamic>? data) {
    if (data != null) {
      //Map Json record to the model
      return MetroServicesModel(
        id: data['id'],
        active: data['active'] ?? '',
        icon: data['icon'] ?? '',
        title: data['title'] ?? '',
        targetScreen: data['targetScreen'] ?? '',
        targetPageIndex: data['targetPageIndex'] ?? '',
      );
    } else {
      return MetroServicesModel.empty();
    }
  }
}
