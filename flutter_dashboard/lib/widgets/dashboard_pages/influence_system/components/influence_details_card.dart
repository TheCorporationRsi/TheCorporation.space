import 'package:flutter_dashboard/const/constant.dart';
import 'package:flutter_dashboard/util/responsive.dart';
import 'package:flutter_dashboard/widgets/dashboard_pages/components/custom_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dashboard/model/influence_account.dart' as infAccount;
import 'package:auto_size_text/auto_size_text.dart';
class InfluenceDetailsCard extends StatelessWidget {
  final String filter;
  final String category;
  final bool show_details;
  const InfluenceDetailsCard({super.key, required this.category, required this.filter, required this.show_details});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
                  valueListenable: infAccount.profile,
                  builder: (context, value, child) =>GridView(
      shrinkWrap: true,
      physics: const ScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: Responsive.isMobile(context) ? 2 : 4,
        crossAxisSpacing: Responsive.isMobile(context) ? 12 : 15,
        mainAxisSpacing: 12.0,
      ),
      children: [
        
        CustomCard(
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: AutoSizeText(
                    "Tribute",
                    maxLines: 1,
                    maxFontSize: 18,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 15, bottom: 15),
                  child: Container(
                    height: 100,
                    child: Center(
                      child: Text(
                        'Tribute Chart\n(Coming Soon)',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                  )
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                    child: Icon(
                    Icons.volunteer_activism_rounded,
                    color: primaryColor,
                    size: 40,
                  ),
                ),
              ),
              if (show_details)
              Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: TextButton(
                    style: TextButton.styleFrom(overlayColor: Colors.grey),
                    onPressed: () {
                      // Add your onPressed code here!
                    },
                    child: const Text(
                      'Details',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        CustomCard(
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: AutoSizeText(
                    "Influence",
                    maxLines: 1,
                    maxFontSize: 18,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 15, bottom: 15),
                  child: Container(
                    height: 100,
                    child: Center(
                      child: Text(
                        'Influence Chart\n(Coming Soon)',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                  )
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                    child: Icon(
                    Icons.trending_up_rounded,
                    color: primaryColor,
                    size: 40,
                  ),
                ),
              ),
              if (show_details)
              Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: TextButton(
                    style: TextButton.styleFrom(overlayColor: Colors.grey),
                    onPressed: () {
                      // Add your onPressed code here!
                    },
                    child: const Text(
                      'Details',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        CustomCard(
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: AutoSizeText(
                    "Lifetime influence",
                    maxLines: 1,
                    maxFontSize: 18,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 15, bottom: 15),
                  child: Container(
                    height: 100,
                    child: Center(
                      child: Text(
                        'Lifetime Influence Chart\n(Coming Soon)',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                  )
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                    child: Icon(
                    Icons.timeline_outlined,
                    color: primaryColor,
                    size: 40,
                  ),
                ),
              ),
              if (show_details)
              Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: TextButton(
                    style: TextButton.styleFrom(overlayColor: Colors.grey),
                    onPressed: () {
                      // Add your onPressed code here!
                    },
                    child: const Text(
                      'Details',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        CustomCard(
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: AutoSizeText(
                    "Rank",
                    maxLines: 1,
                    maxFontSize: 18,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 15, bottom: 15),
                  child: AutoSizeText(
                    (value['rank'] ?? 'N/A').toString(),
                    maxLines: 1,
                    maxFontSize: 22,
                    textScaleFactor: 1.4,
                    style: const TextStyle(
                      color: secondaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                    child: Icon(
                    Icons.military_tech_rounded,
                    color: primaryColor,
                    size: 40,
                  ),
                ),
              ),
              if (show_details)
              Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: TextButton(
                    style: TextButton.styleFrom(overlayColor: Colors.grey),
                    onPressed: () {
                      // Add your onPressed code here!
                    },
                    child: const Text(
                      'Details',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ));
  }
}
