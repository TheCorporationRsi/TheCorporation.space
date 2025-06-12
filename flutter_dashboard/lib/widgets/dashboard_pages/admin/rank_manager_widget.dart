import 'package:corp_api/corp_api.dart';
import 'package:flutter/material.dart';
import 'package:built_collection/built_collection.dart';
import 'package:flutter_dashboard/const/constant.dart';
import 'package:flutter_dashboard/main.dart';

class RankManagerWidget extends StatefulWidget {
  const RankManagerWidget({super.key});

  @override
  _RankManagerWidgetState createState() => _RankManagerWidgetState();
}

class _RankManagerWidgetState extends State<RankManagerWidget> {
  BuiltList<GetRanks200ResponseInner> ranks = BuiltList<GetRanks200ResponseInner>();
  BuiltList<GetRanks200ResponseInner> filteredRanks = BuiltList<GetRanks200ResponseInner>();
  bool _isLoading = true;
  String _searchQuery = '';
  final corpInfluenceApi = corpApi.getInfluenceSystemApi();
  final corpAdminApi = corpApi.getAdminApi(); // <-- Add this line

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async {
    setState(() {
      _isLoading = true;
    });
    try {
      final response = await corpInfluenceApi.getRanks();
      if (response.data != null) {
        ranks = response.data!;
        _applySearch();
      }
    } catch (error) {
      print(error);
    }
    setState(() {
      _isLoading = false;
    });
  }

  void _applySearch() {
    setState(() {
      final sortedList = ranks.where((rank) {
        return rank.title!.toLowerCase().contains(_searchQuery.toLowerCase());
      })
      .toList()
      ..sort((a, b) => (a.requiredLifetimeInfluence ?? 0).compareTo(b.requiredLifetimeInfluence ?? 0));
      filteredRanks = sortedList.toBuiltList();
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

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: Column(
          children: [
            SizedBox(height: 10),
            _buildSearchAndAddSection(),
            SizedBox(height: 10),
            _buildRankList(),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchAndAddSection() {
    return Row(
      children: [
        Expanded(
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Search ranks...',
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onChanged: (value) {
              _searchQuery = value;
              _applySearch();
            },
          ),
        ),
        SizedBox(width: 10),
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () {
            _showAddRankDialog();
          },
        ),
        SizedBox(width: 10),
        IconButton(
          icon: Icon(Icons.refresh),
          onPressed: () {
            _initialize();
          },
        ),
      ],
    );
  }

  Widget _buildRankList() {
    if (filteredRanks.isEmpty) {
      return Center(
        child: Text(
          'No ranks found.',
          style: TextStyle(fontSize: 18, color: Colors.grey),
        ),
      );
    }
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: filteredRanks.length,
      itemBuilder: (context, index) {
        final rank = filteredRanks[index];
        return _buildRankItem(rank);
      },
    );
  }

  Widget _buildRankItem(GetRanks200ResponseInner rank) {
    return Card(
      color: cardBackgroundColor,
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: BorderSide(color: primaryColor.withOpacity(0.15), width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 18),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.emoji_events, color: secondaryColor, size: 26),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    rank.title ?? '',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                      letterSpacing: 0.5,
                    ),
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.star, color: secondaryColor, size: 20),
                      SizedBox(width: 6),
                      Text(
                        'Required Lifetime Influence: ',
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        '${rank.requiredLifetimeInfluence ?? 0}',
                        style: TextStyle(
                          color: secondaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(Icons.calendar_today, color: primaryColor, size: 18),
                      SizedBox(width: 6),
                      Text(
                        'Weekly Amount: ',
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        '${rank.weeklyAmount ?? 0}',
                        style: TextStyle(
                          color: secondaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(width: 10),
            Column(
              children: [
                IconButton(
                  icon: Icon(Icons.edit, color: Colors.blue),
                  onPressed: () {
                    _showEditRankDialog(rank);
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    _showDeleteDialog(rank);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showAddRankDialog() {
    String title = '';
    int? requiredLifetimeInfluence;
    int? weeklyAmount;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: cardBackgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          title: Text(
            'Add Rank',
            style: TextStyle(
              color: primaryColor,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(labelText: "Title"),
                onChanged: (value) => title = value,
              ),
              SizedBox(height: 10),
              TextField(
                decoration: InputDecoration(labelText: "Required Lifetime Influence"),
                keyboardType: TextInputType.number,
                onChanged: (value) => requiredLifetimeInfluence = int.tryParse(value),
              ),
              SizedBox(height: 10),
              TextField(
                decoration: InputDecoration(labelText: "Weekly Amount"),
                keyboardType: TextInputType.number,
                onChanged: (value) => weeklyAmount = int.tryParse(value),
              ),
            ],
          ),
          actions: [
            TextButton(
              child: Text('Cancel', style: TextStyle(color: Colors.grey)),
              onPressed: () => Navigator.of(context).pop(),
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
                _addRank(title, requiredLifetimeInfluence, weeklyAmount);
                Navigator.of(context).pop();
              },
              child: Text('Add', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            ),
          ],
        );
      },
    );
  }

  void _addRank(String title, int? requiredLifetimeInfluence, int? weeklyAmount) async {
    final headers = await getAuthHeader();
    final request = CreateRankRequest((b) => b
      ..title = title
      ..requiredLifetimeInfluence = requiredLifetimeInfluence
      ..weeklyAmount = weeklyAmount
    );
    try {
      final response = await corpAdminApi.createRank( // <-- Use admin API here
        headers: headers,
        createRankRequest: request,
      );
      if (response.data?.msg == "Rank created") {
        _initialize();
      }
    } catch (error) {
      print(error);
    }
  }

  void _showEditRankDialog(GetRanks200ResponseInner rank) {
    String newTitle = rank.title ?? '';
    int? newRequiredLifetimeInfluence = rank.requiredLifetimeInfluence;
    int? newWeeklyAmount = rank.weeklyAmount;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: cardBackgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          title: Text(
            'Edit Rank',
            style: TextStyle(
              color: primaryColor,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: TextEditingController(text: newTitle),
                decoration: InputDecoration(labelText: "Title"),
                onChanged: (value) => newTitle = value,
              ),
              SizedBox(height: 10),
              TextField(
                controller: TextEditingController(text: (newRequiredLifetimeInfluence ?? '').toString()),
                decoration: InputDecoration(labelText: "Required Lifetime Influence"),
                keyboardType: TextInputType.number,
                onChanged: (value) => newRequiredLifetimeInfluence = int.tryParse(value),
              ),
              SizedBox(height: 10),
              TextField(
                controller: TextEditingController(text: (newWeeklyAmount ?? '').toString()),
                decoration: InputDecoration(labelText: "Weekly Amount"),
                keyboardType: TextInputType.number,
                onChanged: (value) => newWeeklyAmount = int.tryParse(value),
              ),
            ],
          ),
          actions: [
            TextButton(
              child: Text('Cancel', style: TextStyle(color: Colors.grey)),
              onPressed: () => Navigator.of(context).pop(),
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
                _editRank(rank.title!, newTitle, newRequiredLifetimeInfluence, newWeeklyAmount);
                Navigator.of(context).pop();
              },
              child: Text('Save', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            ),
          ],
        );
      },
    );
  }

  void _editRank(String rankTitle, String? newTitle, int? newRequiredLifetimeInfluence, int? newWeeklyAmount) async {
    final headers = await getAuthHeader();
    final request = EditRankRequest((b) => b
      ..rankTitle = rankTitle
      ..title = newTitle
      ..requiredLifetimeInfluence = newRequiredLifetimeInfluence
      ..weeklyAmount = newWeeklyAmount
    );
    try {
      final response = await corpAdminApi.editRank( // <-- Use admin API
        headers: headers,
        editRankRequest: request,
      );
      if (response.data?.msg == "Rank updated") {
        _initialize();
      }
    } catch (error) {
      print(error);
    }
  }

  void _showDeleteDialog(GetRanks200ResponseInner rank) {
    String confirmation = '';
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: cardBackgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          title: Text(
            'Deleting ${rank.title}',
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
          ),
          actions: [
            TextButton(
              child: Text('Cancel', style: TextStyle(color: Colors.grey)),
              onPressed: () => Navigator.of(context).pop(),
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
                if (confirmation == rank.title) {
                  _deleteRank(rank.title!);
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
              child: Text('Delete', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            ),
          ],
        );
      },
    );
  }

  void _deleteRank(String rankTitle) async {
    final headers = await getAuthHeader();
    final request = DeleteRankRequest((b) => b..rankTitle = rankTitle);
    try {
      final response = await corpAdminApi.deleteRank( // <-- Use admin API
        headers: headers,
        deleteRankRequest: request,
      );
      if (response.data?.msg == "Rank deleted") {
        _initialize();
      }
    } catch (error) {
      print(error);
    }
  }
}
