import 'package:flutter/material.dart';
import 'package:flutter_dashboard/const/constant.dart';

class AuctionItem {
  final String name;
  final String description;
  final String imageUrl;
  final String itemType;
  final String auctionLevel;
  double highestBid;
  String highestBidder;

  AuctionItem({
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.itemType,
    required this.auctionLevel,
    required this.highestBid,
    required this.highestBidder,
  });
}

class AuctionWidget extends StatefulWidget {
  const AuctionWidget({super.key});

  @override
  State<AuctionWidget> createState() => _AuctionWidgetState();
}

class _AuctionWidgetState extends State<AuctionWidget> {
  List<AuctionItem> allItems = [
    AuctionItem(
      name: "Golden Trophy",
      description: "A rare golden trophy from 1999.",
      imageUrl: "https://img.icons8.com/fluency/96/trophy.png",
      itemType: "Collectible",
      auctionLevel: "Legendary",
      highestBid: 1200,
      highestBidder: "Alice",
    ),
    AuctionItem(
      name: "Vintage Watch",
      description: "Classic 1960s wristwatch.",
      imageUrl: "https://img.icons8.com/fluency/96/trophy.png",
      itemType: "Accessory",
      auctionLevel: "Epic",
      highestBid: 800,
      highestBidder: "Bob",
    ),
    AuctionItem(
      name: "Art Piece",
      description: "Modern art painting by J. Doe.",
      imageUrl: "https://img.icons8.com/fluency/96/paint-palette.png",
      itemType: "Artwork",
      auctionLevel: "Rare",
      highestBid: 1500,
      highestBidder: "Charlie",
    ),
    // ...add more items as desired...
  ];

  String filter = '';
  String? selectedType;
  String? selectedLevel;
  final TextEditingController _filterController = TextEditingController();

  List<String> get itemTypes =>
      allItems.map((e) => e.itemType).toSet().toList();
  List<String> get auctionLevels =>
      allItems.map((e) => e.auctionLevel).toSet().toList();

  void _placeBid(AuctionItem item) async {
    final TextEditingController bidController = TextEditingController(
      text: (item.highestBid + 10).toStringAsFixed(2),
    );
    void addToBid(double amount) {
      final current = double.tryParse(bidController.text) ?? item.highestBid;
      bidController.text = (current + amount).toStringAsFixed(2);
    }

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: cardBackgroundColor,
        title: Text(
          'Place a Bid for "${item.name}"',
          style: const TextStyle(color: Colors.white),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Current highest: ${item.highestBid.toStringAsFixed(2)} INF by ${item.highestBidder}',
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
                      onPressed: () => addToBid(10),
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
                      onPressed: () => addToBid(100),
                      child: const Text('+100'),
                    ),
                  ],
                ),
              ],
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
            onPressed: () {
              final bid = double.tryParse(bidController.text);
              if (bid != null && bid > item.highestBid) {
                setState(() {
                  item.highestBid = bid;
                  item.highestBidder = "You";
                });
                Navigator.pop(context);
              }
            },
            child: const Text('Place Bid'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final filteredItems = allItems
        .where((item) =>
            (item.name.toLowerCase().contains(filter.toLowerCase()) ||
             item.description.toLowerCase().contains(filter.toLowerCase()) ||
             item.itemType.toLowerCase().contains(filter.toLowerCase()) ||
             item.auctionLevel.toLowerCase().contains(filter.toLowerCase())) &&
            (selectedType == null || item.itemType == selectedType) &&
            (selectedLevel == null || item.auctionLevel == selectedLevel)
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
                child: Column(
                  children: [
                    Row(
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
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: DropdownButtonFormField<String>(
                            value: selectedType,
                            dropdownColor: cardBackgroundColor,
                            decoration: InputDecoration(
                              labelText: "Item Type",
                              labelStyle: TextStyle(color: secondaryColor),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: secondaryColor.withOpacity(0.5)),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: secondaryColor),
                              ),
                            ),
                            style: const TextStyle(color: Colors.white),
                            items: [
                              const DropdownMenuItem<String>(
                                value: null,
                                child: Text("All Types", style: TextStyle(color: Colors.white)),
                              ),
                              ...itemTypes.map((type) => DropdownMenuItem(
                                    value: type,
                                    child: Text(type, style: const TextStyle(color: Colors.white)),
                                  )),
                            ],
                            onChanged: (val) {
                              setState(() {
                                selectedType = val;
                              });
                            },
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: DropdownButtonFormField<String>(
                            value: selectedLevel,
                            dropdownColor: cardBackgroundColor,
                            decoration: InputDecoration(
                              labelText: "Auction Level",
                              labelStyle: TextStyle(color: primaryColor),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: primaryColor.withOpacity(0.5)),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: primaryColor),
                              ),
                            ),
                            style: const TextStyle(color: Colors.white),
                            items: [
                              const DropdownMenuItem<String>(
                                value: null,
                                child: Text("All Levels", style: TextStyle(color: Colors.white)),
                              ),
                              ...auctionLevels.map((level) => DropdownMenuItem(
                                    value: level,
                                    child: Text(level, style: const TextStyle(color: Colors.white)),
                                  )),
                            ],
                            onChanged: (val) {
                              setState(() {
                                selectedLevel = val;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 18),
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
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            item.imageUrl,
                            width: 64,
                            height: 64,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: 18),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: secondaryColor.withOpacity(0.15),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Text(
                                      item.itemType,
                                      style: TextStyle(
                                        color: secondaryColor,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: primaryColor.withOpacity(0.15),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Text(
                                      item.auctionLevel,
                                      style: TextStyle(
                                        color: primaryColor,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                ],
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
                                    "${item.highestBid.toStringAsFixed(2)} INF",
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
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
