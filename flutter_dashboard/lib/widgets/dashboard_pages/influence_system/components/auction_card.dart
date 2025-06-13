import 'dart:async';
import 'package:flutter/material.dart';
import 'package:corp_api/corp_api.dart';
import 'package:flutter_dashboard/const/constant.dart';
import 'package:flutter_dashboard/model/information.dart';

class AuctionCard extends StatefulWidget {
  final ListAuctions200ResponseInner auction;
  final VoidCallback onBid;
  final VoidCallback? onDelete;
  final VoidCallback? onFinalize;

  const AuctionCard({
    Key? key,
    required this.auction,
    required this.onBid,
    this.onDelete,
    this.onFinalize,
  }) : super(key: key);

  @override
  State<AuctionCard> createState() => _AuctionCardState();
}

class _AuctionCardState extends State<AuctionCard> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    // Update every second for live countdown
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  String _formatTimeLeft(DateTime? endTime) {
    if (endTime == null) return "No end time";
    final now = DateTime.now().toUtc();
    final endUtc = endTime.isUtc ? endTime : endTime.toUtc();
    final diff = endUtc.difference(now);
    if (diff.isNegative) return "Ended";
    if (diff.inDays > 0) {
      return "${diff.inDays}d ${diff.inHours % 24}h left";
    } else if (diff.inHours > 0) {
      return "${diff.inHours}h ${diff.inMinutes % 60}m left";
    } else if (diff.inMinutes > 0) {
      return "${diff.inMinutes}m ${diff.inSeconds % 60}s left";
    } else {
      return "${diff.inSeconds}s left";
    }
  }

  @override
  Widget build(BuildContext context) {
    final auction = widget.auction;
    final onBid = widget.onBid;
    final onDelete = widget.onDelete;
    final onFinalize = widget.onFinalize;

    // Calculate progress for the progress bar
    double? progress;
    DateTime? start = auction.startTime;
    DateTime? end = auction.endTime;
    if (start != null && end != null) {
      final now = DateTime.now().toUtc();
      final startUtc = start.isUtc ? start : start.toUtc();
      final endUtc = end.isUtc ? end : end.toUtc();
      final total = endUtc.difference(startUtc).inSeconds;
      final elapsed = now.difference(startUtc).inSeconds;
      if (total > 0) {
        progress = (elapsed / total).clamp(0.0, 1.0);
      } else {
        progress = 1.0;
      }
    }

    // Determine auction status
    String status;
    Color statusColor;
    if (auction.closed == true) {
      status = "Closed";
      statusColor = Colors.redAccent;
    } else if (auction.endTime != null && auction.endTime!.toUtc().isBefore(DateTime.now().toUtc())) {
      status = "Item ready to collect";
      statusColor = Colors.amberAccent;
    } else {
      status = "Open";
      statusColor = Colors.greenAccent;
    }

    // Get department and division info
    final departmentTitle = auction.department;
    final divisionTitle = auction.division;

    // Helper to find color by title from ValueNotifier<BuiltList>
    Color? _findColor(ValueNotifier listNotifier, String? title) {
      if (title == null) return null;
      final items = listNotifier.value;
      final found = items.cast<dynamic>().firstWhere(
        (e) => e.title == title,
        orElse: () => null,
      );
      if (found != null && found.color != null) {
        try {
          // found.color is a hex string like "#FF0000"
          return Color(int.parse(found.color!.replaceFirst('#', '0xff')));
        } catch (_) {}
      }
      return null;
    }

    final departmentColor = _findColor(departments, departmentTitle) ?? Colors.blueGrey;
    final divisionColor = _findColor(divisions, divisionTitle) ?? Colors.teal;

    return Card(
      color: cardBackgroundColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "Status: ",
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.7),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: statusColor.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          status,
                          style: TextStyle(
                            color: statusColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    auction.title ?? '',
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    auction.description ?? '',
                    style: TextStyle(color: Colors.white.withOpacity(0.7)),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Icon(Icons.monetization_on, color: primaryColor, size: 20),
                      Text(
                        "${(auction.currentPrice?.toInt() ?? 0)} INF",
                        style: TextStyle(fontWeight: FontWeight.bold, color: primaryColor),
                      ),
                      const SizedBox(width: 8),
                      Text('by', style: TextStyle(color: Colors.white.withOpacity(0.7))),
                      const SizedBox(width: 4),
                      Chip(
                        label: Text(auction.highestBidder ?? '-'),
                        backgroundColor: secondaryColor.withOpacity(0.15),
                        labelStyle: TextStyle(color: secondaryColor),
                      ),
                    ],
                  ),
                  if (auction.itemHolder != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 6),
                      child: Row(
                        children: [
                          Icon(Icons.person, color: secondaryColor, size: 18),
                          const SizedBox(width: 4),
                          Text(
                            "Auctioned by: ${auction.itemHolder}",
                            style: TextStyle(color: secondaryColor.withOpacity(0.8), fontSize: 13),
                          ),
                        ],
                      ),
                    ),
                  if (auction.endTime != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Text(
                        "Time left: ${_formatTimeLeft(auction.endTime?.toUtc())}",
                        style: TextStyle(color: Colors.white.withOpacity(0.6), fontSize: 13),
                      ),
                    ),
                  if (progress != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: LinearProgressIndicator(
                        value: progress,
                        backgroundColor: Colors.white.withOpacity(0.1),
                        color: primaryColor,
                        minHeight: 6,
                      ),
                    ),
                  if (progress != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Text(
                        "Started: ${auction.startTime?.toLocal().toString().substring(0, 16) ?? '-'}",
                        style: TextStyle(color: Colors.white.withOpacity(0.4), fontSize: 12),
                      ),
                    ),
                  // Department/Division display
                  if (departmentTitle != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 4, bottom: 2),
                      child: Row(
                        children: [
                          Text(
                            "Department: ",
                            style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 13),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: departmentColor.withOpacity(0.15),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              departmentTitle,
                              style: TextStyle(
                                color: departmentColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  if (divisionTitle != null)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 2),
                      child: Row(
                        children: [
                          Text(
                            "Division: ",
                            style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 13),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: divisionColor.withOpacity(0.15),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              divisionTitle,
                              style: TextStyle(
                                color: divisionColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  if (departmentTitle == null && divisionTitle == null)
                    Padding(
                      padding: const EdgeInsets.only(top: 4, bottom: 2),
                      child: Row(
                        children: [
                          Chip(
                            avatar: Icon(Icons.public, color: Colors.blueAccent, size: 18),
                            label: Text(
                              "General type auction",
                              style: TextStyle(
                                color: Colors.blueAccent,
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),
                            ),
                            backgroundColor: Colors.blueAccent.withOpacity(0.10),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                              side: BorderSide(color: Colors.blueAccent.withOpacity(0.3)),
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
            Column(
              children: [
                // Only show finalize button if onFinalize is not null AND auction has ended
                if (onFinalize != null &&
                    auction.endTime != null &&
                    auction.endTime!.toUtc().isBefore(DateTime.now().toUtc()))
                  Tooltip(
                    message: "Finalize Auction",
                    child: IconButton(
                      icon: Icon(Icons.check_circle, color: Colors.greenAccent),
                      onPressed: onFinalize,
                    ),
                  ),
                if (onDelete != null)
                  Tooltip(
                    message: "Delete Auction",
                    child: IconButton(
                      icon: Icon(Icons.delete, color: Colors.redAccent),
                      onPressed: onDelete,
                    ),
                  ),
                if (auction.endTime == null || auction.endTime!.toUtc().isAfter(DateTime.now().toUtc()))
                  ElevatedButton.icon(
                    icon: const Icon(Icons.gavel),
                    label: const Text('Bid'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    onPressed: onBid,
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
