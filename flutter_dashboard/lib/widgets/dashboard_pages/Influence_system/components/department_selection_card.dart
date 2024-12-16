import 'package:flutter_dashboard/const/constant.dart';
import 'package:flutter_dashboard/util/responsive.dart';
import 'package:flutter_dashboard/widgets/dashboard_pages/components/custom_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

import 'package:flutter_dashboard/util/css_color.dart';
import 'package:flutter_dashboard/model/influence_account.dart' as infAccount;

class DepartmentSelectionCard extends StatelessWidget {
  final ValueChanged<String?>? onChanged;

  const DepartmentSelectionCard({super.key, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: CustomCard(
        padding: const EdgeInsets.all(20.0),
        child: ValueListenableBuilder(
            valueListenable: infAccount.stats,
            builder: (context, value, child) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                  
                  DropdownButtonFormField<String>(
                    isExpanded: false,
                    value: "All",
                    decoration: InputDecoration(
                      labelText: "Department",
                      labelStyle: const TextStyle(
                        color: secondaryColor,
                      ),
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: primaryColor,
                        ),
                      ),
                    ), 
                    onChanged: onChanged,
                    items: [
                      DropdownMenuItem<String>(
                        value: "All",
                        child: Text("All"),
                      ),
                      ...value.departments!
                          .map<DropdownMenuItem<String>>((value) {
                        return DropdownMenuItem<String>(
                          value: value.departmentTitle,
                          onTap: () {
                            print("Tapped");
                          },
                          child: Text(
                            value.departmentTitle!,
                            style:
                                TextStyle(color: cssColorToColor(value.color!)),
                          ),
                        );
                      }).toList(),
                    ],
                  ),
                ])),
      ),
    );
  }
}
