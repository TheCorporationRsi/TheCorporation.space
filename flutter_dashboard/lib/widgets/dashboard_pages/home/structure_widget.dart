import 'package:corp_api/corp_api.dart';
import 'package:flutter_dashboard/util/responsive.dart';
import 'package:flutter_dashboard/widgets/dashboard_pages/Influence_system/components/influence_details_card.dart';
import 'package:flutter_dashboard/widgets/dashboard_pages/components/line_chart_card.dart';
import 'package:flutter/material.dart';
import 'package:built_collection/built_collection.dart';
import 'package:flutter_dashboard/const/constant.dart';
import 'package:flutter_dashboard/main.dart';

import 'package:flutter_dashboard/util/css_color.dart';
import 'package:flutter_dashboard/util/icon_helper.dart';
import 'package:flutter_dashboard/model/information.dart' as information;

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

  Widget _buildDepartmentItem(GetDepartments200ResponseInner department, int index) {
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
                      _dropdownOpen[index] =
                          !_dropdownOpen[index]!;
                    });
                  },
                ),
              ],
            ),
          ),
          if (_dropdownOpen[index] == true)
            _buildDropdownContent(department),
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
                      leading: Icon(
                        icons[division.logo] ?? Icons.error,
                        color: department.color != null
                            ? cssColorToColor(department.color!)
                            : Colors.grey,
                      ),
                      title: Row(
                        children: [
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
                              avatar: Icon(
                                  icons[division.logo] ?? Icons.error,
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
                              avatar: Icon(
                                  icons[division.logo] ?? Icons.error,
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
