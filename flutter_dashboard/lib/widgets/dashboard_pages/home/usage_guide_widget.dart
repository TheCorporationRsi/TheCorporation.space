import 'package:flutter_dashboard/util/responsive.dart';
import 'package:flutter_dashboard/widgets/dashboard_pages/Influence_system/components/influence_details_card.dart';
import 'package:flutter_dashboard/widgets/dashboard_pages/components/bar_graph_widget.dart';
import 'package:flutter_dashboard/widgets/dashboard_pages/components/line_chart_card.dart';
import 'package:flutter_dashboard/widgets/header/profile_widget.dart';
import 'package:flutter_dashboard/widgets/dashboard_pages/components/custom_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_dashboard/const/constant.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_dashboard/util/video_player_widget.dart';

class UsageGuideWidget extends StatefulWidget {
  const UsageGuideWidget({super.key});

  @override
  _UsageGuideState createState() => _UsageGuideState();
}

class _UsageGuideState extends State<UsageGuideWidget> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();

    _controller = VideoPlayerController.networkUrl(
      Uri.parse(
        'https://thecorporation.space/api/v0/influence_presentation.mp4',
      ),
    );

    _initializeVideoPlayerFuture = _controller.initialize().then((_) {
      _controller.setVolume(0.5); // Set default volume to 75%
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Column(
                children: [
                  const SizedBox(height: 10),
                  Image.asset(
                    'assets/logo/corp_logo.png',
                    width: 200, // Adjust width
                  ),
                  const SizedBox(height: 10),
                  Text('Welcome to',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.orbitron(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      )),
                  Text('The Corporation Dashboard',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.orbitron(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      )),
                  const SizedBox(height: 5),
                  Text('Your one-stop tool to progress in The Corporation',
                      style: GoogleFonts.orbitron(
                        fontSize: 16,
                        color: Colors.white70,
                      )),
                  const SizedBox(height: 20),
                  GridView(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: constraints.maxWidth > 1000 ? 2 : 1,
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 20,
                        mainAxisExtent: 500),
                    children: [
                      CustomCard(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(height: 10),
                            Text(
                              'The Corporation',
                              style: GoogleFonts.orbitron(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 20),
                            const Text(
                              '''The Corporation was founded by @Pete AKA Weyland in the early days of the game.
                              \nThe goal of The Corporation is the play the role of the "evil" richest company that have control that extend to each corner of the galaxy.\nSimilar to the Weyland-Yutani corp in Alien, Cyberdyne in Terminator...
                              \nBeyond this funny image that is more as a joke, our goal is to build a better tommorow while keeping a fun and structured experience of collaboration that spread troughout all the aspects of the game.
                              \nOur organization is build over the influence system that act as the democracy system of the CORP.
                              ''',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      CustomCard(
                        color: backgroundColor,
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Image.asset(
                                'assets/images/evil_corps.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 20),
                  GridView(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: constraints.maxWidth > 1000 ? 2 : 1,
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 20,
                        mainAxisExtent: 500,
                        
                        ),
                    children: [
                      CustomCard(
                        color: backgroundColor,
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Image.asset(
                                'assets/images/department_mixed.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ],
                        ),
                      ),
                      CustomCard(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(height: 10),
                            Text(
                              'Our Structure',
                              style: GoogleFonts.orbitron(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 20),
                            const Text(
                              '''The structure of The Corporation is divided into Departments and Divisions.
                              \nThe departments are the main branches that are based on general activities such as Ressources gathering, Exploration, Combat....
                              \nDivisions are the sub-branches that are based on specific activities such as Mining, Esport, Scouting, Space Combat...
                              \nYou can join as many divisions as you want, but you will have to specify the importance of each divisions in your profile.
                              \nThose weights as we call it will be used for your progress as well as how the Corporation will asign ressources to each divisions.
                              ''',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 20),
                  GridView(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: constraints.maxWidth > 1000 ? 2 : 1,
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 20,
                        mainAxisExtent: 500),
                    children: [
                      CustomCard(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(height: 10),
                            Text(
                              'The Influence System',
                              style: GoogleFonts.orbitron(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 20),
                            const Text(
                              '''The Influence System is a powerful tool that allows you to track your progress in The Corporation.
                              \nEach week, you receive a set amount of tribute to send to the people that you think deserves it the most.
                              \nThe generated influence that you and the person receive will be calculated based on both memberships.''',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              'For more details, visit the Influence System section.',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  fontSize: 18, 
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  ),
                            ),
                            
                          ],
                        ),
                      ),
                      CustomCard(
                          color: backgroundColor,
                          padding: const EdgeInsets.all(20),
                          child: VideoPlayerWidget(
                            controller: _controller,
                            initializeVideoPlayerFuture:
                                _initializeVideoPlayerFuture,
                          )),
                    ],
                  ),
                  const SizedBox(height: 18),
                  const SizedBox(height: 18),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
