import 'dart:io';
import 'package:image/image.dart';

Future<File> cropImage({
  required File file,
  required double aspectRatio,
}) async {
  final bytes = file.readAsBytesSync();
  Image? image = decodeImage(bytes);
  if (image == null) return file;
  const extraWidth = 26;
  final width = image.width - 26;
  final height = width / aspectRatio;
  final x = (extraWidth / 2).floor();
  final y = ((image.height / 2) - height / 2).floor();
  var thumbnail = copyCrop(image, x: x,y: y,width: width.ceil(),height: height.ceil(),);
  return file.writeAsBytes(encodePng(thumbnail));
}