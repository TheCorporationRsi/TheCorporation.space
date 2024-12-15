import 'package:corp_api/corp_api.dart';
import 'package:flutter_dashboard/const/constant.dart';
import 'package:flutter_dashboard/widgets/dashboard_pages/components/custom_card_widget.dart';
import 'package:flutter_dashboard/util/responsive.dart';
import 'package:flutter/material.dart';
import 'package:built_collection/built_collection.dart';
import 'package:flutter_dashboard/main.dart';
import 'package:flutter_dashboard/model/influence_account.dart' as infAccount;

class TransferHistoryCard extends StatefulWidget {
  const TransferHistoryCard({super.key});

  @override
  _TransferHistoryCardState createState() => _TransferHistoryCardState();
}

class _TransferHistoryCardState extends State<TransferHistoryCard> {
  final TextEditingController memberController = TextEditingController();
  final TextEditingController messageController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final GlobalKey _fieldKey = GlobalKey();

  GetCorporateers200ResponseInner? selectedUser;

  final corpInformationClient = corpApi.getInformationApi();

  int _currentPageSent = 0;
  int _currentPageReceived = 0;
  final int _itemsPerPage = 5;


  @override
  Widget build(BuildContext context) {

    return GridView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: Responsive.isMobile(context) ? 1 : 2,
          crossAxisSpacing: Responsive.isMobile(context) ? 12 : 15,
          mainAxisSpacing: 12.0,
          mainAxisExtent: 800),
      children: [
        ValueListenableBuilder(
            valueListenable: infAccount.sentTributeHistory,
            builder: (context, value, child) => CustomCard(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Sent Tributes',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 20),
                      Expanded(
                        child: value.isEmpty
                            ? Center(
                                child: Text('No tributes sent'),
                              )
                            : ListView.builder(
                                itemCount: value.length,
                                itemBuilder: (context, index) {
                                  return Container(
                                    padding: const EdgeInsets.all(
                                        5), // Reduced padding
                                    margin:
                                        const EdgeInsets.symmetric(vertical: 5),
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: ListTile(
                                      title: Text(
                                          'Tribute to ${value[index].receiver}'),
                                      subtitle: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                  'Amount: ${value[index].amount}'),
                                              SizedBox(width: 20),
                                              Text(
                                                  'Method: ${value[index].method}'),
                                            ],
                                          ),
                                          Text(
                                              'Message:\n${value[index].message}'),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            icon: Icon(Icons.arrow_back),
                            onPressed: _currentPageSent > 0
                                ? () async {
                                    await infAccount.updateSentTributeHistory(
                                        page: _currentPageSent - 1);
                                    setState(() {
                                      _currentPageSent--;
                                    });
                                  }
                                : null,
                          ),
                          Text('Page ${_currentPageSent + 1}'),
                          IconButton(
                            icon: Icon(Icons.arrow_forward),
                            onPressed: () async {
                              await infAccount.updateSentTributeHistory(
                                  page: _currentPageSent + 1);
                              setState(() {
                                _currentPageSent++;
                              });
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                )),
        ValueListenableBuilder(
            valueListenable: infAccount.receivedTributeHistory,
            builder: (context, value, child) => CustomCard(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Received Tributes',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 20),
                      Expanded(
                        child: value.isEmpty
                            ? Center(
                                child: Text('No tributes received'),
                              )
                            : ListView.builder(
                                itemCount:
                                    value.length,
                                itemBuilder: (context, index) {
                                  return Container(
                                    padding: const EdgeInsets.all(
                                        5), // Reduced padding
                                    margin:
                                        const EdgeInsets.symmetric(vertical: 5),
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: ListTile(
                                      title: Text(
                                          'Tribute from User ${value[index].amount}'),
                                      subtitle: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                  'Amount: ${value[index].amount}'),
                                              SizedBox(width: 20),
                                              Text(
                                                  'Method: ${value[index].method}'),
                                            ],
                                          ),
                                          Text(
                                              'Message:\n${value[index].message}'),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            icon: Icon(Icons.arrow_back),
                            onPressed: _currentPageReceived > 0
                                ? () async {
                                    await infAccount
                                        .updateReceivedTributeHistory(
                                            page: _currentPageSent - 1);
                                    setState(() {
                                      _currentPageReceived--;
                                    });
                                  }
                                : null,
                          ),
                          Text('Page ${_currentPageReceived + 1}'),
                          IconButton(
                            icon: Icon(Icons.arrow_forward),
                            onPressed: () async {
                              await infAccount.updateReceivedTributeHistory(
                                  page: _currentPageSent + 1);
                              setState(() {
                                _currentPageReceived++;
                              });
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                )),
      ],
    );
  }
}
