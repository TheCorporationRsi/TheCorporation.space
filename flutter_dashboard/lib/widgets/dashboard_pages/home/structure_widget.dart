import 'package:flutter_dashboard/util/responsive.dart';
import 'package:flutter_dashboard/widgets/dashboard_pages/Influence_system/components/influence_details_card.dart';
import 'package:flutter_dashboard/widgets/dashboard_pages/components/bar_graph_widget.dart';
import 'package:flutter_dashboard/widgets/dashboard_pages/components/line_chart_card.dart';
import 'package:flutter_dashboard/widgets/header/profile_widget.dart';
import 'package:flutter_dashboard/widgets/dashboard_pages/components/custom_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_dashboard/const/constant.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_dashboard/util/video_player_widget.dart';

class StructureWidget extends StatefulWidget {
  const StructureWidget({super.key});

  @override
  _StructureWidgetState createState() => _StructureWidgetState();
}

class _StructureWidgetState extends State<StructureWidget> {

  final List<Map<String, dynamic>> departments = [
    {
      'name': 'Human Resources',
      'divisions': ['Recruitment', 'Employee Relations', 'Training & Development']
    },
    {
      'name': 'Finance',
      'divisions': ['Accounting', 'Budgeting', 'Payroll']
    },
    {
      'name': 'Marketing',
      'divisions': ['Advertising', 'Market Research', 'Public Relations']
    },
    {
      'name': 'IT',
      'divisions': ['Infrastructure', 'Software Development', 'Support']
    },
    {
      'name': 'Operations',
      'divisions': ['Logistics', 'Quality Control', 'Production']
    },
    {
      'name': 'Operations',
      'divisions': ['Logistics', 'Quality Control', 'Production']
    },
    {
      'name': 'Operations',
      'divisions': ['Logistics', 'Quality Control', 'Production']
    },
    {
      'name': 'Operations',
      'divisions': ['Logistics', 'Quality Control', 'Production']
    },
    {
      'name': 'Operations',
      'divisions': ['Logistics', 'Quality Control', 'Production']
    },
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Column(
                children: [
                  const SizedBox(height: 10),
                  Text('The Corporation Structure',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.orbitron(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      )),
                  const SizedBox(height: 20),
                  GridView(
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: constraints.maxWidth > 1000 ? 3 : 2,
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 20,
                        mainAxisExtent: 500),
                    children: [
                      for (var department in departments)
                        CustomCard(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SvgPicture.asset(
                                'assets/logo/department.svg',
                                colorFilter: ColorFilter.mode(
                                  Colors.grey.withOpacity(1.0), // Change this to your desired color and opacity
                                  BlendMode.srcIn,
                                ),
                                width: 200,
                                height: 200,
                              ),
                              const SizedBox(height: 10),
                              Text(
                                department['name'],
                                style: GoogleFonts.orbitron(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Column(
                                children: department['divisions']
                                    .map<Widget>((division) => Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                                          child: Text(
                                            division,
                                            style: GoogleFonts.orbitron(
                                              fontSize: 18,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ))
                                    .toList(),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
