import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_dashboard/model/influence_account.dart' as infAccount;
import 'package:flutter_dashboard/util/css_color.dart';

class WeightsChartWidget extends StatelessWidget {
  const WeightsChartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: infAccount.stats,
      builder: (context, value, child) {
        final departments = (value['departments'] as List<dynamic>?) ?? [];
        
        if (departments.isEmpty) {
          return Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.pie_chart_outline,
                    size: 48,
                    color: Colors.grey,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No Weight Data Available',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Weight distribution will appear here once data is loaded.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
          );
        }

        // Calculate total for percentages
        final total = departments.fold<double>(0.0, (sum, dept) => sum + (dept['weight'] ?? 0.0).toDouble());
        
        if (total == 0) {
          return Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.pie_chart_outline,
                    size: 48,
                    color: Colors.grey,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No Weights Assigned',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),
            ),
          );
        }

        // Create pie chart sections
        final sections = departments.asMap().entries.map<PieChartSectionData>((entry) {
          final dept = entry.value;
          final weight = (dept['weight'] ?? 0.0).toDouble();
          final percentage = (weight / total * 100);
          
          Color color = Colors.grey;
          if (dept['color'] != null) {
            try {
              color = cssColorToColor(dept['color']!);
            } catch (e) {
              print('Error parsing color: ${dept['color']}');
            }
          }
          
          return PieChartSectionData(
            color: color,
            value: weight,
            title: '${percentage.toStringAsFixed(1)}%',
            radius: 60,
            titleStyle: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          );
        }).toList();

        return Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Expanded(
                  child: PieChart(
                    PieChartData(
                      sections: sections,
                      sectionsSpace: 2,
                      centerSpaceRadius: 40,
                      startDegreeOffset: -90,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Wrap(
                  spacing: 8.0,
                  runSpacing: 4.0,
                  children: departments.map<Widget>((dept) {
                    Color color = Colors.grey;
                    if (dept['color'] != null) {
                      try {
                        color = cssColorToColor(dept['color']!);
                      } catch (e) {
                        print('Error parsing color: ${dept['color']}');
                      }
                    }
                    
                    return Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 12,
                          height: 12,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: color,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          dept['departmentTitle'] ?? 'Unknown',
                          style: const TextStyle(fontSize: 12),
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
