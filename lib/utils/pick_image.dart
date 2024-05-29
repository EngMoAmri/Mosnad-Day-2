
import 'package:image_picker/image_picker.dart';

Future<XFile?> pickImage(context, ImageSource source) async {
  final ImagePicker picker = ImagePicker();
  // Pick an image.
  return await picker.pickImage(
      source: source,
      imageQuality: 80,
      maxHeight: 1024,
      maxWidth: 1024);

}