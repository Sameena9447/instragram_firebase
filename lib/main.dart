import 'package:flutter/material.dart';
import 'package:instragram_firebase/responsive/mobile_screen_layout.dart';
import 'package:instragram_firebase/responsive/responsive_layout_screen.dart';
import 'package:instragram_firebase/responsive/web_screen_layout.dart';
import 'package:instragram_firebase/screens/sample.dart';
import 'package:instragram_firebase/utils/colors.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'providers/user_provider.dart';
import 'screens/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserProvider(),
        ),
      ],
      child: MaterialApp(
          title: 'Instagram Clone',
          debugShowCheckedModeBanner: false,
          theme: ThemeData.dark()
              .copyWith(scaffoldBackgroundColor: mobileBackgroundColor),
          home: LoginScreen()

          //  const ResponsiveLayout(
          //   mobileScreenLayout: MobileScreenLayout(),
          //   weScreeenLayout: WebScreenLayout(),
          // )
          ),
    );
  }
}
