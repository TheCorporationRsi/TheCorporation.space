import 'package:flutter_dashboard/model/health_model.dart';

class HealthDetails {
  final healthData = const [
    HealthModel(icon: 'assets/icons/burn.png', value: "50", title: "Tribute"),
    HealthModel(
        icon: 'assets/icons/steps.png', value: "10,983 ", title: "Infleunce"),
    HealthModel(
        icon: 'assets/icons/distance.png',
        value: "60,000",
        title: "Lifetime Influence"),
    HealthModel(
        icon: 'assets/icons/sleep.png', value: "Corporateer", title: "Rank"),
  ];
}
