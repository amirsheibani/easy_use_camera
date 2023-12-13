import 'dart:math';
import 'dart:ui';

import 'package:ffmpeg_wasm/ffmpeg_wasm.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image/image.dart';

enum ConvertType {
  jpg,
  png,
}

extension OnXFIle on XFile {
  Future<XFile?> cropImageAndConvertTo({ConvertType convertType = ConvertType.jpg, required double aspectRatio, double horizontalPadding = 0}) async {
    final byte = await readAsBytes();
    final Image? image = decodeImage(byte);
    if (image == null) {
      return null;
    }
    final width = image.width - horizontalPadding;
    final height = width / aspectRatio;
    final x = (horizontalPadding / 2).floor();
    final y = ((image.height / 2) - height / 2).floor();
    final imageCropResult = copyCrop(image, x: x, y: y, width: width.ceil(), height: height.ceil());
    if (convertType == ConvertType.jpg) {
      return XFile.fromData(encodeJpg(imageCropResult));
    } else {
      return XFile.fromData(encodePng(imageCropResult));
    }
  }

  Future<XFile?> convertToJpg() async {
    final byte = await readAsBytes();
    final Image? image = decodeImage(byte);
    if (image == null) {
      return null;
    }
    return XFile.fromData(encodeJpg(image));
  }

  Future<XFile?> convertToPng() async {
    final bytes = await readAsBytes();
    final Image? image = decodeImage(bytes);
    if (image == null) {
      return null;
    }
    return XFile.fromData(encodePng(image));
  }

  Future<String> fileSize({int decimal = 1}) async {
    int bytes = await length();
    if (bytes <= 0) {
      return "0 B";
    }
    const suffixes = ["B", "KB", "MB", "TB", "PB", "EB", "ZB", "YB"];
    final index = (log(bytes) / log(1024)).floor();
    return "${(bytes / pow(1024, index)).toStringAsFixed(decimal)} ' ' ${suffixes[index]}";
  }

  Future<Size> imageSize() async {
    final bytes = await readAsBytes();
    final Image? image = decodeImage(bytes);
    if (image == null) {
      return Size.zero;
    }
    return Size(image.width.toDouble(), image.height.toDouble());
  }

  Future<XFile> compressImage({int quality = 70, int? minHeight, int? minWidth, int rotate = 0}) async {
    final bytes = await readAsBytes();
    int height = 0;
    int width = 0;
    if (minHeight == null || minWidth == null) {
      final size = await imageSize();
      width = size.width.toInt();
      height = size.height.toInt();
    } else {
      width = minWidth;
      height = minHeight;
    }
    if(kIsWeb){
      FFmpeg? ffmpeg;
      try {
        ffmpeg = createFFmpeg(CreateFFmpegParam(log: true));
        ffmpeg.setLogger(_onLogHandler);
        ffmpeg.setProgress(_onProgressHandler);

        // Check ffmpeg.isLoaded() before ffmpeg.load() if you are reusing the same instance
        if (!ffmpeg.isLoaded()) {
          await ffmpeg.load();
        }

        const inputFile = 'input.mp4';
        const outputFile = 'output.mp4';

        ffmpeg.writeFile(inputFile, bytes);

        // Equals to: await ffmpeg.run(['-i', inputFile, '-s', '1920x1080', outputFile]);
        await ffmpeg.runCommand('-i $inputFile -s 1920x1080 $outputFile');

        final data = ffmpeg.readFile(outputFile);
        return XFile.fromData(data);
      } finally {
        // Do not call exit if you want to reuse same ffmpeg instance
        // When you call exit the temporary files are deleted from MEMFS
        // If you are working with multiple inputs you can free any of the via: ffmpeg.unlink('my_input.mp4')
        ffmpeg?.exit();
      }
    }else{
      final result = await FlutterImageCompress.compressWithList(
        bytes,
        minHeight: height,
        minWidth: width,
        quality: quality,
        rotate: rotate,
      );
      return XFile.fromData(result);
    }
  }

  void _onProgressHandler(ProgressParam progress) {
    print('Progress: ${progress.ratio * 100}%');
  }

  static final regex = RegExp(
    r'frame\s*=\s*(\d+)\s+fps\s*=\s*(\d+(?:\.\d+)?)\s+q\s*=\s*([\d.-]+)\s+L?size\s*=\s*(\d+)\w*\s+time\s*=\s*([\d:\.]+)\s+bitrate\s*=\s*([\d.]+)\s*(\w+)/s\s+speed\s*=\s*([\d.]+)x',
  );

  void _onLogHandler(LoggerParam logger) {
    if (logger.type == 'fferr') {
      final match = regex.firstMatch(logger.message);

      if (match != null) {
        // indicates the number of frames that have been processed so far.
        final frame = match.group(1);
        // is the current frame rate
        final fps = match.group(2);
        // stands for quality 0.0 indicating lossless compression, other values indicating that there is some lossy compression happening
        final q = match.group(3);
        // indicates the size of the output file so far
        final size = match.group(4);
        // is the time that has elapsed since the beginning of the conversion
        final time = match.group(5);
        // is the current output bitrate
        final bitrate = match.group(6);
        // for instance: 'kbits/s'
        final bitrateUnit = match.group(7);
        // is the speed at which the conversion is happening, relative to real-time
        final speed = match.group(8);

        debugPrint('frame: $frame, fps: $fps, q: $q, size: $size, time: $time, bitrate: $bitrate$bitrateUnit, speed: $speed');
      }
    }
  }
}
