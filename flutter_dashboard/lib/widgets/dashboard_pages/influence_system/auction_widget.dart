import 'package:flutter/material.dart';
import 'package:flutter_dashboard/const/constant.dart';
import 'package:corp_api/corp_api.dart';
// Add this import for the shared API client:
import 'package:flutter_dashboard/main.dart';

class AuctionItem {
  final String id;
  final String title;
  final String description;
  final double currentPrice;
  final String highestBidder;
  final DateTime? endTime;

  AuctionItem({
    required this.id,
    required this.title,
    required this.description,
    required this.currentPrice,
    required this.highestBidder,
    required this.endTime,
  });

  // Factory to convert from API model
  factory AuctionItem.fromApi(ListAuctions200ResponseInner api) {
    return AuctionItem(
      id: api.id ?? '',
      title: api.title ?? '',
      description: api.description ?? '',
      currentPrice: api.currentPrice?.toDouble() ?? 0,
      highestBidder: api.highestBidder ?? '',
      endTime: api.endTime,
    );
  }
}

class AuctionWidget extends StatefulWidget {
  const AuctionWidget({super.key});

  @override
  State<AuctionWidget> createState() => _AuctionWidgetState();
}

class _AuctionWidgetState extends State<AuctionWidget> {
  List<AuctionItem> allItems = [];
  bool isLoading = false;
  String? error;
  String filter = '';
  final TextEditingController _filterController = TextEditingController();

  // Use the shared API client as in ranks_widget.dart
  late final InfluenceSystemApi api = corpApi.getInfluenceSystemApi();

  @override
  void initState() {
    super.initState();
    _fetchAuctions();
  }

  Future<void> _fetchAuctions() async {
    setState(() {
      isLoading = true;
      error = null;
    });
    try {
      final response = await api.listAuctions();
      final items = response.data ?? [];
      setState(() {
        allItems = (items as List)
            .map((e) => AuctionItem.fromApi(e as ListAuctions200ResponseInner))
            .toList();
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        error = 'Failed to load auctions';
        isLoading = false;
      });
    }
  }

  Future<void> _placeBid(AuctionItem item) async {
    final TextEditingController bidController = TextEditingController(
      text: (item.currentPrice + 10).toStringAsFixed(2),
    );
    void addToBid(double amount) {
      final current = double.tryParse(bidController.text) ?? item.currentPrice;
      bidController.text = (current + amount).toStringAsFixed(2);
    }

    bool isSubmitting = false;
    String? bidError;

    await showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          backgroundColor: cardBackgroundColor,
          title: Text(
            'Place a Bid for "${item.title}"',
            style: const TextStyle(color: Colors.white),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Current highest: ${item.currentPrice.toStringAsFixed(2)} INF by ${item.highestBidder}',
                style: TextStyle(
                  color: primaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: bidController,
                      keyboardType: TextInputType.numberWithOptions(decimal: true),
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        labelText: 'Your Bid (INF)',
                        labelStyle: TextStyle(
                          color: secondaryColor,
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: primaryColor,
                          ),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: secondaryColor.withOpacity(0.5),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Column(
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(40, 32),
                          padding: EdgeInsets.zero,
                          backgroundColor: secondaryColor.withOpacity(0.15),
                          foregroundColor: secondaryColor,
                          elevation: 0,
                        ),
                        onPressed: () => setDialogState(() => addToBid(10)),
                        child: const Text('+10'),
                      ),
                      const SizedBox(height: 4),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(40, 32),
                          padding: EdgeInsets.zero,
                          backgroundColor: secondaryColor.withOpacity(0.15),
                          foregroundColor: secondaryColor,
                          elevation: 0,
                        ),
                        onPressed: () => setDialogState(() => addToBid(100)),
                        child: const Text('+100'),
                      ),
                    ],
                  ),
                ],
              ),
              if (bidError != null)
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(
                    bidError!,
                    style: const TextStyle(color: Colors.redAccent),
                  ),
                ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'Cancel',
                style: TextStyle(color: secondaryColor),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                foregroundColor: Colors.white,
              ),
              onPressed: isSubmitting
                  ? null
                  : () async {
                      final bid = double.tryParse(bidController.text);
                      if (bid == null || bid <= item.currentPrice) {
                        setDialogState(() {
                          bidError = "Bid must be higher than current highest.";
                        });
                        return;
                      }
                      setDialogState(() {
                        isSubmitting = true;
                        bidError = null;
                      });
                      try {
                        await api.placeBet(
                          placeBetRequest: PlaceBetRequest((b) => b
                            ..auctionId = item.id
                            ..amount = bid.toInt()),
                        );
                        Navigator.pop(context);
                        _fetchAuctions();
                      } catch (e) {
                        setDialogState(() {
                          bidError = "Failed to place bid.";
                          isSubmitting = false;
                        });
                      }
                    },
              child: isSubmitting
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                    )
                  : const Text('Place Bid'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final filteredItems = allItems
        .where((item) =>
            (item.title.toLowerCase().contains(filter.toLowerCase()) ||
             item.description.toLowerCase().contains(filter.toLowerCase()))
        )
        .toList();

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: Column(
          children: [
            const SizedBox(height: 18),
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              color: cardBackgroundColor,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Icon(Icons.search, color: primaryColor),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TextField(
                        controller: _filterController,
                        decoration: InputDecoration(
                          hintText: 'Filter items...',
                          border: InputBorder.none,
                          hintStyle: TextStyle(
                            color: Colors.white.withOpacity(0.5),
                          ),
                        ),
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                        onChanged: (val) {
                          setState(() {
                            filter = val;
                          });
                        },
                      ),
                    ),
                    if (filter.isNotEmpty)
                      IconButton(
                        icon: Icon(Icons.clear, color: secondaryColor),
                        onPressed: () {
                          _filterController.clear();
                          setState(() {
                            filter = '';
                          });
                        },
                      ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 18),
            if (isLoading)
              const Padding(
                padding: EdgeInsets.all(32),
                child: CircularProgressIndicator(),
              ),
            if (error != null)
              Padding(
                padding: const EdgeInsets.all(32),
                child: Text(
                  error!,
                  style: const TextStyle(color: Colors.redAccent, fontSize: 16),
                ),
              ),
            if (!isLoading && error == null)
              ...[
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: filteredItems.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 16),
                  itemBuilder: (context, idx) {
                    final item = filteredItems[idx];
                    return Card(
                      elevation: 3,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      color: cardBackgroundColor,
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.title,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    item.description,
                                    style: TextStyle(
                                      color: Colors.white.withOpacity(0.7),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    children: [
                                      Icon(Icons.monetization_on,
                                          color: primaryColor, size: 20),
                                      Text(
                                        "${item.currentPrice.toStringAsFixed(2)} INF",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          color: primaryColor,
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        'by',
                                        style: TextStyle(
                                          color: Colors.white.withOpacity(0.7),
                                        ),
                                      ),
                                      const SizedBox(width: 4),
                                      Chip(
                                        label: Text(item.highestBidder),
                                        backgroundColor: secondaryColor.withOpacity(0.15),
                                        labelStyle: TextStyle(
                                          color: secondaryColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            ElevatedButton.icon(
                              icon: const Icon(Icons.gavel),
                              label: const Text('Bid'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: primaryColor,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8)),
                              ),
                              onPressed: () => _placeBid(item),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
                if (filteredItems.isEmpty)
                  Padding(
                    padding: const EdgeInsets.all(32),
                    child: Column(
                      children: [
                        Icon(Icons.hourglass_empty, size: 48, color: secondaryColor),
                        const SizedBox(height: 12),
                        Text(
                          "No auction items found.",
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.7),
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
