import 'dart:typed_data';

import 'package:multi_image_picker/multi_image_picker.dart';

class ImageObject {
  final Asset? asset;
  final Uint8List memory;

  ImageObject({this.asset, required this.memory});
}
