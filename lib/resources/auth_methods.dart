import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instragram_firebase/models/user.dart' as model;
import 'package:instragram_firebase/resources/storage.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path/path.dart';

class AuthMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String? downloadUrl;
  // get user details
  Future<model.User> getUserDetails() async {
    User currentUser = _auth.currentUser!;
    log("user ==" + currentUser.toString());
    DocumentSnapshot documentSnapshot =
        await _firestore.collection('users').doc(currentUser.uid).get();
    log("model ===" + documentSnapshot.toString());
    return model.User.fromSnap(documentSnapshot);
  }

  // Signing Up User

  Future<String> signUpUser({
    required String email,
    required String password,
    required String username,
    required String bio,
    required File file,
  }) async {
    String res = "Some error Occurred";
    try {
      if (email.isNotEmpty ||
          password.isNotEmpty ||
          username.isNotEmpty ||
          bio.isNotEmpty ||
          file != null) {
        // registering user in auth with email and password
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        // String photoUrl = await StorageMethods()
        //     .uploadImageToStorage('profilePics', Uint8List(3), false);
        final fileName = basename(file.path);
        final destination = 'profilePics/$fileName';

        try {
          final ref =
              firebase_storage.FirebaseStorage.instance.ref(destination);
          // .child('profile/');
          TaskSnapshot taskSnapshot = await ref.putFile(file);
          downloadUrl = await taskSnapshot.ref.getDownloadURL();
        } catch (e) {
          print('error occured');
        }
        // TaskSnapshot taskSnapshot = await storage.ref('$path/$imageName').putFile(file);
        log("download url ==" + downloadUrl.toString());
        model.User user = model.User(
          username: username,
          uid: cred.user!.uid,
          photoUrl: downloadUrl!,
          // "https://i.stack.imgur.com/l60Hf.png",
          email: email,
          bio: bio,
          followers: [],
          following: [],
        );

        // adding user in our database
        await _firestore
            .collection("users")
            .doc(cred.user!.uid)
            .set(user.toJson());

        res = "success";
      } else {
        res = "Please enter all the fields";
      }
    } catch (err) {
      return err.toString();
    }
    return res;
  }

  // logging in user
  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    String res = "Some error Occurred";
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        // logging in user with email and password
        await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        res = "success";
      } else {
        res = "Please enter all the fields";
      }
    } catch (err) {
      return err.toString();
    }
    return res;
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
