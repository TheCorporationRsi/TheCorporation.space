import 'package:flutter_dashboard/util/responsive.dart';
import 'package:flutter_dashboard/widgets/dashboard_pages/influence_system/components/influence_details_card.dart';
import 'package:flutter_dashboard/widgets/dashboard_pages/influence_system/components/transfer_card.dart';
import 'package:flutter_dashboard/widgets/dashboard_pages/influence_system/components/transfer_history_card.dart';
import 'package:flutter/material.dart';





class InfTransferWidget extends StatefulWidget {
  const InfTransferWidget({super.key});

  @override
  _InfTransferWidgetState createState() => _InfTransferWidgetState();
}

class _InfTransferWidgetState extends State<InfTransferWidget> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: Column(
          children: [
            const SizedBox(height: 18),
            const TransferCard(),
            const SizedBox(height: 18),
            const TransferHistoryCard(),
            
          ],
        ),
      ),
    );
  }
}
