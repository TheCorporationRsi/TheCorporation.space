
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_dashboard/const/constant.dart';

class VideoPlayerWidget extends StatefulWidget {
  final VideoPlayerController controller;
  final Future<void> initializeVideoPlayerFuture;

  const VideoPlayerWidget({
    Key? key,
    required this.controller,
    required this.initializeVideoPlayerFuture,
  }) : super(key: key);

  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  @override
  Widget build(BuildContext context) {
    return Container( // Adjust height as needed
      child: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: widget.initializeVideoPlayerFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return AspectRatio(
                    aspectRatio: widget.controller.value.aspectRatio,
                    child: VideoPlayer(widget.controller),
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
          const SizedBox(height: 10),
          Container(
            width: double.infinity,
            child: VideoProgressIndicator(
              widget.controller,
              allowScrubbing: true,
              colors: VideoProgressColors(
                playedColor: secondaryColor,
                bufferedColor: Colors.grey,
                backgroundColor: primaryColor,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FloatingActionButton(
                  backgroundColor: primaryColor,
                  foregroundColor: secondaryColor,
                  onPressed: () {
                    setState(() {
                      if (widget.controller.value.isPlaying) {
                        widget.controller.pause();
                      } else {
                        widget.controller.play();
                      }
                    });
                  },
                  child: Icon(
                    widget.controller.value.isPlaying
                        ? Icons.pause
                        : Icons.play_arrow,
                  ),
                ),
                const SizedBox(width: 20),
                Row(
                  children: [
                    Icon(Icons.volume_down, color: secondaryColor),
                    Container(
                      width: 150,
                      child: Slider(
                        value: widget.controller.value.volume,
                        min: 0.0,
                        max: 1.0,
                        onChanged: (value) {
                          setState(() {
                            widget.controller.setVolume(value);
                          });
                        },
                        activeColor: secondaryColor,
                        inactiveColor: Colors.grey,
                      ),
                    ),
                    Icon(Icons.volume_up, color: secondaryColor),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}