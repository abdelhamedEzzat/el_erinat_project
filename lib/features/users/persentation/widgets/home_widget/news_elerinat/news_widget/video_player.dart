import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class BuildNetworkVideoPlayer extends StatefulWidget {
  final String videoUrl;
  final bool isLocal;
  final bool isLooping;
  const BuildNetworkVideoPlayer({
    super.key,
    required this.videoUrl,
    required this.isLocal,
    required this.isLooping,
  });

  @override
  // ignore: library_private_types_in_public_api
  _BuildNetworkVideoPlayerState createState() =>
      _BuildNetworkVideoPlayerState();
}

class _BuildNetworkVideoPlayerState extends State<BuildNetworkVideoPlayer> {
  late VideoPlayerController _videoPlayerController;
  late ChewieController _chewieController;
  bool _isControllerInitialized = false;

  @override
  void initState() {
    super.initState();

    if (widget.isLocal) {
      _videoPlayerController =
          VideoPlayerController.file(File(widget.videoUrl));
    } else {
      // ignore: deprecated_member_use
      _videoPlayerController = VideoPlayerController.network(widget.videoUrl);
    }

    _videoPlayerController.initialize().then((_) {
      if (mounted) {
        setState(() {
          _chewieController = ChewieController(
            videoPlayerController: _videoPlayerController,
            autoInitialize: true,
            aspectRatio: 20 / 12,
            looping: widget.isLooping,
            allowFullScreen: false,
            errorBuilder: (context, errorMessage) {
              return Center(
                child: Text(
                  errorMessage,
                  style: const TextStyle(color: Colors.white),
                ),
              );
            },
          );
          _isControllerInitialized = true;
        });
      }
    });
  }

  @override
  void dispose() {
    if (_isControllerInitialized) {
      _chewieController.dispose();
      _videoPlayerController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _isControllerInitialized
        ? Chewie(controller: _chewieController)
        : const Center(child: CircularProgressIndicator());
  }
}
