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

class StructureWidget extends StatefulWidget {
  const StructureWidget({super.key});

  @override
  _StructureWidgetState createState() => _StructureWidgetState();
}

class _StructureWidgetState extends State<StructureWidget> {
  BuiltList<GetDepartments200ResponseInner> departments =
      BuiltList<GetDepartments200ResponseInner>();
  Map<int, bool> _dropdownOpen = {};
  Map<int, GlobalKey<FormState>> _formKeys = {};

  bool _isLoading = true;
  final corpStructureClient = corpApi.getStructureApi();

  Future<void> _initialize() async {
    try {
      final response = await corpStructureClient.getDepartments();
      if (response.data != null) {
        departments = response.data ?? departments;
      }
    } catch (error) {
      print(error);
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _initialize();
    for (int i = 0; i < departments.length; i++) {
      _formKeys[i] = GlobalKey<FormState>();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        color: cardBackgroundColor,
        child: CircularProgressIndicator(),
      );
    }

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

  void _showAddDepartmentDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String title = '';
        return AlertDialog(
          backgroundColor: cardBackgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          title: Text(
            'Add Department',
            style: TextStyle(
              color: primaryColor,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                onChanged: (value) {
                  title = value;
                },
                decoration: InputDecoration(hintText: "Title"),
              ),
            ],
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
                backgroundColor: WidgetStateProperty.all<Color>(primaryColor),
                padding: WidgetStateProperty.all<EdgeInsets>(
                    EdgeInsets.symmetric(horizontal: 20, vertical: 10)),
                shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              onPressed: () {
                _addDepartment(title);
                Navigator.of(context).pop();
              },
              child: Text(
                'Add',
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

  void _addDepartment(String title) async {
    final headers = await getAuthHeader();

    final CreateDepartmentRequest createDepartmentRequest =
        CreateDepartmentRequest((b) => b..title = title);
  }

  Widget _buildDepartmentList() {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: departments.length,
      itemBuilder: (context, index) {
        final department = departments[index];
        return _buildDepartmentItem(department);
      },
    );
  }

  Widget _buildDepartmentItem(GetDepartments200ResponseInner department) {
    int departmentIndex = departments.indexOf(department);
    _dropdownOpen.putIfAbsent(departmentIndex, () => false);
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
                  icon: Icon(_dropdownOpen[departmentIndex] == true
                      ? Icons.arrow_drop_up
                      : Icons.more_vert),
                  onPressed: () {
                    setState(() {
                      _dropdownOpen[departmentIndex] =
                          !_dropdownOpen[departmentIndex]!;
                    });
                  },
                ),
              ],
            ),
          ),
          if (_dropdownOpen[departmentIndex] == true)
            _buildDropdownContent(department),
        ],
      ),
    );
  }

  void _showDeleteDialog(GetDepartments200ResponseInner department) {
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
            'Deleting ${department.title.toString()}',
            style: TextStyle(
              color: primaryColor,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: TextField(
            onChanged: (value) {
              confirmation = value;
            },
            decoration: InputDecoration(hintText: "Enter title to delete"),
            keyboardType: TextInputType.number,
            obscureText: true,
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
                if (confirmation == department.title.toString()) {
                  _deleteDepartment(department);
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
                'Delete',
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

  void _deleteDepartment(GetDepartments200ResponseInner department) async {
    final headers = await getAuthHeader();

    final DeleteDepartmentRequest deleteDepartmentRequest =
        DeleteDepartmentRequest((b) => b..departmentTitle = department.title);
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
          _buildDetailRow('Heads', department.heads.toString()),
          _buildDetailRow('Proxys', department.proxys.toString()),
          SizedBox(height: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 5),
              ...department.divisions!.map((division) => ListTile(
                    leading: Icon(icons[department.logo] ?? Icons.error,
                        color: department.color != null
                            ? cssColorToColor(department.color!)
                            : Colors.grey),
                    title: Text(division.toString(),
                        style: TextStyle(
                          color: department.color != null
                              ? cssColorToColor(department.color!)
                              : Colors.grey,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        )),
                    subtitle: Text(department.motto.toString()),
                  )),
            ],
          ),
        ],
      ),
    );
  }

  void _updateDepartment(GetDepartments200ResponseInner department, Color color,
      String title, String motto, String logo) async {
    final headers = await getAuthHeader();

    final UpdateDepartmentRequest updateDepartmentRequest =
        UpdateDepartmentRequest((b) => b
          ..departmentTitle = department.title
          ..color = colorToCssColor(color)
          ..newTitle = title
          ..motto = motto
          ..logo = logo);
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          SizedBox(
            width: 120, // Adjust width as needed
            child: Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          Text(value),
        ],
      ),
    );
  }
}
