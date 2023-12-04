import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../easy_use_camera.dart';

class PreviewVideo extends StatelessWidget {
  const PreviewVideo({super.key, required this.file, this.errorBuilder, this.loadingBuilder, this.videoControllerBuilder, this.topFaceBuilder, this.rotateAngle = 0});

  final XFile file;
  final double rotateAngle;
  final Widget Function(BuildContext context)? errorBuilder;
  final Widget Function(BuildContext context)? loadingBuilder;
  final Widget Function(BuildContext context)? topFaceBuilder;
  final Widget Function(BuildContext context, VideoPlayerController controller)? videoControllerBuilder;

  @override
  Widget build(BuildContext context) {
    late VideoPlayerController controller;
    return Stack(
      children: [
        FutureBuilder(
          future: file.readAsBytes(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData && snapshot.data != null) {
                controller = VideoPlayerController.networkUrl(
                  Uri.dataFromBytes(snapshot.data!, mimeType: "video/mp4"),
                );
                return FutureBuilder(
                  future: controller.initialize(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (controller.value.isInitialized) {
                        return Stack(
                          children: [
                            Align(
                              alignment: Alignment.center,
                              child: Stack(
                                children: [
                                  Transform.rotate(
                                    angle: rotateAngle,
                                      child: VideoPlayer(controller),
                                  ),
                                  if (videoControllerBuilder != null) videoControllerBuilder!(context, controller),
                                ],
                              ),
                            ),
                            if(topFaceBuilder != null)
                              topFaceBuilder!(context)
                          ],
                        );
                      } else {
                        return errorBuilder?.call(context) ?? const SizedBox();
                      }
                    } else {
                      return loadingBuilder?.call(context) ??
                          const Center(
                            child: CircularProgressIndicator(),
                          );
                    }
                  },
                );
              } else {
                return errorBuilder?.call(context) ?? const SizedBox();
              }
            } else {
              return loadingBuilder?.call(context) ?? const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ],
    );
  }
}
