import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerScreen extends StatefulWidget {
  final List portfolioVideoLink;

  const VideoPlayerScreen(this.portfolioVideoLink,{Key? key}) : super(key: key);

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController _controller;
  List<String> videoList = [];

  @override
  void initState() {
    super.initState();
    widget.portfolioVideoLink.forEach((element) {
      // videoList = List<String>.from(element.map((x) => x.toString()));
      videoList = widget.portfolioVideoLink.cast();
      debugPrint("Video List $videoList");
    });
    for (int i = 0; i < videoList.length; i++) {
      _controller = VideoPlayerController.network(videoList.elementAt(i))
        ..initialize().then((_) {
          setState(() {
            _controller.play();
          }); //when your thumbnail will show.
        });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Video Player"),),
        body: SafeArea(
          child: Container(
      child: _controller.value.isInitialized
            ? GestureDetector(
          onTap: (){
            setState(() {
              _controller.value.isPlaying
                  ? _controller.pause()
                  : _controller.play();
            });
          },
          child: Center(
            child: AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: VideoPlayer(_controller),
            ),
          ),
      )
            : const Center(child: CircularProgressIndicator()),
    ),
        ));
  }
}
