import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dashboard/const/constant.dart';
import 'package:corp_api/corp_api.dart';
import 'package:flutter_dashboard/main.dart';
import 'package:flutter_dashboard/model/current_user.dart' as current_user;
import 'package:flutter_dashboard/model/information.dart';
import 'components/auction_card.dart';

class AuctionWidget extends StatefulWidget {
  const AuctionWidget({super.key});

  @override
  State<AuctionWidget> createState() => _AuctionWidgetState();
}

class _AuctionWidgetState extends State<AuctionWidget> {
  final InfluenceSystemApi api = corpApi.getInfluenceSystemApi();
  final TextEditingController _filterController = TextEditingController();
  BuiltList<ListAuctions200ResponseInner> _auctions = BuiltList<ListAuctions200ResponseInner>();
  bool _loading = false;
  String? _error;
  String _filter = '';

  @override
  void initState() {
    super.initState();
    _fetchAuctions();
  }

  Future<void> _fetchAuctions() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final headers = await getAuthHeader();
      final response = await api.listAuctions(headers: headers);
      if (response.data != null) {
        setState(() {
          _auctions = response.data as BuiltList<ListAuctions200ResponseInner>;
          _loading = false;
        });
      } else {
        setState(() {
          _auctions = BuiltList<ListAuctions200ResponseInner>();
          _loading = false;
        });
      }
    } catch (e) {
      setState(() {
        _error = 'Failed to load auctions.';
        _loading = false;
      });
    }
  }

  Future<void> _showBidDialog(ListAuctions200ResponseInner auction) async {
    final controller = TextEditingController(
      text: ((auction.currentPrice?.toInt() ?? 0) + 10).toString(),
    );
    String? error;
    bool submitting = false;

    await showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          backgroundColor: cardBackgroundColor,
          title: Text('Bid on "${auction.title ?? ''}"', style: const TextStyle(color: Colors.white)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Current: ${(auction.currentPrice?.toInt() ?? 0)} INF by ${auction.highestBidder ?? "-"}',
                style: TextStyle(color: primaryColor),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: controller,
                keyboardType: TextInputType.number,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Your Bid (INF)',
                  labelStyle: TextStyle(color: secondaryColor),
                  focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: primaryColor)),
                  enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: secondaryColor.withOpacity(0.5))),
                ),
              ),
              if (error != null)
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(error ?? '', style: const TextStyle(color: Colors.redAccent)),
                ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel', style: TextStyle(color: secondaryColor)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: primaryColor),
              onPressed: submitting
                  ? null
                  : () async {
                      final bid = int.tryParse(controller.text);
                      if (bid == null || bid <= (auction.currentPrice?.toInt() ?? 0) || bid <= 0) {
                        setDialogState(() => error = "Bid must be a positive integer and higher than current.");
                        return;
                      }
                      setDialogState(() {
                        submitting = true;
                        error = null;
                      });
                      try {
                        final headers = await getAuthHeader();
                        await api.placeBet(
                          headers: headers,
                          placeBetRequest: PlaceBetRequest((b) => b
                            ..auctionId = auction.id ?? ''
                            ..amount = bid),
                        );
                        Navigator.pop(context);
                        _fetchAuctions();
                      } catch (_) {
                        setDialogState(() {
                          error = "Failed to place bid.";
                          submitting = false;
                        });
                      }
                    },
              child: submitting
                  ? const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                  : const Text('Place Bid'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showCreateAuctionDialog() async {
    final titleController = TextEditingController();
    final descController = TextEditingController();
    DateTime? endTime;
    String? error;
    bool submitting = false;

    // For department and division selection
    String selectedDepartmentId = 'none';
    String selectedDivisionId = 'none';

    await showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          backgroundColor: cardBackgroundColor,
          title: const Text('Create Auction', style: TextStyle(color: Colors.white)),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: titleController,
                  decoration: const InputDecoration(
                    labelText: 'Title',
                    labelStyle: TextStyle(color: Colors.white),
                  ),
                  style: const TextStyle(color: Colors.white),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: descController,
                  decoration: const InputDecoration(
                    labelText: 'Description',
                    labelStyle: TextStyle(color: Colors.white),
                  ),
                  style: const TextStyle(color: Colors.white),
                  maxLines: 2,
                ),
                const SizedBox(height: 12),
                // Department dropdown
                ValueListenableBuilder(
                  valueListenable: current_user.departments,
                  builder: (context, deptList, _) {
                    final items = [
                      const DropdownMenuItem<String>(
                        value: 'none',
                        child: Text('None', style: TextStyle(color: Colors.white)),
                      ),
                      ...deptList.map((d) => DropdownMenuItem<String>(
                        value: d.title ?? '',
                        child: Text(d.title ?? '', style: const TextStyle(color: Colors.white)),
                      )),
                    ];
                    return Row(
                      children: [
                        const Text('Department:', style: TextStyle(color: Colors.white)),
                        const SizedBox(width: 12),
                        Expanded(
                          child: DropdownButton<String>(
                            value: selectedDepartmentId,
                            dropdownColor: cardBackgroundColor,
                            style: const TextStyle(color: Colors.white),
                            items: items,
                            onChanged: (val) {
                              if (val != null) {
                                setDialogState(() {
                                  selectedDepartmentId = val;
                                  selectedDivisionId = 'none';
                                });
                              }
                            },
                          ),
                        ),
                      ],
                    );
                  },
                ),
                const SizedBox(height: 12),
                // Division dropdown (only if department selected)
                if (selectedDepartmentId != 'none')
                  ValueListenableBuilder(
                    valueListenable: divisions,
                    builder: (context, divList, _) {
                      final filteredDivs = divList.where((d) => d.departmentTitle == selectedDepartmentId).toList();
                      final items = [
                        const DropdownMenuItem<String>(
                          value: 'none',
                          child: Text('None', style: TextStyle(color: Colors.white)),
                        ),
                        ...filteredDivs.map((d) => DropdownMenuItem<String>(
                          value: d.title ?? '',
                          child: Text(d.title ?? '', style: const TextStyle(color: Colors.white)),
                        )),
                      ];
                      return Row(
                        children: [
                          const Text('Division:', style: TextStyle(color: Colors.white)),
                          const SizedBox(width: 12),
                          Expanded(
                            child: DropdownButton<String>(
                              value: selectedDivisionId,
                              dropdownColor: cardBackgroundColor,
                              style: const TextStyle(color: Colors.white),
                              items: items,
                              onChanged: (val) {
                                if (val != null) {
                                  setDialogState(() {
                                    selectedDivisionId = val;
                                  });
                                }
                              },
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        endTime == null
                            ? 'No end time selected'
                            : 'Ends: $endTime',
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    TextButton(
                      onPressed: () async {
                        final now = DateTime.now();
                        final picked = await showDatePicker(
                          context: context,
                          initialDate: now,
                          firstDate: now,
                          lastDate: now.add(const Duration(days: 365)),
                        );
                        if (picked != null) {
                          final time = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.now(),
                          );
                          if (time != null) {
                            setDialogState(() {
                              endTime = DateTime(
                                picked.year,
                                picked.month,
                                picked.day,
                                time.hour,
                                time.minute,
                              );
                            });
                          }
                        }
                      },
                      child: const Text('Pick End Time'),
                    ),
                  ],
                ),
                if (error != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(error ?? '', style: const TextStyle(color: Colors.redAccent)),
                  ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel', style: TextStyle(color: secondaryColor)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: primaryColor),
              onPressed: submitting
                  ? null
                  : () async {
                      final title = titleController.text.trim();
                      final desc = descController.text.trim();
                      if (title.isEmpty || desc.isEmpty || endTime == null) {
                        setDialogState(() => error = "Fill all fields and pick end time.");
                        return;
                      }
                      setDialogState(() {
                        submitting = true;
                        error = null;
                      });
                      try {
                        final headers = await getAuthHeader();
                        await api.createAuction(
                          headers: headers,
                          createAuctionRequest: CreateAuctionRequest((b) {
                            b
                              ..title = title
                              ..description = desc
                              ..endTime = endTime!.toUtc();
                            // Attach division or department if selected
                            if (selectedDivisionId != 'none') {
                              b.division = selectedDivisionId;
                            } else if (selectedDepartmentId != 'none') {
                              b.department = selectedDepartmentId;
                            }
                          }),
                        );
                        Navigator.pop(context);
                        _fetchAuctions();
                      } catch (_) {
                        setDialogState(() {
                          error = "Failed to create auction.";
                          submitting = false;
                        });
                      }
                    },
              child: submitting
                  ? const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                  : const Text('Create'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _deleteAuction(ListAuctions200ResponseInner auction) async {
    bool submitting = false;
    String? error;
    await showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          backgroundColor: cardBackgroundColor,
          title: const Text('Delete Auction', style: TextStyle(color: Colors.white)),
          content: Text(
            'Are you sure you want to delete "${auction.title ?? ''}"?',
            style: const TextStyle(color: Colors.white),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel', style: TextStyle(color: secondaryColor)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              onPressed: submitting
                  ? null
                  : () async {
                      setDialogState(() {
                        submitting = true;
                        error = null;
                      });
                      try {
                        final headers = await getAuthHeader();
                        final request = DeleteAuctionRequest((b) => b
                          ..auctionId = auction.id ?? ''
                        );
                        final response = await api.deleteAuction(
                          headers: headers,
                          deleteAuctionRequest: request,
                        );
                        if (response.statusCode == 200) {
                          Navigator.pop(context);
                          _fetchAuctions();
                        } else {
                          setDialogState(() {
                            error = "Failed to delete auction.";
                            submitting = false;
                          });
                        }
                      } catch (_) {
                        setDialogState(() {
                          error = "Failed to delete auction.";
                          submitting = false;
                        });
                      }
                    },
              child: submitting
                  ? const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                  : const Text('Delete'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _closeAuction(ListAuctions200ResponseInner auction) async {
    // Prevent finalizing before auction end time
    final now = DateTime.now().toUtc();
    final endTime = auction.endTime?.toUtc();
    if (endTime != null && now.isBefore(endTime)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("You can't finalize this auction before it ends."),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    bool submitting = false;
    String? error;
    await showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          backgroundColor: cardBackgroundColor,
          title: const Text('Finalize Auction', style: TextStyle(color: Colors.white)),
          content: Text(
            'Are you sure you want to finalize (close) "${auction.title ?? ''}"? This will end the auction immediately.',
            style: const TextStyle(color: Colors.white),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel', style: TextStyle(color: secondaryColor)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: primaryColor),
              onPressed: submitting
                  ? null
                  : () async {
                      setDialogState(() {
                        submitting = true;
                        error = null;
                      });
                      try {
                        final headers = await getAuthHeader();
                        final request = DeleteAuctionRequest((b) => b
                          ..auctionId = auction.id ?? ''
                        );
                        final response = await api.closeAuction(
                          headers: headers,
                          deleteAuctionRequest: request,
                        );
                        if (response.statusCode == 200) {
                          Navigator.pop(context);
                          _fetchAuctions();
                        } else {
                          setDialogState(() {
                            error = "Failed to finalize auction.";
                            submitting = false;
                          });
                        }
                      } catch (_) {
                        setDialogState(() {
                          error = "Failed to finalize auction.";
                          submitting = false;
                        });
                      }
                    },
              child: submitting
                  ? const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                  : const Text('Finalize'),
            ),
          ],
        ),
      ),
    );
  }

  bool _isCurrentUserCreator(ListAuctions200ResponseInner auction) {
    // Use itemHolder (creator) and rsiHandle (current user) for comparison
    return auction.itemHolder != null && auction.itemHolder == current_user.rsiHandle;
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
    // Sort auctions by startTime, latest to oldest
    final sortedAuctions = _auctions.toList()
      ..sort((a, b) {
        final aTime = a.startTime;
        final bTime = b.startTime;
        if (aTime == null && bTime == null) return 0;
        if (aTime == null) return 1;
        if (bTime == null) return -1;
        return bTime.compareTo(aTime); // latest first
      });

    final filtered = sortedAuctions.where((a) {
      final f = _filter.toLowerCase();
      return (a.title ?? '').toLowerCase().contains(f) ||
          (a.description ?? '').toLowerCase().contains(f);
    }).toList();

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: Column(
          children: [
            const SizedBox(height: 18),
            Row(
              children: [
                Expanded(
                  child: Card(
                    color: cardBackgroundColor,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
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
                                hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
                              ),
                              style: const TextStyle(color: Colors.white),
                              onChanged: (val) => setState(() => _filter = val),
                            ),
                          ),
                          if (_filter.isNotEmpty)
                            IconButton(
                              icon: Icon(Icons.clear, color: secondaryColor),
                              onPressed: () {
                                _filterController.clear();
                                setState(() => _filter = '');
                              },
                            ),
                          IconButton(
                            icon: Icon(Icons.refresh, color: secondaryColor),
                            onPressed: _fetchAuctions,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                if (current_user.isCurrentUserManager())
                  Tooltip(
                    message: "Add Auction",
                    child: IconButton(
                      icon: Icon(Icons.add_circle, color: primaryColor, size: 32),
                      onPressed: _showCreateAuctionDialog,
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 18),
            if (_loading)
              const Padding(
                padding: EdgeInsets.all(32),
                child: CircularProgressIndicator(),
              )
            else if (_error != null)
              Padding(
                padding: const EdgeInsets.all(32),
                child: Text(_error!, style: const TextStyle(color: Colors.redAccent, fontSize: 16)),
              )
            else if (filtered.isEmpty)
              Padding(
                padding: const EdgeInsets.all(32),
                child: Column(
                  children: [
                    Icon(Icons.hourglass_empty, size: 48, color: secondaryColor),
                    const SizedBox(height: 12),
                    Text(
                      "No auctions at the moment. Please come back later.",
                      style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 16),
                    ),
                  ],
                ),
              )
            else
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: filtered.length,
                itemBuilder: (context, idx) {
                  final auction = filtered[idx];
                  final isCreator = _isCurrentUserCreator(auction);
                  return AuctionCard(
                    auction: auction,
                    onBid: () => _showBidDialog(auction),
                    onDelete: isCreator ? () => _deleteAuction(auction) : null,
                    onFinalize: isCreator ? () => _closeAuction(auction) : null,
                  );
                },
              ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
