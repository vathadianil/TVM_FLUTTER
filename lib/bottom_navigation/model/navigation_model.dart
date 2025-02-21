class BottomNavigationModel {
  String id;
  bool active;
  String icon;
  String? targetScreen;
  int targetPageIndex;
  String title;

  BottomNavigationModel({
    required this.id,
    required this.active,
    required this.icon,
    this.targetScreen,
    required this.targetPageIndex,
    required this.title,
  });

  static BottomNavigationModel empty() => BottomNavigationModel(
      id: '',
      active: false,
      icon: '',
      targetPageIndex: 0,
      targetScreen: '',
      title: '');

  Map<String, dynamic> toJson() {
    return {
      'active': active,
      'icon': icon,
      'targetScreen': targetScreen,
      'targetPageIndex': targetPageIndex,
      'title': title
    };
  }

  factory BottomNavigationModel.fromJson(Map<String, dynamic>? data) {
    if (data != null) {
      //Map Json record to the model
      return BottomNavigationModel(
          id: data['id'],
          active: data['active'] ?? '',
          icon: data['icon'] ?? '',
          targetScreen: data['targetScreen'] ?? '',
          targetPageIndex: data['targetPageIndex'],
          title: data['title'] ?? '');
    } else {
      return BottomNavigationModel.empty();
    }
  }
}
