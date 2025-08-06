import 'package:flutter/material.dart';

class InfluenceDetailsCard extends StatelessWidget {
  const InfluenceDetailsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Icon(
              Icons.construction,
              size: 48,
              color: Colors.purple,
            ),
            const SizedBox(height: 16),
            Text(
              'Influence Details Card',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(
              'Under Migration',
              style: TextStyle(
                color: Colors.purple,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'This widget is being migrated to the new API system.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey[600]),
            ),
          ],
        ),
      ),
    );
  }
}
