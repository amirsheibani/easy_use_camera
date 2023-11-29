import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:image/image.dart';

enum ConvertType {
  jpg,
  png,
}

Future<File?> cropImageAndConvert({File? file, Uint8List? bytes, required double aspectRatio, ConvertType? convertType = ConvertType.jpg}) async {
  Uint8List? _bytes;
  if (file != null) {
    _bytes = file.readAsBytesSync();
  } else if (bytes != null) {
    _bytes = bytes;
  }
  Image? image = decodeImage(_bytes!);
  if (image == null) return file ?? File.fromRawPath(bytes!);

  const extraWidth = 26;
  final width = image.width - 26;
  final height = width / aspectRatio;
  final x = (extraWidth / 2).floor();
  final y = ((image.height / 2) - height / 2).floor();
  var thumbnail = copyCrop(image, x: x, y: y, width: width.ceil(), height: height.ceil());
  if (file != null) {
    if (convertType == ConvertType.jpg) {
      return file.writeAsBytes(encodeJpg(thumbnail));
    } else {
      return file.writeAsBytes(encodePng(thumbnail));
    }
  } else {
    if (convertType == ConvertType.jpg) {
      return File.fromRawPath(encodeJpg(thumbnail));
    } else {
      return File.fromRawPath(encodePng(thumbnail));
    }
  }
}
