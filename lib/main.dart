import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_app/cubit/app_cubits.dart';
import 'package:health_app/cubit/app_cubits_logic.dart';
import 'package:health_app/screens/homepage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: kIsWeb
          ? FirebaseOptions(
              apiKey: "AIzaSyBv-iU5rmtV9NM9HnNIZF7wIKkMWYfbYx4",
              authDomain: "health-app-ba754.firebaseapp.com",
              projectId: "health-app-ba754",
              storageBucket: "health-app-ba754.appspot.com",
              messagingSenderId: "274105901721",
              appId: "1:274105901721:web:7b5fcc795d175d5748ce08")
          : FirebaseOptions(
              apiKey: "AIzaSyBjbmU-okuhBeJ36s_AewLa_HWr7oi3DUI",
              authDomain: "health-app-ba754.firebaseapp.com",
              projectId: "health-app-ba754",
              storageBucket: "health-app-ba754.appspot.com",
              messagingSenderId: "274105901721",
              appId: "1:274105901721:android:e2c8afaf0258de6c48ce08"));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'first',
        theme: ThemeData(
          primarySwatch: Colors.orange,
        ),
        home: BlocProvider<AppCubits>(
          create: (context) => AppCubits(),
          child: AppCubitLogics(),
        ));
  }
}
