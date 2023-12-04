import 'package:flutter/material.dart';
import 'package:video_viewer/video_viewer.dart';

import '../easy_use_camera.dart';

class PreviewVideo extends StatefulWidget {
  const PreviewVideo({super.key, required this.file, this.errorBuilder, this.loadingBuilder});

  final XFile file;
  final Widget Function(BuildContext context)? errorBuilder;
  final Widget Function(BuildContext context)? loadingBuilder;

  @override
  State<PreviewVideo> createState() => _PreviewVideoState();
}

class _PreviewVideoState extends State<PreviewVideo> {
  final VideoViewerController _controller = VideoViewerController();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: widget.file.readAsBytes(),
      builder: (context,snapshot) {
        if(snapshot.connectionState == ConnectionState.done){
          if(snapshot.hasData && snapshot.data != null){
            return VideoViewer(
              controller: _controller,
              onFullscreenFixLandscape: false,
              source: {
                'test': VideoSource(
                  video: VideoPlayerController.networkUrl(
                    Uri.dataFromBytes(snapshot.data!),
                  ),
                ),
              },
            );
          }else{
            return widget.errorBuilder?.call(context) ?? const SizedBox();
          }
        }else{
          return widget.loadingBuilder?.call(context) ?? const Center(child: CircularProgressIndicator(),);
        }

      }
    );
  }
}
