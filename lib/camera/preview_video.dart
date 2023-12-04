import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../easy_use_camera.dart';

class PreviewVideo extends StatefulWidget {
  const PreviewVideo({super.key, required this.file, this.errorBuilder, this.loadingBuilder, this.videoControllerBuilder, this.topFaceBuilder});

  final XFile file;
  final Widget Function(BuildContext context)? errorBuilder;
  final Widget Function(BuildContext context)? loadingBuilder;
  final Widget Function(BuildContext context)? topFaceBuilder;
  final Widget Function(BuildContext context, VideoPlayerController controller)? videoControllerBuilder;

  @override
  State<PreviewVideo> createState() => _PreviewVideoState();
}

class _PreviewVideoState extends State<PreviewVideo> {
  late VideoPlayerController _controller;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: widget.file.readAsBytes(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData && snapshot.data != null) {
            _controller = VideoPlayerController.networkUrl(Uri.dataFromBytes(snapshot.data!, mimeType: "video/mp4"));
            return FutureBuilder(
              future: _controller.initialize(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (_controller.value.isInitialized) {
                    return AspectRatio(
                      aspectRatio: _controller.value.aspectRatio,
                      child: Stack(
                        children: [
                          VideoPlayer(_controller),
                          if (widget.videoControllerBuilder != null) widget.videoControllerBuilder!(context, _controller),
                        ],
                      ),
                    );
                  } else {
                    return widget.errorBuilder?.call(context) ?? const SizedBox();
                  }
                } else {
                  return widget.loadingBuilder?.call(context) ??
                      const Center(
                        child: CircularProgressIndicator(),
                      );
                }
              },
            );
          } else {
            return widget.errorBuilder?.call(context) ?? const SizedBox();
          }
        } else {
          return widget.loadingBuilder?.call(context) ?? const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
