import 'package:flutter_dashboard/util/css_color.dart';
import 'package:flutter_dashboard/util/icon_helper.dart';
import 'package:flutter_dashboard/util/responsive.dart';
import 'package:flutter_dashboard/widgets/dashboard_pages/influence_system/components/department_selection_card.dart';
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
  ValueNotifier<BuiltList<GetUserDivisions200ResponseInner>> customDivisions =
      ValueNotifier(current_user.divisions.value);

  @override
  void initState() {
    super.initState();
    _sortCustomDivisions();
  }

  void _sortCustomDivisions() {
    final sortedList = customDivisions.value.toList()
      ..sort((a, b) => a.department!.compareTo(b.department!));
    customDivisions.value =
        BuiltList<GetUserDivisions200ResponseInner>(sortedList);
  }

  @override
  Widget build(BuildContext context) {
    final totalWeight = customDivisions.value
        .fold(0, (sum, division) => sum + (division.weight ?? 0));

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: Column(
          children: [
            const SizedBox(height: 10),
            CustomCard(
                padding: const EdgeInsets.all(20),
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: customDivisions.value.length,
                  itemBuilder: (context, index) {
                    final division = customDivisions.value[index];
                    return Column(
                      children: [
                        Row(
                          children: [
                            Icon(icons[division.logo] ?? Icons.error,
                                color: cssColorToColor(division.color!)),
                            const SizedBox(width: 8),
                            Text(
                                "${division.title} : ${division.weight.toString()}",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: cssColorToColor(division.color!))),
                          ],
                        ),
                        Slider(
                          value: (division.weight?.toDouble() ?? 0.0),
                          min: 1,
                          max: 100 - (customDivisions.value.length - 1),
                          divisions: 100 - (customDivisions.value.length - 1),
                          label: division.weight?.toString(),
                          activeColor: cssColorToColor(division.color!),
                          inactiveColor:
                              cssColorToColor(division.color!).withOpacity(0.3),
                          onChanged: (double value) {
                            print("value: $value");
                            setState(() {
                              final updatedDivision = customDivisions
                                  .value[index]
                                  .rebuild((b) => b.weight = value.toInt());
                              final updatedList = customDivisions.value
                                  .rebuild((b) => b[index] = updatedDivision);
                              customDivisions.value = updatedList;
                            });
                          },
                        ),
                        const SizedBox(height: 10),
                      ],
                    );
                  },
                )),
            const SizedBox(height: 18),
            CustomCard(
                padding: const EdgeInsets.all(20),
                child: Column(children: [
                  WeightsChartWidget(
                      category: "Settings",
                      filter: "All",
                      customDivisions: customDivisions),
                  const SizedBox(height: 18),
                  ElevatedButton(
                    onPressed: () async {
                      if (totalWeight == 100) {
                        await current_user.setWeights(customDivisions.value);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Saving weights..'),
                            backgroundColor: Colors.green,
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                                'Total weight must be 100 to save weights.'),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          totalWeight == 100 ? Colors.green : Colors.red,
                    ),
                    child: Text(
                      'Save',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ])),
            const SizedBox(height: 18),
            const SizedBox(height: 18),
          ],
        ),
      ),
    );
  }
}
