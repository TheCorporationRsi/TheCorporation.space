import 'package:flutter_dashboard/const/constant.dart';
import 'package:flutter_dashboard/widgets/dashboard_pages/components/pie_chart_widget.dart';
import 'package:flutter_dashboard/widgets/dashboard_pages/components/scheduled_widget.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dashboard/model/current_user.dart' as current_user;

import 'package:flutter_dashboard/util/css_color.dart';

class ProfileWidget extends StatelessWidget {
  const ProfileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final leadershipRoles =
        current_user.roles.where((role) => role.type == 'Leadership').toList();
    final membershipRoles =
        current_user.roles.where((role) => role.type == 'Membership').toList();
    final otherRoles =
        current_user.roles.where((role) => role.type == 'Other').toList();
    return Container(
      decoration: const BoxDecoration(
        color: cardBackgroundColor,
      ),
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(current_user.profilePicture),
                ),
                SizedBox(height: 20),
                Text(
                  current_user.rsiHandle,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  current_user.rsiMoniker,
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 20),
                Divider(),
                SizedBox(height: 10),
                Text(
                  'Roles',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                if (leadershipRoles.isNotEmpty) ...[
                  Text(
                    'Leadership',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 10),
                  Wrap(
                    spacing: 8.0,
                    runSpacing: 4.0,
                    children: [
                      for (var role in leadershipRoles)
                        Chip(
                          avatar: Icon(
                            Icons.star,
                            color: role.color != null
                                ? cssColorToColor(role.color!)
                                : Colors.grey,
                          ),
                          label: Text(role.title ?? 'Unknown'),
                          shape: StadiumBorder(
                            side: BorderSide(
                              color: role.color != null
                                  ? cssColorToColor(role.color!)
                                  : Colors.grey,
                            ),
                          ),
                        ),
                    ],
                  ),
                  SizedBox(height: 10),
                ],
                if (membershipRoles.isNotEmpty) ...[
                  Text(
                    'Membership',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 10),
                  Wrap(
                    spacing: 8.0,
                    runSpacing: 4.0,
                    children: [
                      for (var role in membershipRoles)
                        Chip(
                          avatar: Icon(
                            Icons.star,
                            color: role.color != null
                                ? cssColorToColor(role.color!)
                                : Colors.grey,
                          ),
                          label: Text(role.title ?? 'Unknown'),
                          shape: StadiumBorder(
                            side: BorderSide(
                              color: role.color != null
                                  ? cssColorToColor(role.color!)
                                  : Colors.grey,
                            ),
                          ),
                        ),
                    ],
                  ),
                  SizedBox(height: 10),
                ],
                if (otherRoles.isNotEmpty) ...[
                  Text(
                    'Others',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 10),
                  Wrap(
                    spacing: 8.0,
                    runSpacing: 4.0,
                    children: [
                      for (var role in otherRoles)
                        Chip(
                          avatar: Icon(
                            Icons.star,
                            color: role.color != null
                                ? cssColorToColor(role.color!)
                                : Colors.grey,
                          ),
                          label: Text(role.title ?? 'Unknown'),
                          shape: StadiumBorder(
                            side: BorderSide(
                              color: role.color != null
                                  ? cssColorToColor(role.color!)
                                  : Colors.grey,
                            ),
                          ),
                        ),
                    ],
                  ),
                ] else ...[
                  Text(
                    'None',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                ],
                SizedBox(height: 20),
                Divider(),
                SizedBox(height: 20),
                if (current_user.status.cORPMember)
                  Container(
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(8.0),
                        ),
                        color: backgroundColor,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              children: [
                                Text(
                                  "Rank",
                                  style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  current_user.infAccount.rank ?? 'Unknown',
                                  style: const TextStyle(fontSize: 13),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Text(
                                  "Tribute",
                                  style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  (current_user.infAccount.tribute ?? 0)
                                      .toString(),
                                  style: const TextStyle(fontSize: 13),
                                ),
                              ],
                            )
                          ],
                        ),
                      ))
                else
                  Text(
                    'Must be a CORP member to view Influence Account',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                SizedBox(height: 20),
                Divider(),
                SizedBox(height: 10),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    for (var department in current_user.departments)
                      Row(
                        children: [
                          Container(
                            width: 16,
                            height: 16,
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              color: department.color != null
                                  ? cssColorToColor(department.color!)
                                  : Colors.grey,
                            ),
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          Text(
                            department.title ?? "Unknown",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                    SizedBox(
                      height: 18,
                    ),
                  ],
                ),
                SizedBox(
                  height: 200,
                  child: Stack(
                    children: [
                      PieChart(
                        PieChartData(
                          sectionsSpace: 0,
                          centerSpaceRadius: 70,
                          startDegreeOffset: -90,
                          sections: [
                            
                              PieChartSectionData(
                                color: backgroundColor,
                                value: 1,
                                radius: 25,
                                showTitle: false,
                              ),
                            
                              for (var department in current_user.departments)
                                PieChartSectionData(
                                  color: department.color != null
                                      ? cssColorToColor(department.color!)
                                      : Colors.grey,
                                  value: department.influence!.toDouble(),
                                  title: department.title,
                                  radius: 25,
                                  showTitle: false,
                                )
                          ],
                        ),
                      ),
                      Positioned.fill(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(height: defaultPadding),
                            Text(
                              current_user.infAccount.influence.toString(),
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium!
                                  .copyWith(
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
                Text(
                  'Influence',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 20),
                Divider(),
                SizedBox(height: 20),
                SizedBox(
                  height: 200,
                  child: Stack(
                    children: [
                      PieChart(
                        PieChartData(
                          sectionsSpace: 0,
                          centerSpaceRadius: 70,
                          startDegreeOffset: -90,
                          sections: [
                            if (current_user.departments.isEmpty)
                              PieChartSectionData(
                                color: backgroundColor,
                                value: 1,
                                radius: 25,
                                showTitle: false,
                              )
                            else
                              for (var department in current_user.departments)
                                PieChartSectionData(
                                  color: department.color != null
                                      ? cssColorToColor(department.color!)
                                      : Colors.grey,
                                  value: department.weight!.toDouble(),
                                  title: department.title,
                                  radius: 25,
                                  showTitle: false,
                                )
                          ],
                        ),
                      ),
                      Positioned.fill(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(height: defaultPadding),
                            Text(
                              "100",
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium!
                                  .copyWith(
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
                Text(
                  'Weights',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
