import 'package:flutter/material.dart';

import '../easy_use_camera.dart';

class PreviewImage extends StatelessWidget {
  const PreviewImage({super.key, required this.file, this.surface, this.errorBuilder, this.loadingBuilder});

  final XFile file;
  final Widget? surface;
  final Widget Function(BuildContext context)? errorBuilder;
  final Widget Function(BuildContext context)? loadingBuilder;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
            child: FutureBuilder(
              future: file.readAsBytes(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    return Image.memory(snapshot.data!);
                  } else {
                    return errorBuilder != null ? errorBuilder!(context) : const SizedBox();
                  }
                } else {
                  return loadingBuilder != null
                      ? loadingBuilder!(context)
                      : const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            )),
        if (surface != null) surface!,
      ],
    );
  }
}