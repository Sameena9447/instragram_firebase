import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';

// for picking up image from gallery
// pickImage(ImageSource source) async {
//   final ImagePicker imagePicker = ImagePicker();
//   XFile? file = await imagePicker.pickImage(source: source);
//   if (file != null) {
//     return await file.readAsBytes();
//   }
// }

//   ImagePicker image = await ImagePicker()
//         .getImage(source: ImageSource.gallery, imageQuality: 50);
//     setState(() {
//       _image = image;
//     });
// }

// for displaying snackbars
showSnackBar(BuildContext context, String text) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(text),
    ),
  );
}
