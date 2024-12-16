import 'package:flutter_dashboard/const/constant.dart';
import 'package:flutter_dashboard/data/pie_chart_data.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dashboard/model/influence_account.dart' as infAccount;
import 'package:flutter_dashboard/util/css_color.dart';
import 'package:flutter_dashboard/util/icon_helper.dart';

class TributeChartWidget extends StatelessWidget {
  final String filter;
  final String category;
  const TributeChartWidget(
      {super.key, required this.category, required this.filter});

  @override
  Widget build(BuildContext context) {
    late final profile;
    if (category == "Personal") {
      profile = infAccount.profile;
    } else {
      profile = infAccount.profile;
    }

    List<PieChartSectionData> generateStats() {
      if (filter == "All") {
        return [
          PieChartSectionData(
            color: backgroundColor,
            value: profile.value.tribute!.toDouble() < 1
                ? 1
                : profile.value.tribute!.toDouble(),
            radius: 25,
            showTitle: false,
          )
        ];
      } else {
        return [
          PieChartSectionData(
            color: backgroundColor,
            value: profile.value.tribute!.toDouble() < 1
                ? 1
                : profile.value.tribute!.toDouble(),
            radius: 25,
            showTitle: false,
          )
        ];
      }
    }

    return SizedBox(
      height: 200,
      child: ValueListenableBuilder(
        valueListenable: profile,
        builder: (context, value, child) => Stack(
          children: [
            PieChart(
              PieChartData(
                sectionsSpace: 0,
                centerSpaceRadius: 70,
                startDegreeOffset: -90,
                sections: generateStats(),
              ),
            ),
            Positioned.fill(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: defaultPadding),
                  Text(
                    profile.value.tribute.toString(),
                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          height: 0.5,
                        ),
                  ),
                  const SizedBox(height: 8),
                  const Text("Total")
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
