import 'package:flutter_dashboard/const/constant.dart';
import 'package:flutter_dashboard/data/pie_chart_data.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dashboard/model/current_user.dart' as current_user;
import 'package:flutter_dashboard/util/css_color.dart';
import 'package:flutter_dashboard/util/icon_helper.dart';

class WeightsChartWidget extends StatelessWidget {
  final String filter;
  final String category;
  const WeightsChartWidget({super.key, required this.category, required this.filter});

  @override
  Widget build(BuildContext context) {

    late final all_departments;
    late final all_divisions;
      if (category == "Personal"){
        all_departments = current_user.departments;
        all_divisions = current_user.divisions;
      } else {
        all_departments = current_user.departments;
        all_divisions = current_user.divisions;
      }

    List<PieChartSectionData> generateStats() {
      if (filter == "All") {
        int totalWeight = all_departments.value.isNotEmpty 
            ? all_departments.value.map((department) => department.weight!).reduce((a, b) => a + b) 
            : 0;
        return [
          if (totalWeight < 1)
          PieChartSectionData(
            color: backgroundColor,
            value: 1,
            radius: 25,
            showTitle: false,
          )
          else
          ...all_departments.value.map((department) {
          return PieChartSectionData(
            color: department.color != null ? cssColorToColor(department.color!) : Colors.grey,
            value: department.weight!.toDouble(),
            title: department.title,
            radius: 25,
            showTitle: false,
          );
        }).toList()
        ];
      } else {
        final department = all_departments.value.firstWhere((element) => element.title == filter);
        final divisions = all_divisions.value.where((element) => element.department == filter).toList();
        return [
          if (department.weight! < 1)
          PieChartSectionData(
            color: backgroundColor,
            value: 1,
            radius: 25,
            showTitle: false,
          )
          else
          ...divisions.asMap().entries.map((entry) {
            int index = entry.key;
            var division = entry.value;
            return PieChartSectionData(
              color: department.color != null ? cssColorToColor(department.color!).withOpacity(1.0 - (index * 0.1)) : Colors.grey.withOpacity(1.0 - (index * 0.1)),
              value: division.weight!.toDouble(),
              title: division.title,
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
        valueListenable: all_departments,
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
                      "100",
                      style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            height: 0.5,
                          ),
                    )
                  else
                  Text(
                    all_departments.value.firstWhere((element) => element.title == filter).weight.toString(),
                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          height: 0.5,
                        ),
                  ),
                  const SizedBox(height: 8),
                  const Text("%")
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}