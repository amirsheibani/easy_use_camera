import 'dart:math';
import 'dart:ui';

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
