import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:instragram_firebase/screens/add_post_screen.dart';
import 'package:instragram_firebase/screens/feed_screen.dart';
import 'package:instragram_firebase/screens/notification.dart';
import 'package:instragram_firebase/screens/profile_screen.dart';
import 'package:instragram_firebase/screens/search_screen.dart';

const webScreenSize = 600;

List<Widget> homeScreenItems = [
  FeedScreen(
    uid: FirebaseAuth.instance.currentUser!.uid,
  ),
  const SearchScreen(),
  AddPostScreen(
    uid: FirebaseAuth.instance.currentUser!.uid,
  ),
  NotificationScreen(),
  ProfileScreen(
    uid: FirebaseAuth.instance.currentUser!.uid,
  ),
];
