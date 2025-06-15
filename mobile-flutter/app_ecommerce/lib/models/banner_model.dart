class BannerModel {
  final String title;
  final String? subtitle;
  final String buttonText;
  final String buttonAction;

  BannerModel({
    required this.title,
    this.subtitle,
    required this.buttonText,
    required this.buttonAction,
  });
}
