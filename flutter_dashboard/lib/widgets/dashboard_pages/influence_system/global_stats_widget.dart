import 'package:flutter_dashboard/util/responsive.dart';
import 'package:flutter_dashboard/widgets/dashboard_pages/influence_system/components/department_selection_card.dart';
import 'package:flutter_dashboard/widgets/dashboard_pages/components/bar_graph_widget.dart';
import 'package:flutter_dashboard/widgets/dashboard_pages/components/line_chart_card.dart';
import 'package:flutter_dashboard/widgets/header/profile_widget.dart';
import 'package:flutter_dashboard/widgets/dashboard_pages/components/custom_card_widget.dart';
import 'package:flutter/material.dart';

import 'package:flutter_dashboard/widgets/dashboard_pages/influence_system/components/influence_details_card_stub.dart';
import 'package:flutter_dashboard/widgets/dashboard_pages/influence_system/components/weights_chart_widget_stub.dart';

class InfGlobalStatsWidget extends StatefulWidget {
  const InfGlobalStatsWidget({super.key});

  @override
  _InfGlobalStatsWidgetState createState() => _InfGlobalStatsWidgetState();
}

class _InfGlobalStatsWidgetState extends State<InfGlobalStatsWidget> {

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
            InfluenceDetailsCard(category: "Global", filter: filter, show_details: false),
            const SizedBox(height: 18),
          ],
        ),
      ),
    );
  }
}
