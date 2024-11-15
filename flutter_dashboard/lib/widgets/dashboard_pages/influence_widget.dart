import 'package:flutter_dashboard/util/responsive.dart';
import 'package:flutter_dashboard/widgets/dashboard_pages/components/activity_details_card.dart';
import 'package:flutter_dashboard/widgets/dashboard_pages/components/bar_graph_widget.dart';
import 'package:flutter_dashboard/widgets/dashboard_pages/components/line_chart_card.dart';
import 'package:flutter_dashboard/widgets/header/profile_widget.dart';
import 'package:flutter/material.dart';

class InfluenceWidget extends StatelessWidget {
  const InfluenceWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: Column(
          children: [
            const SizedBox(height: 10),
            const ActivityDetailsCard(),
            const SizedBox(height: 18),
            const LineChartCard(),
            const SizedBox(height: 18),
            if (Responsive.isTablet(context)) const ProfileWidget(),
            const SizedBox(height: 18),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/login');
              },
              child: const Text('Go to Login'),
            ),
          ],
        ),
      ),
    );
  }
}
