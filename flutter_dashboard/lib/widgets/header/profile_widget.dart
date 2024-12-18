import 'package:corp_api/corp_api.dart';
import 'package:flutter_dashboard/const/constant.dart';
import 'package:flutter_dashboard/widgets/dashboard_pages/influence_system/components/lifetime_influence_chart_widget.dart';
import 'package:flutter_dashboard/widgets/dashboard_pages/influence_system/components/influence_chart_widget.dart';
import 'package:flutter_dashboard/widgets/dashboard_pages/influence_system/components/weights_chart_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dashboard/model/current_user.dart' as current_user;
import 'package:flutter_dashboard/model/influence_account.dart' as infAccount;
import 'package:flutter_dashboard/main.dart';
import 'package:flutter_dashboard/util/css_color.dart';
import 'package:flutter_dashboard/util/icon_helper.dart';
import 'package:built_collection/built_collection.dart';

class ProfileWidget extends StatelessWidget {
  const ProfileWidget({super.key});

  @override
  Widget build(BuildContext context) {
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
                Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                    icon: Icon(Icons.refresh),
                    onPressed: () {
                      navigatorKey.currentState?.pushNamed('/dashboard');
                    },
                  ),
                ),
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
                if (current_user.status.value.cORPMember!)
                ValueListenableBuilder(
                    valueListenable: current_user.roles,
                    builder: (context, value, child) => Column(
                          children: [
                            Text(
                              'Roles',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 10),
                            if (current_user.roles.value
                                .where((role) => role.type == 'Leadership')
                                .toList()
                                .isNotEmpty) ...[
                              Text(
                                'Leadership',
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w500),
                              ),
                              SizedBox(height: 10),
                              Wrap(
                                spacing: 8.0,
                                runSpacing: 4.0,
                                children: [
                                  for (var role in current_user.roles.value
                                      .where(
                                          (role) => role.type == 'Leadership')
                                        .toList()
                                        ..sort((a, b) {
                                        if (a.department != null && b.department != null) {
                                          return a.department!.compareTo(b.department!);
                                        } else if (a.department != null) {
                                          return -1;
                                        } else if (b.department != null) {
                                          return 1;
                                        } else {
                                          return 0;
                                        }
                                        }))
                                    Chip(
                                      avatar: Icon(
                                          icons[role.logo] ?? Icons.error,
                                          color: role.color != null
                                              ? cssColorToColor(role.color!)
                                              : Colors.grey),
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
                            if (current_user.roles.value
                                .where((role) => role.type == 'Membership')
                                .toList()
                                .isNotEmpty) ...[
                              Text(
                                'Membership',
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w500),
                              ),
                              SizedBox(height: 10),
                              Wrap(
                                spacing: 8.0,
                                runSpacing: 4.0,
                                children: [
                                  for (var role in current_user.roles.value
                                      .where(
                                          (role) => role.type == 'Membership')
                                      .toList()..sort((a, b) {
                                        if (a.department != null && b.department != null) {
                                          return a.department!.compareTo(b.department!);
                                        } else if (a.department != null) {
                                          return -1;
                                        } else if (b.department != null) {
                                          return 1;
                                        } else {
                                          return 0;
                                        }
                                        }))
                                    Chip(
                                      avatar: Icon(
                                          icons[role.logo] ?? Icons.error,
                                          color: role.color != null
                                              ? cssColorToColor(role.color!)
                                              : Colors.grey),
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
                            if (current_user.roles.value.where((role) => role.type == 'Other').toList().isNotEmpty) ...[
                              Text(
                                'Others',
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w500),
                              ),
                              SizedBox(height: 10),
                              Wrap(
                                spacing: 8.0,
                                runSpacing: 4.0,
                                children: [
                                  for (var role in current_user.roles.value.where((role) => role.type == 'Other').toList()..sort((a, b) {
                                        if (a.department != null && b.department != null) {
                                          return a.department!.compareTo(b.department!);
                                        } else if (a.department != null) {
                                          return -1;
                                        } else if (b.department != null) {
                                          return 1;
                                        } else {
                                          return 0;
                                        }
                                        }))
                                    Chip(
                                      avatar: Icon(
                                          icons[role.logo] ?? Icons.error,
                                          color: role.color != null
                                              ? cssColorToColor(role.color!)
                                              : Colors.grey),
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
                            ]
                          ],
                        ))
                        else
                  Text(
                    'Must be a CORP member to see roles',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                SizedBox(height: 20),
                Divider(),
                SizedBox(height: 20),
                if (current_user.status.value.cORPMember!)
                  ValueListenableBuilder(
                      valueListenable: infAccount.profile,
                      builder: (context, value, child) => Container(
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
                                      value.rank ?? 'Unknown',
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
                                      (value.tribute ?? 0).toString(),
                                      style: const TextStyle(fontSize: 13),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          )))
                else
                  Text(
                    'Must be a CORP member to view Influence Account',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                SizedBox(height: 20),
                Divider(),
                SizedBox(height: 10),
                if (current_user.status.value.cORPMember!)
                ValueListenableBuilder(
                  valueListenable: infAccount.stats,
                  builder: (context, value, child) => Wrap(
                    spacing: 8.0,
                    runSpacing: 4.0,
                    children: <Widget>[
                      for (var department in value.departments ?? BuiltList<GetUserInfluenceStats200ResponseDepartmentsInner>())
                        Row(
                          mainAxisSize: MainAxisSize.min,
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
                              department.departmentTitle ?? "Unknown",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            )
                          ],
                        ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                if (current_user.status.value.cORPMember!)
                Divider(),
                SizedBox(height: 20),
                if (current_user.status.value.cORPMember!)
                SizedBox(
                    height: 200,
                    child: InfluenceChartWidget(
                        category: "Current_User", filter: "All")),
                SizedBox(height: 10),
                if (current_user.status.value.cORPMember!)
                Text(
                  'Influence',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 20),
                if (current_user.status.value.cORPMember!)
                Divider(),
                SizedBox(height: 20),
                if (current_user.status.value.cORPMember!)
                SizedBox(
                    height: 200,
                    child: WeightsChartWidget(
                        category: "Current_User", filter: "All")),
                SizedBox(height: 10),
                if (current_user.status.value.cORPMember!)
                Text(
                  'Weights',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 20),
                if (current_user.status.value.cORPMember!)
                Divider(),
                SizedBox(height: 20),
                if (current_user.status.value.cORPMember!)
                SizedBox(
                    height: 200,
                    child: LifetimeInfluenceChartWidget(
                        category: "Current_User", filter: "All")),
                SizedBox(height: 10),
                if (current_user.status.value.cORPMember!)
                Text(
                  'Lifetime Influence',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
