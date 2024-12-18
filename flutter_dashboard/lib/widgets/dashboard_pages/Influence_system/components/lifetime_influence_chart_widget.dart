import 'package:flutter_dashboard/const/constant.dart';
import 'package:flutter_dashboard/data/pie_chart_data.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dashboard/model/influence_account.dart' as infAccount;
import 'package:flutter_dashboard/util/css_color.dart';
import 'package:flutter_dashboard/util/icon_helper.dart';

class LifetimeInfluenceChartWidget extends StatelessWidget {
  final String filter;
  final String category;
  const LifetimeInfluenceChartWidget({super.key, required this.category, required this.filter});

  @override
  Widget build(BuildContext context) {

    late final stats;
      if (category == "Current_User"){
        stats = infAccount.stats;
      } else {
        stats = infAccount.stats;
      }

    List<PieChartSectionData> generateStats() {
      if (filter == "All") {
        return [
          PieChartSectionData(
            color: backgroundColor,
            value: stats.value.lifetimeGeneralInfluence!.toDouble() < 1 ? 1 : stats.value.lifetimeGeneralInfluence!.toDouble(),
            radius: 25,
            showTitle: false,
          ),
          ...stats.value.departments!.map((department) {
          return PieChartSectionData(
            color: department.color != null ? cssColorToColor(department.color!) : Colors.grey,
            value: department.lifetimeInfluence!.toDouble(),
            title: department.departmentTitle,
            radius: 25,
            showTitle: false,
          );
        }).toList()
        ];
      } else {
        final department = stats.value.departments!.firstWhere((element) => element.departmentTitle == filter);
        final department_lifetime_influence_only = department.lifetimeInfluence!.toDouble() - department.divisions!.map((division) => division.lifetimeInfluence!.toDouble()).reduce((a, b) => a + b);
        return [
          PieChartSectionData(
            color: backgroundColor,
            value: department_lifetime_influence_only < 1 ? 1 : department_lifetime_influence_only,
            radius: 25,
            showTitle: false,
          ),
          ...department.divisions!.asMap().entries.map((entry) {
            int index = entry.key;
            var division = entry.value;
            return PieChartSectionData(
              color: department.color != null ? cssColorToColor(department.color!).withOpacity(1.0 - (index * 0.1)) : Colors.grey.withOpacity(1.0 - (index * 0.1)),
              value: division.lifetimeInfluence!.toDouble(),
              title: division.divisionTitle,
              radius: 25,
              showTitle: false,
            );
          }).toList()
        ];
      }
    }
    

    return SizedBox(
      height: 200,
      child: ValueListenableBuilder(
        valueListenable: stats,
        builder: (context, value, child) => Stack(
          children: [
            PieChart(
              PieChartData(
                sectionsSpace: 0,
                centerSpaceRadius: 70,
                startDegreeOffset: -90,
                sections: generateStats()
                ,
              ),
            ),
            Positioned.fill(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: defaultPadding),
                  if (filter == "All")
                    Text(
                      stats.value.totalLifetimeInfluence.toString(),
                      style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            height: 0.5,
                          ),
                    )
                  else
                  Text(
                    stats.value.departments!.firstWhere((element) => element.departmentTitle == filter).lifetimeInfluence.toString(),
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
