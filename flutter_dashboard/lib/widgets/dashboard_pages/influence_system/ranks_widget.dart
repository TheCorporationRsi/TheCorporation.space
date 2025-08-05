import 'package:corp_api/corp_api.dart';
import 'package:flutter/material.dart';
import 'package:built_collection/built_collection.dart';
import 'package:flutter_dashboard/const/constant.dart';
import 'package:flutter_dashboard/main.dart';

class RanksDocumentationWidget extends StatefulWidget {
  const RanksDocumentationWidget({super.key});

  @override
  _RanksDocumentationWidgetState createState() => _RanksDocumentationWidgetState();
}

class _RanksDocumentationWidgetState extends State<RanksDocumentationWidget> {
  BuiltList<GetRanks200ResponseInner> ranks = BuiltList<GetRanks200ResponseInner>();
  bool _isLoading = true;
  String _searchQuery = '';
  final corpInfluenceApi = corpApi.getInfluenceSystemApi();

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
        child: Center(child: CircularProgressIndicator(color: primaryColor)),
      );
    }

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: Column(
          children: [
            SizedBox(height: 18),
            _buildSearchSection(),
            SizedBox(height: 18),
            _buildRankList(),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchSection() {
    return TextField(
      decoration: InputDecoration(
        hintText: 'Search ranks...',
        prefixIcon: Icon(Icons.search, color: primaryColor),
        filled: true,
        fillColor: cardBackgroundColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: primaryColor, width: 1.5),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: primaryColor.withOpacity(0.5), width: 1.2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: primaryColor, width: 2),
        ),
      ),
      style: TextStyle(color: primaryColor, fontWeight: FontWeight.w500),
      onChanged: (value) {
        setState(() {
          _searchQuery = value;
        });
      },
    );
  }

  Widget _buildRankList() {
    final filteredRanks = ranks.where((rank) {
      return rank.title!.toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList()
      ..sort((a, b) => (a.requiredLifetimeInfluence ?? 0).compareTo(b.requiredLifetimeInfluence ?? 0));

    if (filteredRanks.isEmpty) {
      return Center(
        child: Text(
          'No ranks found.',
          style: TextStyle(fontSize: 18, color: Colors.grey),
        ),
      );
    }
    return ListView.separated(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: filteredRanks.length,
      separatorBuilder: (_, __) => SizedBox(height: 12),
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.emoji_events, color: secondaryColor, size: 26),
                SizedBox(width: 10),
                Text(
                  rank.title ?? '',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
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
    );
  }
}
