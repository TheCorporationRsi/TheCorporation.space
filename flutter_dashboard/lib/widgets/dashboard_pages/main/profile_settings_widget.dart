import 'package:flutter_dashboard/util/responsive.dart';
import 'package:flutter_dashboard/widgets/dashboard_pages/Influence_system/components/department_selection_card.dart';
import 'package:flutter_dashboard/widgets/dashboard_pages/components/bar_graph_widget.dart';
import 'package:flutter_dashboard/widgets/dashboard_pages/components/line_chart_card.dart';
import 'package:flutter_dashboard/widgets/header/profile_widget.dart';
import 'package:flutter_dashboard/widgets/dashboard_pages/components/custom_card_widget.dart';
import 'package:flutter/material.dart';


import 'package:flutter_dashboard/widgets/dashboard_pages/influence_system/components/weights_chart_widget.dart';
import 'package:built_collection/built_collection.dart';
import 'package:corp_api/corp_api.dart';

import 'package:flutter_dashboard/model/current_user.dart' as current_user;


class ProfileSettingsWidget extends StatefulWidget {
  const ProfileSettingsWidget({super.key});

  @override
  _ProfileSettingsWidgetState createState() => _ProfileSettingsWidgetState();
}

class _ProfileSettingsWidgetState extends State<ProfileSettingsWidget> {

  String filter = "All";
  BuiltList<GetUserDivisions200ResponseInner> customDivisions = current_user.divisions.value;
  

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: Column(
          children: [
            const SizedBox(height: 10),
            const SizedBox(height: 18),
            WeightsChartWidget(category: "Settings", filter: "All", customDivisions: customDivisions),
            const SizedBox(height: 18),
            
          ],
        ),
      ),
    );
  }
}
