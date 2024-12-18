import 'package:flutter_dashboard/util/responsive.dart';
import 'package:flutter_dashboard/widgets/dashboard_pages/influence_system/components/department_selection_card.dart';
import 'package:flutter_dashboard/widgets/dashboard_pages/components/bar_graph_widget.dart';
import 'package:flutter_dashboard/widgets/dashboard_pages/components/line_chart_card.dart';
import 'package:flutter_dashboard/widgets/header/profile_widget.dart';
import 'package:flutter_dashboard/widgets/dashboard_pages/components/custom_card_widget.dart';
import 'package:flutter/material.dart';

import 'package:flutter_dashboard/widgets/dashboard_pages/influence_system/components/influence_details_card.dart';

class InfPersonalStatsWidget extends StatefulWidget {
  const InfPersonalStatsWidget({super.key});

  @override
  _InfPersonalStatsWidgetState createState() => _InfPersonalStatsWidgetState();
}

class _InfPersonalStatsWidgetState extends State<InfPersonalStatsWidget> {

  String filter = "All";

  

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: Column(
          children: [
            const SizedBox(height: 10),
            DepartmentSelectionCard(onChanged:(value) => setState(() {
              filter = value!;
            })),
            const SizedBox(height: 18),
            InfluenceDetailsCard(category: "Personnal", filter: filter, show_details: false),
            const SizedBox(height: 18),
            const LineChartCard(),
            const SizedBox(height: 18),
          ],
        ),
      ),
    );
  }
}
