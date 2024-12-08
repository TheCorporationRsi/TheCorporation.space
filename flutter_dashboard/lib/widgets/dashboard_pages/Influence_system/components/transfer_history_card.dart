import 'package:corp_api/corp_api.dart';
import 'package:flutter_dashboard/const/constant.dart';
import 'package:flutter_dashboard/widgets/dashboard_pages/components/custom_card_widget.dart';
import 'package:flutter_dashboard/util/responsive.dart';
import 'package:flutter/material.dart';
import 'package:built_collection/built_collection.dart';
import 'package:flutter_dashboard/main.dart';

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

  BuiltList<GetCorporateers200ResponseInner> corporateers =
      BuiltList<GetCorporateers200ResponseInner>();
  final corpInformationClient = corpApi.getInformationApi();

  bool _isLoading = true;

  int _currentPageSent = 0;
  int _currentPageReceived = 0;
  final int _itemsPerPage = 4;

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
        mainAxisExtent: 550,
      ),
      children: [
        CustomCard(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Sent Transfers',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  itemCount: _itemsPerPage,
                  itemBuilder: (context, index) {
                    int actualIndex = _currentPageSent * _itemsPerPage + index;
                    return Container(
                      padding: const EdgeInsets.all(5), // Reduced padding
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: ListTile(
                        title: Text('Transfer to User $actualIndex'),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Amount: \$100'),
                            Text('Message: This is a sample message for sent transfer $actualIndex'),
                          ],
                        ),
                        trailing: Text('Date: 2023-10-01'),
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
                        ? () {
                            setState(() {
                              _currentPageSent--;
                            });
                          }
                        : null,
                  ),
                  Text('Page ${_currentPageSent + 1}'),
                  IconButton(
                    icon: Icon(Icons.arrow_forward),
                    onPressed: () {
                      setState(() {
                        _currentPageSent++;
                      });
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
        CustomCard(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Received Transfers',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  itemCount: _itemsPerPage,
                  itemBuilder: (context, index) {
                    int actualIndex = _currentPageReceived * _itemsPerPage + index;
                    return Container(
                      padding: const EdgeInsets.all(5), // Reduced padding
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: ListTile(
                        title: Text('Transfer from User $actualIndex'),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Amount: \$100'),
                            Text('Message: This is a sample message for received transfer $actualIndex'),
                          ],
                        ),
                        trailing: Text('Date: 2023-10-01'),
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
                        ? () {
                            setState(() {
                              _currentPageReceived--;
                            });
                          }
                        : null,
                  ),
                  Text('Page ${_currentPageReceived + 1}'),
                  IconButton(
                    icon: Icon(Icons.arrow_forward),
                    onPressed: () {
                      setState(() {
                        _currentPageReceived++;
                      });
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}