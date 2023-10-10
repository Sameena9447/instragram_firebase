import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instragram_firebase/providers/user_provider.dart';
import 'package:instragram_firebase/resources/firestore_methods.dart';
import 'package:instragram_firebase/utils/colors.dart';
import 'package:instragram_firebase/utils/utils.dart';
import 'package:provider/provider.dart';

class AddPostScreen extends StatefulWidget {
  final String uid;
  AddPostScreen({required this.uid});

  @override
  _AddPostScreenState createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  // Uint8List? _file;
  File? imageURI;

  Future getImageFromGallery() async {
    var image = await ImagePicker().pickImage(source: ImageSource.gallery);
    //  (source: ImageSource.camera);
    final imageTemporary = File(image!.path);
    setState(() {
      imageURI = imageTemporary;
    });
  }

  Future getImageFromCamera() async {
    var image = await ImagePicker().pickImage(source: ImageSource.camera);
    //  (source: ImageSource.camera);
    final imageTemporary = File(image!.path);
    setState(() {
      imageURI = imageTemporary;
    });
  }

  bool isLoading = false;
  final TextEditingController _descriptionController = TextEditingController();

  _selectImage(BuildContext parentContext) async {
    return showDialog(
      context: parentContext,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: const Text('Create a Post'),
          children: <Widget>[
            SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text('Take a photo'),
                onPressed: () async {
                  getImageFromCamera();
                  Navigator.pop(context);

                  //  Uint8List file = await pickImage(ImageSource.camera);
                  // setState(() {
                  //   _file = file;
                  // });
                }),
            SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text('Choose from Gallery'),
                onPressed: () async {
                  getImageFromGallery();
                  Navigator.of(context).pop();
                  // Uint8List file = await pickImage(ImageSource.gallery);
                  // setState(() {
                  //   _file = file;
                  // });
                }),
            SimpleDialogOption(
              padding: const EdgeInsets.all(20),
              child: const Text("Cancel"),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        );
      },
    );
  }

  void postImage(String uid, String username, String profImage) async {
    setState(() {
      isLoading = true;
    });
    // start the loading
    try {
      // upload to storage and db
      String res = await FireStoreMethods().uploadPost(
        _descriptionController.text,
        imageURI!,
        uid,
        username,
        profImage,
      );
      if (res == "success") {
        setState(() {
          isLoading = false;
        });

        showSnackBar(
          context,
          'Posted!',
        );

        clearImage();
      } else {
        showSnackBar(context, res);
      }
    } catch (err) {
      setState(() {
        isLoading = false;
      });
      showSnackBar(
        context,
        err.toString(),
      );
    }
  }

  void clearImage() {
    setState(() {
      imageURI = null;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _descriptionController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);
    // log("email --------------------" + userProvider.getUser.email.toString());
    return imageURI == null
        ? Center(
            child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                _selectImage(context);
              },
              child: Container(
                width: 200,
                height: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Color.fromARGB(54, 255, 255, 255)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Select post"),
                      SizedBox(
                        width: 10,
                      ),
                      Icon(
                        Icons.upload,
                      )
                    ],
                  ),
                ),
              ),
            ),
          )

            //  IconButton(
            //   icon: const Icon(
            //     Icons.upload,
            //   ),
            //   onPressed: () => _selectImage(context),
            // ),
            )
        : StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('users')
                .where('uid', isEqualTo: widget.uid)
                .snapshots(),
            builder: (context, snapshot) {
              var order = snapshot.data?.docs;
              return Scaffold(
                appBar: AppBar(
                  backgroundColor: mobileBackgroundColor,
                  leading: IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: clearImage,
                  ),
                  title: const Text(
                    'Post to',
                  ),
                  centerTitle: false,
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => postImage(
                        // snapshot.data?.docs[0][''],
                        widget.uid,
                        snapshot.data?.docs[0]['username'],
                        snapshot.data?.docs[0]['photoUrl'],
                        // userProvider.getUser.uid,
                        // userProvider.getUser.username,
                        // userProvider.getUser.photoUrl,
                      ),
                      child: const Text(
                        "Post",
                        style: TextStyle(
                            color: Colors.blueAccent,
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0),
                      ),
                    )
                  ],
                ),
                // POST FORM
                body: Column(
                  children: <Widget>[
                    isLoading
                        ? const LinearProgressIndicator()
                        : const Padding(padding: EdgeInsets.only(top: 0.0)),
                    const Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        // CircleAvatar(
                        //     backgroundImage:
                        //         NetworkImage(snapshot.data?.docs[0]['photoUrl'])
                        //     // userProvider.getUser.photoUrl,
                        //     // "https://firebasestorage.googleapis.com/v0/b/clone-cf0c8.appspot.com/o/profilePics%2FScreenshot_20230803-211012_Google.jpg?alt=media&token=f52c3e74-85aa-4603-8143-c1f228e683c8"),
                        //     ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.3,
                          child: TextField(
                            controller: _descriptionController,
                            decoration: const InputDecoration(
                                hintText: "Write a caption...",
                                border: InputBorder.none),
                            maxLines: 8,
                          ),
                        ),
                        SizedBox(
                          height: 45.0,
                          width: 45.0,
                          child: AspectRatio(
                            aspectRatio: 487 / 451,
                            child: Container(
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                fit: BoxFit.fill,
                                alignment: FractionalOffset.topCenter,
                                image: FileImage(imageURI!),
                              )),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Divider(),
                  ],
                ),
              );
            },
          );
  }
}
