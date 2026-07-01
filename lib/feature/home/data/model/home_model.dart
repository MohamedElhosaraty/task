class HomeModel {
  final String headerTitle;
  final String aboutTitle;
  final String aboutContent;
  final String workTitle;
  final List<WorkFeatureModel> workFeatures;

  HomeModel({
    required this.headerTitle,
    required this.aboutTitle,
    required this.aboutContent,
    required this.workTitle,
    required this.workFeatures,
  });

  factory HomeModel.fromJson(Map<String, dynamic> json) {
    return HomeModel(
      headerTitle: json['header_title'] ?? '',
      aboutTitle: json['about_title'] ?? '',
      aboutContent: json['about_content'] ?? '',
      workTitle: json['work_title'] ?? '',
      workFeatures: (json['work_features'] as List<dynamic>? ?? [])
          .map((e) => WorkFeatureModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class WorkFeatureModel {
  final String title;

  WorkFeatureModel({required this.title});

  factory WorkFeatureModel.fromJson(Map<String, dynamic> json) {
    return WorkFeatureModel(title: json['title'] ?? '');
  }
}
