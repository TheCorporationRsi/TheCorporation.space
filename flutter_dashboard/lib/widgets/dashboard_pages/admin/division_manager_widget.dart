import 'package:corp_api/corp_api.dart';
import 'package:flutter_dashboard/util/responsive.dart';
import 'package:flutter_dashboard/widgets/dashboard_pages/Influence_system/components/influence_details_card.dart';
import 'package:flutter_dashboard/widgets/dashboard_pages/components/line_chart_card.dart';
import 'package:flutter/material.dart';
import 'package:built_collection/built_collection.dart';
import 'package:flutter_dashboard/const/constant.dart';
import 'package:flutter_dashboard/main.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import 'package:flutter_dashboard/util/css_color.dart';

class DivisionManagerWidget extends StatefulWidget {
  const DivisionManagerWidget({super.key});

  @override
  _DivisionManagerWidgetState createState() => _DivisionManagerWidgetState();
}

class _DivisionManagerWidgetState extends State<DivisionManagerWidget> {
  BuiltList<GetDivisions200ResponseInner> divisions =
      BuiltList<GetDivisions200ResponseInner>();
  BuiltList<GetDepartments200ResponseInner> departments =
      BuiltList<GetDepartments200ResponseInner>();
  BuiltList<GetDivisions200ResponseInner> filteredItems =
      BuiltList<GetDivisions200ResponseInner>();
  Map<int, bool> _dropdownOpen = {};
  Map<int, GlobalKey<FormState>> _formKeys = {};

  bool _isLoading = true;
  final corpStructureClient = corpApi.getStructureApi();
  final corpAdminClient = corpApi.getAdminApi();
  String _searchQuery = '';
  String _filter = 'All';

  Future<void> _initialize() async {
    try {
      final response = await corpStructureClient.getDivisions();
      if (response.data != null) {
        divisions = response.data ?? divisions;
        _applySearchAndFilter();
      }
    } catch (error) {
      print(error);
    }

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

  void _applySearchAndFilter() {
    setState(() {
      filteredItems = divisions.where((division) {
        final matchesSearch = division.title
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
    _initialize();
    for (int i = 0; i < divisions.length; i++) {
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
            _buildFilterAndSearchSection(),
            SizedBox(height: 10),
            _buildUserList(),
          ],
        ),
      ),
    );
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
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () {
            _showAddDivisionDialog();
          },
        ),
        SizedBox(width: 10),
        IconButton(
          icon: Icon(Icons.refresh),
          onPressed: () {
            setState(() {
              _isLoading = true;
            });
            _initialize();
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
                items: departments.map((department) {
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
        setState(() {
          _isLoading = true;
        });
        _initialize();
      }

      _applySearchAndFilter();
    } catch (error) {
      print(error);
    }

    setState(() {
      _applySearchAndFilter();
    });
  }

  Widget _buildUserList() {
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
        return _buildDivisionItem(division);
      },
    );
  }

  Widget _buildDivisionItem(GetDivisions200ResponseInner division) {
    int divisionIndex = divisions.indexOf(division);
    _dropdownOpen.putIfAbsent(divisionIndex, () => false);
    return Card(
      color: cardBackgroundColor,
      child: Column(
        children: [
          ListTile(
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
                  icon: Icon(_dropdownOpen[divisionIndex] == true
                      ? Icons.arrow_drop_up
                      : Icons.more_vert),
                  onPressed: () {
                    setState(() {
                      _dropdownOpen[divisionIndex] =
                          !_dropdownOpen[divisionIndex]!;
                    });
                  },
                ),
              ],
            ),
          ),
          if (_dropdownOpen[divisionIndex] == true)
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
        setState(() {
          divisions = divisions.rebuild((b) => b.remove(division));
          _applySearchAndFilter();
        });
      }
    } catch (error) {
      print(error);
    }
  }

  Widget _buildDropdownContent(GetDivisions200ResponseInner division) {
    Color currentColor = division.color != null
        ? cssColorToColor(division.color!)
        : Colors.grey;
    int divisionIndex = divisions.indexOf(division);
    String title = division.title ?? '';
    String motto = division.motto ?? '';

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildDetailRow('Leaders', division.leaders.toString()),
          _buildDetailRow('Proxys', division.proxys.toString()),
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
          TextField(
            controller: TextEditingController(text: motto),
            onChanged: (value) {
              motto = value;
            },
            decoration: InputDecoration(
              labelText: 'Motto',
              border: OutlineInputBorder(),
            ),
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
                _updateDivision(division, currentColor, title, motto);
              },
              child: Text('Save'),
            ),
          ),
        ],
      ),
    );
  }

  void _updateDivision(GetDivisions200ResponseInner division, Color color,
      String title, String motto) async {
    final headers = await getAuthHeader();

    final UpdateDivisionRequest updateDivisionRequest =
        UpdateDivisionRequest((b) => b
          ..divisionTitle = division.title
          ..color = colorToCssColor(color)
          ..newTitle = title
          ..motto = motto);

    try {
      final response = await corpAdminClient.updateDivision(
          headers: headers, updateDivisionRequest: updateDivisionRequest);

      if (response.data!.msg == "Division updated") {
        setState(() {
          _isLoading = true;
        });
        _initialize();
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
