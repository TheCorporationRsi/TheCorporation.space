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
                  'RSI Handle: ${current_user.rsiHandle}',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  'RSI Moniker: ${current_user.rsiMoniker}',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 20),
                Divider(),
                SizedBox(height: 10),
                Text(
                  'Roles',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 10),
                if (leadershipRoles.isNotEmpty) ...[
                  Text(
                    'Leadership',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
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
                Text(
                  'Others',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                ),
                if (otherRoles.isNotEmpty) ...[
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
                                      fontSize: 11, color: Colors.grey),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  current_user.infAccount.rank ?? 'Unknown',
                                  style: const TextStyle(fontSize: 14),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Text(
                                  "Tribute",
                                  style: const TextStyle(
                                      fontSize: 11, color: Colors.grey),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  (current_user.infAccount.tribute ?? 0)
                                      .toString(),
                                  style: const TextStyle(fontSize: 14),
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
                              color: primaryColor,
                              value: 25,
                              showTitle: false,
                              radius: 25,
                            ),
                            PieChartSectionData(
                              color: const Color(0xFF26E5FF),
                              value: 20,
                              showTitle: false,
                              radius: 22,
                            ),
                            PieChartSectionData(
                              color: const Color(0xFFFFCF26),
                              value: 10,
                              showTitle: false,
                              radius: 19,
                            ),
                            PieChartSectionData(
                              color: const Color(0xFFEE2727),
                              value: 15,
                              showTitle: false,
                              title: 'test',
                              radius: 16,
                            ),
                            PieChartSectionData(
                              color: primaryColor.withOpacity(0.1),
                              value: 25,
                              showTitle: false,
                              radius: 13,
                            ),
                          ],
                        ),
                      ),
                      Positioned.fill(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(height: defaultPadding),
                            Text(
                              "4269",
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
