import 'package:corp_api/corp_api.dart';
import 'package:flutter_dashboard/const/constant.dart';
import 'package:flutter_dashboard/widgets/dashboard_pages/components/custom_card_widget.dart';
import 'package:flutter_dashboard/util/responsive.dart';
import 'package:flutter/material.dart';
import 'package:built_collection/built_collection.dart';
import 'package:flutter_dashboard/main.dart';

class TransferCard extends StatefulWidget {
  const TransferCard({super.key});

  @override
  _TransferCardState createState() => _TransferCardState();
}

class _TransferCardState extends State<TransferCard> {
  final TextEditingController memberController = TextEditingController();
  final TextEditingController messageController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final GlobalKey _fieldKey = GlobalKey();

  GetCorporateers200ResponseInner? selectedUser;

  BuiltList<GetCorporateers200ResponseInner> corporateers =
      BuiltList<GetCorporateers200ResponseInner>();
  final corpInformationClient = corpApi.getInformationApi();

  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async {
    try {
      final response = await corpInformationClient.getCorporateers();
      if (response.data != null) {
        corporateers = response.data ?? corporateers;
      }
    } catch (error) {
      print(error);
    }

    setState(() {
      _isLoading = false;
    });
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

    return GridView(
        shrinkWrap: true,
        physics: const ScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: Responsive.isMobile(context) ? 1 : 2,
          crossAxisSpacing: Responsive.isMobile(context) ? 12 : 15,
          mainAxisSpacing: 12.0,
        ),
        children: [
          CustomCard(
            padding: const EdgeInsets.all(20), // Change color to blue
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Transfer Form',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),
                Autocomplete<String>(
                  optionsBuilder: (TextEditingValue textEditingValue) {
                    // Replace with your member list
                    if (textEditingValue.text.isEmpty) {
                      return const Iterable<String>.empty();
                    }
                    return corporateers
                        .where((GetCorporateers200ResponseInner user) {
                      return user.rSIHandle!
                          .toLowerCase()
                          .contains(textEditingValue.text.toLowerCase());
                    }).map((user) => user.rSIHandle!);
                  },
                  onSelected: (String selection) {
                    memberController.text = selection;
                  },
                  fieldViewBuilder: (BuildContext context,
                      TextEditingController fieldTextEditingController,
                      FocusNode fieldFocusNode,
                      VoidCallback onFieldSubmitted) {
                    return TextField(
                      key: _fieldKey,
                      controller: fieldTextEditingController,
                      focusNode: fieldFocusNode,
                      onChanged: (value) {
                        for (var user in corporateers) {
                          if (user.rSIHandle!.toLowerCase() ==
                              value.toLowerCase()) {
                            setState(() {
                              selectedUser = user;
                            });

                            break;
                          } else {
                            setState(() {
                              selectedUser = null;
                            });
                          }
                        }
                        print(selectedUser);
                      },
                      decoration: InputDecoration(
                        labelText: 'Select Member',
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                              color:
                                  primaryColor), // Change border color to blue
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color:
                                  primaryColor), // Change border color to blue
                        ),
                        labelStyle: TextStyle(color: Colors.grey),
                        floatingLabelStyle: TextStyle(
                            color:
                                secondaryColor), // Change label color to blue on focus
                      ),
                    );
                  },
                  optionsViewBuilder: (BuildContext context,
                      AutocompleteOnSelected<String> onSelected,
                      Iterable<String> options) {
                    final RenderBox renderBox = _fieldKey.currentContext!
                        .findRenderObject() as RenderBox;
                    final double width = renderBox.size.width;
                    final double maxHeight = options.length.toDouble() * 50;
                    return Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.vertical(
                            bottom: Radius.circular(20),
                          ),
                          color: backgroundColor,
                        ),
                        constraints: BoxConstraints(
                          maxHeight: maxHeight,
                        ),
                        width: width, // Adjust the width as needed
                        child: ListView.builder(
                          padding: EdgeInsets.zero,
                          itemCount: options.length,
                          itemBuilder: (BuildContext context, int index) {
                            final String option = options.elementAt(index);
                            return GestureDetector(
                              onTap: () {
                                onSelected(option);
                                for (var user in corporateers) {
                                  if (user.rSIHandle!.toLowerCase() ==
                                      option.toLowerCase()) {
                                    setState(() {
                                      selectedUser = user;
                                    });

                                    break;
                                  } else {
                                    setState(() {
                                      selectedUser = null;
                                    });
                                  }
                                }
                                print(selectedUser);
                              },
                              child: ListTile(
                                title: Text(option),
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(height: 20),
                TextField(
                  controller: amountController,
                  decoration: InputDecoration(
                    labelText: 'Amount',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: primaryColor), // Change border color to blue
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: primaryColor), // Change border color to blue
                    ),
                    labelStyle: TextStyle(color: Colors.grey),
                    floatingLabelStyle: TextStyle(
                        color:
                            secondaryColor), // Change label color to blue on focus
                  ),
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 20),
                TextField(
                  controller: messageController,
                  decoration: InputDecoration(
                    labelText: 'Message',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: primaryColor), // Change border color to blue
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: primaryColor), // Change border color to blue
                    ),
                    labelStyle: TextStyle(color: Colors.grey),
                    floatingLabelStyle: TextStyle(
                        color:
                            secondaryColor), // Change label color to blue on focus
                  ),
                ),
                SizedBox(height: 20),
                Expanded(
                  child: Align(
                    alignment: Alignment.topRight,
                    child: ElevatedButton(
                      onPressed: () {
                        // Handle send action
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor, // Use primary color
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(0), // Make it square
                        ),
                        padding: EdgeInsets.symmetric(
                            horizontal: 24, vertical: 16), // Make it bigger
                      ),
                      child: Text(
                        'Send',
                        style: TextStyle(
                            color: secondaryColor,
                            fontSize: 20), // Use secondary color for text
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          CustomCard(
            padding: const EdgeInsets.all(20), // Change color to blue
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Corporateer Details',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),
                if (selectedUser == null)
                  Text(
                    'No user selected',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                if (selectedUser != null)
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: cardBackgroundColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: NetworkImage(
                          'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png',
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Name: ${selectedUser!.rSIHandle}',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        'Amount: ${amountController.text}',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        'Message: ${messageController.text}',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
        ]);
  }
}
