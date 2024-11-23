import 'package:flutter_dashboard/const/constant.dart';
import 'package:flutter_dashboard/widgets/dashboard_pages/components/pie_chart_widget.dart';
import 'package:flutter_dashboard/widgets/dashboard_pages/components/scheduled_widget.dart';
import 'package:flutter_dashboard/widgets/dashboard_pages/components/summary_details.dart';
import 'package:flutter/material.dart';

import 'package:corp_api/corp_api.dart';

class ProfileWidget extends StatelessWidget {
  const ProfileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: cardBackgroundColor,
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('assets/images/avatar.png'),
              ),
              SizedBox(height: 20),
              Text(
                'RSI Handle: CyberDreamer',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                'RSI Moniker: The Explorer',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 20),
              Divider(),
              SizedBox(height: 10),
              Text(
                'Roles',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 10),
              Text(
                'Leadership',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              ),
              Wrap(
                spacing: 8.0,
                runSpacing: 4.0,
                children: [
                  Chip(
                    avatar: Icon(Icons.star, color: Colors.blue),
                    label: Text('Leader'),
                    shape: StadiumBorder(side: BorderSide(color: Colors.blue)),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Text(
                'Membership',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              ),
              Wrap(
                spacing: 8.0,
                runSpacing: 4.0,
                children: [
                  Chip(
                    avatar: Icon(Icons.flight, color: Colors.green),
                    label: Text('Pilot'),
                    shape: StadiumBorder(side: BorderSide(color: Colors.green)),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Text(
                'Characteristic',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              ),
              Wrap(
                spacing: 8.0,
                runSpacing: 4.0,
                children: [
                  Chip(
                    avatar: Icon(Icons.build, color: Colors.orange),
                    label: Text('Engineer'),
                    shape:
                        StadiumBorder(side: BorderSide(color: Colors.orange)),
                  ),
                  Chip(
                    avatar: Icon(Icons.healing, color: Colors.red),
                    label: Text('Medic'),
                    shape: StadiumBorder(side: BorderSide(color: Colors.red)),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Text(
                'Other',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              ),
              // Add other roles here if needed
              SizedBox(height: 20),
              Divider(),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Text(
                        'Rank',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      Text(
                        'Admiral',
                        style: TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        'Tribute',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      Text(
                        '3000',
                        style: TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20),
              Divider(),
              SizedBox(height: 10),
              Chart(),
              Text(
                'Summary',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 16),
              SummaryDetails(),
              SizedBox(height: 40),
              Scheduled(),
            ],
          ),
        ),
      ),
    );
  }
}
