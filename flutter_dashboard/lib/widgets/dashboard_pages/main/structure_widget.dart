import 'package:corp_api/corp_api.dart';
import 'package:flutter_dashboard/util/responsive.dart';
import 'package:flutter_dashboard/widgets/dashboard_pages/influence_system/components/influence_details_card.dart';
import 'package:flutter_dashboard/widgets/dashboard_pages/components/line_chart_card.dart';
import 'package:flutter/material.dart';
import 'package:built_collection/built_collection.dart';
import 'package:flutter_dashboard/const/constant.dart';
import 'package:flutter_dashboard/main.dart';
import 'package:flutter_dashboard/util/tooltip.dart';

import 'package:flutter_dashboard/util/css_color.dart';
import 'package:flutter_dashboard/util/icon_helper.dart';
import 'package:flutter_dashboard/model/information.dart' as information;
import 'package:flutter_dashboard/model/current_user.dart' as current_user;

class StructureWidget extends StatefulWidget {
  const StructureWidget({super.key});

  @override
  _StructureWidgetState createState() => _StructureWidgetState();
}

class _StructureWidgetState extends State<StructureWidget> {
  Map<int, bool> _dropdownOpen = {};

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: Column(
          children: [
            SizedBox(height: 10),
            _buildDepartmentList(),
          ],
        ),
      ),
    );
  }

  Widget _buildDepartmentList() {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: information.departments.value.length,
      itemBuilder: (context, index) {
        final department = information.departments.value[index];
        return _buildDepartmentItem(department, index);
      },
    );
  }

  Widget _buildDepartmentItem(
      GetDepartments200ResponseInner department, int index) {
    _dropdownOpen.putIfAbsent(index, () => false);
    return Card(
      color: cardBackgroundColor,
      child: Column(
        children: [
          ListTile(
            leading: Icon(icons[department.logo] ?? Icons.error,
                color: department.color != null
                    ? cssColorToColor(department.color!)
                    : Colors.grey),
            title: Text(department.title.toString(),
                style: TextStyle(
                  color: department.color != null
                      ? cssColorToColor(department.color!)
                      : Colors.grey,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                )),
            subtitle: Text(department.motto.toString()),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(_dropdownOpen[index] == true
                      ? Icons.arrow_drop_up
                      : Icons.more_vert),
                  onPressed: () {
                    setState(() {
                      _dropdownOpen[index] = !_dropdownOpen[index]!;
                    });
                  },
                ),
              ],
            ),
          ),
          if (_dropdownOpen[index] == true) _buildDropdownContent(department),
        ],
      ),
    );
  }

  Widget _buildDropdownContent(GetDepartments200ResponseInner department) {
    Color currentColor = department.color != null
        ? cssColorToColor(department.color!)
        : Colors.grey;
    String title = department.title ?? '';
    String motto = department.motto ?? '';
    String logo = department.logo ?? '';

    void _showLeaveDialog(String division_title) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          String confirmation = '';
          return AlertDialog(
            backgroundColor: cardBackgroundColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            title: Text(
              'Leaving ${division_title.toString()}',
              style: TextStyle(
                color: primaryColor,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            content: SizedBox(
              width: 300, // Set a fixed width
              height: 300, // Set a fixed height
              child: Column(
                children: [
                  Text(
                    'Warning',
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 20,
                    ),
                    softWrap: true,
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Leaving a divisions will downgrade your divisional influence, but you will keep your lifetime influence.',
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                    softWrap: true,
                  ),
                  SizedBox(height: 10),
                  TextField(
                    onChanged: (value) {
                      confirmation = value;
                    },
                    decoration:
                        InputDecoration(hintText: "Enter title to leave"),
                    keyboardType: TextInputType.number,
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                child: Text(
                  'Cancel',
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all<Color>(Colors.red),
                  padding: WidgetStateProperty.all<EdgeInsets>(
                      EdgeInsets.symmetric(horizontal: 20, vertical: 10)),
                  shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                onPressed: () {
                  if (confirmation == division_title) {
                    current_user.leaveDivision(division_title);
                    Navigator.of(context).pop();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Title does not match'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
                child: Text(
                  'Leave',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          );
        },
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(department.description!,
              style: TextStyle(fontWeight: FontWeight.normal, fontSize: 15)),
          SizedBox(height: 10),
          Text("Head:", style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          ...department.heads!.map(
            (head) => Chip(
              avatar: Icon(icons[department.logo] ?? Icons.error,
                  color: department.color != null
                      ? cssColorToColor(department.color!)
                      : Colors.grey),
              label: Text(head ?? 'Unknown'),
              shape: StadiumBorder(
                side: BorderSide(
                  color: department.color != null
                      ? cssColorToColor(department.color!)
                      : Colors.grey,
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
          Text("Proxy:", style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          ...department.proxys!.map(
            (proxy) => Chip(
              avatar: Icon(icons[department.logo] ?? Icons.error,
                  color: department.color != null
                      ? cssColorToColor(department.color!)
                      : Colors.grey),
              label: Text(proxy ?? 'Unknown'),
              shape: StadiumBorder(
                side: BorderSide(
                  color: department.color != null
                      ? cssColorToColor(department.color!)
                      : Colors.grey,
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ...department.divisions!.map(
                (division) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      leading: (division.restricted! ||  !current_user.status.value.cORPMember! )
                          ? null
                          : ValueListenableBuilder(
                              valueListenable: current_user.divisions,
                              builder: (context, value, child) => Tooltip(
                                  message: current_user.divisions.value.any(
                                          (element) =>
                                              element.title == division.title)
                                      ? "Leave"
                                      : "Join",
                                  child: IconButton(
                                    hoverColor: backgroundColor,
                                    icon: Icon(
                                      current_user.divisions.value.any(
                                              (element) =>
                                                  element.title ==
                                                  division.title)
                                          ? Icons.group_remove
                                          : Icons.group_add,
                                      color: current_user.divisions.value.any(
                                              (element) =>
                                                  element.title ==
                                                  division.title)
                                          ? Colors.red
                                          : Colors.green,
                                    ),
                                    onPressed: () {
                                      if (current_user.divisions.value.any(
                                          (element) =>
                                              element.title ==
                                              division.title)) {
                                        _showLeaveDialog(division.title!);
                                      } else {
                                        current_user
                                            .joinDivision(division.title!);
                                      }
                                    },
                                  ))),
                      title: Row(
                        children: [
                          Icon(
                            icons[division.logo] ?? Icons.error,
                            color: department.color != null
                                ? cssColorToColor(department.color!)
                                : Colors.grey,
                          ),
                          SizedBox(width: 10),
                          Text(
                            division.title.toString(),
                            style: TextStyle(
                              color: department.color != null
                                  ? cssColorToColor(department.color!)
                                  : Colors.grey,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: 10),
                          Text(
                            division.motto.toString(),
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 16,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 20, right: 20),
                      child: Row(
                        children: [
                          Text("Leader:",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          SizedBox(width: 10),
                          ...division.leaders!.map(
                            (head) => Chip(
                              avatar: Icon(icons[division.logo] ?? Icons.error,
                                  color: department.color != null
                                      ? cssColorToColor(department.color!)
                                      : Colors.grey),
                              label: Text(head ?? 'Unknown'),
                              shape: StadiumBorder(
                                side: BorderSide(
                                  color: department.color != null
                                      ? cssColorToColor(department.color!)
                                      : Colors.grey,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          Text("Proxy:",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          SizedBox(width: 10),
                          ...division.proxys!.map(
                            (proxy) => Chip(
                              avatar: Icon(icons[division.logo] ?? Icons.error,
                                  color: department.color != null
                                      ? cssColorToColor(department.color!)
                                      : Colors.grey),
                              label: Text(proxy ?? 'Unknown'),
                              shape: StadiumBorder(
                                side: BorderSide(
                                  color: department.color != null
                                      ? cssColorToColor(department.color!)
                                      : Colors.grey,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.all(20),
                        child: Text(division.description!,
                            style: TextStyle(
                                fontWeight: FontWeight.normal, fontSize: 15))),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
