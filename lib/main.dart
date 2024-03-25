import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_demo/view/home.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

// ====================================================================
Future<void> backgroundHandler(RemoteMessage message) async {
  print(message.data.toString());
  print(message.notification!.title);
}

// ====================================================================

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Platform.isAndroid
      ? await Firebase.initializeApp(
          options: const FirebaseOptions(
          apiKey:
              "AIzaSyBzd6OgdA0TazDw5a10qOqNAb2D9OeIqnw", // google-services.json
          appId:
              "1:243115152439:android:cad99fc2e3112f43bb9bb2", // firebase --> project setting --> general
          messagingSenderId:
              "243115152439", // firebase --> project setting --> Cloud messaging
          projectId:
              "flutter-demo-5d4c2", // firebase --> project setting --> general
          storageBucket:
              "flutter-demo-5d4c2.appspot.com", // google-services.json
        ))
      : await Firebase.initializeApp();

  runApp(const MyApp());
}

// ====================================================================
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Home(),
    );
  }
}
