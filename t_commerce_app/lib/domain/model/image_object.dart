import 'dart:typed_data';

import 'package:multi_image_picker/multi_image_picker.dart';

class ImageForSaveObject {
  final Asset? asset;
  final Uint8List memory;

  ImageForSaveObject({this.asset, required this.memory});
}
