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


class DepartmentManagerWidget extends StatefulWidget {
  const DepartmentManagerWidget({super.key});

  @override
  _DepartmentManagerWidgetState createState() =>
      _DepartmentManagerWidgetState();
}

class _DepartmentManagerWidgetState extends State<DepartmentManagerWidget> {
  BuiltList<GetDepartments200ResponseInner> filteredItems =
      information.departments.value;
  Map<int, bool> _dropdownOpen = {};
  Map<int, GlobalKey<FormState>> _formKeys = {};

  final corpStructureClient = corpApi.getStructureApi();
  final corpAdminClient = corpApi.getAdminApi();
  String _searchQuery = '';
  String _filter = 'All';

  void _applySearchAndFilter() {
    setState(() {
      filteredItems = information.departments.value.where((department) {
        final matchesSearch = department.title
            .toString()
            .toLowerCase()
            .contains(_searchQuery.toLowerCase());
        return matchesSearch;
      }).toBuiltList();
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: information.departments,
        builder: (context, value, child) => SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: Column(
                  children: [
                    SizedBox(height: 10),
                    _buildFilterAndSearchSection(),
                    SizedBox(height: 10),
                    _buildDepartmentList(),
                  ],
                ),
              ),
            ));
  }

  Widget _buildFilterAndSearchSection() {
    return Row(
      children: [
        Expanded(
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Search departments...',
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onChanged: (value) {
              _searchQuery = value;
              _applySearchAndFilter();
            },
          ),
        ),
        SizedBox(width: 10),
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () {
            _showAddDepartmentDialog();
          },
        ),
        SizedBox(width: 10),
        IconButton(
          icon: Icon(Icons.refresh),
          onPressed: () async {
            await information.update();
          },
        ),
      ],
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

    try {
      final response = await corpAdminClient.createDepartment(
          headers: headers, createDepartmentRequest: createDepartmentRequest);

      if (response.data!.msg == "Department created") {
        await information.update();
      }

      _applySearchAndFilter();
    } catch (error) {
      print(error);
    }

    setState(() {
      _applySearchAndFilter();
    });
  }

  Widget _buildDepartmentList() {
    if (filteredItems.isEmpty) {
      return Center(
        child: Text(
          'No departments found.',
          style: TextStyle(fontSize: 18, color: Colors.grey),
        ),
      );
    }
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: filteredItems.length,
      itemBuilder: (context, index) {
        final department = filteredItems[index];
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
                  icon: Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    _showDeleteDialog(department);
                  },
                ),
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

    try {
      final response = await corpAdminClient.deleteDepartment(
          headers: headers, deleteDepartmentRequest: deleteDepartmentRequest);

      if (response.data!.msg == "Department deleted") {
        await information.update();
        _applySearchAndFilter();
      }
    } catch (error) {
      print(error);
    }
  }

  Widget _buildDropdownContent(GetDepartments200ResponseInner department) {
    Color currentColor = department.color != null
        ? cssColorToColor(department.color!)
        : Colors.grey;
    String title = department.title ?? '';
    String motto = department.motto ?? '';
    String description = department.description ?? '';
    String logo = department.logo ?? '';

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildDetailRow('Heads', department.heads.toString()),
          _buildDetailRow('Proxys', department.proxys.toString()),
          SizedBox(height: 10),
          TextField(
            controller: TextEditingController(text: title),
            onChanged: (value) {
              title = value;
            },
            decoration: InputDecoration(
              labelText: 'Title',
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 10),
          IconInputWidget(
              initialIcon: logo,
              onIconChanged: (newLogo) {
                logo = newLogo;
              }),
          SizedBox(height: 10),
          TextField(
            controller: TextEditingController(text: motto),
            onChanged: (value) {
              motto = value;
            },
            decoration: InputDecoration(
              labelText: 'Motto',
              border: OutlineInputBorder(),
            ),
            maxLength: 200,
            maxLines: 2,
          ),
          SizedBox(height: 10),
          TextField(
            controller: TextEditingController(text: description),
            onChanged: (value) {
              description = value;
            },
            decoration: InputDecoration(
              labelText: 'Description',
              border: OutlineInputBorder(),
            ),
            maxLines: 5,
            maxLength: 500,
          ),
          SizedBox(height: 10),
          ColorInputWidget(
            initialColor: currentColor,
            onColorChanged: (color) {
              currentColor = color;
            },
          ),
          SizedBox(height: 10),
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              onPressed: () {
                _updateDepartment(
                    department, currentColor, title, motto, logo, description);
              },
              child: Text('Save'),
            ),
          ),
        ],
      ),
    );
  }

  void _updateDepartment(GetDepartments200ResponseInner department, Color color,
      String title, String motto, String logo, String description) async {
    final headers = await getAuthHeader();

    final UpdateDepartmentRequest updateDepartmentRequest =
        UpdateDepartmentRequest((b) => b
          ..departmentTitle = department.title
          ..color = colorToCssColor(color)
          ..newTitle = title
          ..motto = motto
          ..logo = logo
          ..description = description);

    try {
      final response = await corpAdminClient.updateDepartment(
          headers: headers, updateDepartmentRequest: updateDepartmentRequest);

      if (response.data!.msg == "Department updated") {
        await information.update();
      }

      _applySearchAndFilter();
    } catch (error) {
      print(error);
    }

    setState(() {
      _applySearchAndFilter();
    });
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
