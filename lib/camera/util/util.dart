import 'dart:io';
import 'package:image/image.dart';

enum ConvertType{
  jpg,png,
}
Future<File> cropImageAndConvert({
  required File file,
  required double aspectRatio,
  ConvertType? convertType = ConvertType.jpg,
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
  if(convertType == ConvertType.jpg){
    return file.writeAsBytes(encodeJpg(thumbnail));
  }else{
    return file.writeAsBytes(encodePng(thumbnail));
  }
}