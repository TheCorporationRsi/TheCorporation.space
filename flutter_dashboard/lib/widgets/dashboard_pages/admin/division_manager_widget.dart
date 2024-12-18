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

class DivisionManagerWidget extends StatefulWidget {
  const DivisionManagerWidget({super.key});

  @override
  _DivisionManagerWidgetState createState() => _DivisionManagerWidgetState();
}

class _DivisionManagerWidgetState extends State<DivisionManagerWidget> {

  BuiltList<GetDivisions200ResponseInner> filteredItems =
      information.divisions.value;
  Map<int, bool> _dropdownOpen = {};
  Map<int, GlobalKey<FormState>> _formKeys = {};

  final corpStructureClient = corpApi.getStructureApi();
  final corpAdminClient = corpApi.getAdminApi();
  String _searchQuery = '';
  String _filter = 'All';
  String _selectedDepartmentFilter = 'All';



  void _applySearchAndFilter() {
    setState(() {
      filteredItems = information.divisions.value.where((division) {
        final matchesSearch = division.title
            .toString()
            .toLowerCase()
            .contains(_searchQuery.toLowerCase());
        final matchesDepartment = _selectedDepartmentFilter == 'All' ||
            division.departmentTitle == _selectedDepartmentFilter;
        return matchesSearch && matchesDepartment;
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
        valueListenable: information.divisions,
        builder: (context, value, child) => SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: Column(
          children: [
            SizedBox(height: 10),
            _buildFilterAndSearchSection(),
            SizedBox(height: 10),
            _buildDivisionList(),
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
              hintText: 'Search divisions...',
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
        DropdownButton<String>(
          value: _selectedDepartmentFilter,
          items: ['All', ...information.departments.value.map((d) => d.title!).toList()]
              .map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              _selectedDepartmentFilter = value!;
              _applySearchAndFilter();
            });
          },
        ),
        SizedBox(width: 10),
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () {
            _showAddDivisionDialog();
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

  void _showAddDivisionDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String title = '';
        String selectedDepartment = '';
        return AlertDialog(
          backgroundColor: cardBackgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          title: Text(
            'Add Division',
            style: TextStyle(
              color: primaryColor,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Select Department',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              DropdownButtonFormField<String>(
                value: selectedDepartment.isEmpty ? null : selectedDepartment,
                items: information.departments.value.map((department) {
                  return DropdownMenuItem<String>(
                    value: department.title,
                    child: Text(department.title!),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedDepartment = value!;
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Select Department',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
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
                _addDivision(title, selectedDepartment);
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

  void _addDivision(String title, String departmentTitle) async {
    final headers = await getAuthHeader();

    final CreateDivisionRequest createDivisionRequest =
        CreateDivisionRequest((b) => b
          ..title = title
          ..departmentTitle = departmentTitle);

    try {
      final response = await corpAdminClient.createDivision(
          headers: headers, createDivisionRequest: createDivisionRequest);

      if (response.data!.msg == "Division created") {
        information.update();
      }

      _applySearchAndFilter();
    } catch (error) {
      print(error);
    }
  }

  Widget _buildDivisionList() {
    if (filteredItems.isEmpty) {
      return Center(
        child: Text(
          'No divisions found.',
          style: TextStyle(fontSize: 18, color: Colors.grey),
        ),
      );
    }
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: filteredItems.length,
      itemBuilder: (context, index) {
        final division = filteredItems[index];
        return _buildDivisionItem(division, index);
      },
    );
  }

  Widget _buildDivisionItem(GetDivisions200ResponseInner division, int index) {
    _dropdownOpen.putIfAbsent(index, () => false);
    return Card(
      color: cardBackgroundColor,
      child: Column(
        children: [
          ListTile(
            leading: Icon(icons[division.logo] ?? Icons.error,
                color: division.color != null
                    ? cssColorToColor(division.color!)
                    : Colors.grey),
            title: Text(division.title.toString(),
                style: TextStyle(
                  color: division.color != null
                      ? cssColorToColor(division.color!)
                      : Colors.grey,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                )),
            subtitle: Text(division.motto.toString()),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    _showDeleteDialog(division);
                  },
                ),
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
            _buildDropdownContent(division),
        ],
      ),
    );
  }

  void _showDeleteDialog(GetDivisions200ResponseInner division) {
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
            'Deleting ${division.title.toString()}',
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
                if (confirmation == division.title.toString()) {
                  _deleteDivision(division);
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

  void _deleteDivision(GetDivisions200ResponseInner division) async {
    final headers = await getAuthHeader();

    final DeleteDivisionRequest deleteDivisionRequest =
        DeleteDivisionRequest((b) => b..divisionTitle = division.title);

    try {
      final response = await corpAdminClient.deleteDivision(
          headers: headers, deleteDivisionRequest: deleteDivisionRequest);

      if (response.data!.msg == "Division deleted") {
        await information.update();
        _applySearchAndFilter();
      }
    } catch (error) {
      print(error);
    }
  }

  Widget _buildDropdownContent(GetDivisions200ResponseInner division) {
    Color currentColor = division.color != null
        ? cssColorToColor(division.color!)
        : Colors.grey;
    int divisionIndex = information.divisions.value.indexOf(division);
    String title = division.title ?? '';
    String motto = division.motto ?? '';
    String description = division.description ?? '';
    String logo = division.logo ?? '';
    bool restricted = division.restricted ?? false;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildDetailRow('Leaders', division.leaders.toString()),
          _buildDetailRow('Proxys', division.proxys.toString()),
          SizedBox(height: 10),
            DropdownButtonFormField<bool>(
              value: restricted,
              items: [
                DropdownMenuItem(
                  value: true,
                  child: Text('Restricted'),
                ),
                DropdownMenuItem(
                  value: false,
                  child: Text('Unrestricted'),
                ),
              ],
              onChanged: (value) {
                  restricted = value!;
              },
              decoration: InputDecoration(
                labelText: 'Access Level',
                border: OutlineInputBorder(),
              ),
            ),
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
          IconInputWidget(initialIcon: logo, onIconChanged: (newLogo) {
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
            maxLines: 2,
            maxLength: 200,
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
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              onPressed: () {
                _updateDivision(division, title, motto, logo, description, restricted);
              },
              child: Text('Save'),
            ),
          ),
        ],
      ),
    );
  }

  void _updateDivision(GetDivisions200ResponseInner division,
      String title, String motto, String logo, String description, bool restricted) async {
    final headers = await getAuthHeader();

    final UpdateDivisionRequest updateDivisionRequest =
        UpdateDivisionRequest((b) => b
          ..divisionTitle = division.title
          ..newTitle = title
          ..motto = motto
          ..logo = logo
          ..description = description
          ..restricted = restricted
          );

    try {
      final response = await corpAdminClient.updateDivision(
          headers: headers, updateDivisionRequest: updateDivisionRequest);

      if (response.data!.msg == "Division updated") {
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
