import 'package:flutter_dashboard/util/css_color.dart';
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
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: customDivisions.length,
              itemBuilder: (context, index) {
                final division = customDivisions[index];
                return Column(
                  children: [
                    Text(division.title ?? 'Unknown Division', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold ,color: cssColorToColor(division.color!))),
                    Slider(
                      value: (division.weight?.toDouble() ?? 0.0)*100,
                      min: 0,
                      max: 100,
                      divisions: 100,
                      label: division.weight?.toString(),
                      activeColor: cssColorToColor(division.color!),
                      inactiveColor: cssColorToColor(division.color!).withOpacity(0.3),
                      onChanged: (double value) {
                        setState(() {
                          customDivisions = customDivisions.rebuild((b) => b[index] = b[index].rebuild((d) => d.weight = value.toInt()));
                        });
                      },
                    ),
                    TextField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Weight',
                        border: OutlineInputBorder(),
                      ),
                      controller: TextEditingController(text: division.weight?.toString()),
                      onChanged: (String value) {
                        setState(() {
                          customDivisions = customDivisions.rebuild((b) => b[index] = b[index].rebuild((d) => d.weight = int.tryParse(value)));
                        });
                      },
                    ),
                    const SizedBox(height: 10),
                  ],
                );
              },
            ),
            const SizedBox(height: 18),
            CustomCard(
          child:
            WeightsChartWidget(category: "Settings", filter: "All", customDivisions: customDivisions)),
            const SizedBox(height: 18),
            
          ],
        ),
      ),
    );
  }
}
