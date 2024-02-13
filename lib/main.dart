import 'package:firebase_core/firebase_core.dart';
import 'package:firedart/firestore/firestore.dart';
import 'package:flutter/material.dart';
import 'next.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Firestore.initialize("shopping-zone-36ab7");
  await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyB_ToipEfexJKHE0jR-FKuo9iMbHtSWsV4",
        appId: "1:121390676895:web:38c2d8c1f7aa087a45dbaa",
        messagingSenderId: "121390676895",
        storageBucket: "shopping-zone-36ab7.appspot.com",
        //databaseURL: "https://pharmacy-app-decf9-default-rtdb.firebaseio.com",
        projectId: "shopping-zone-36ab7",));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: RealtimeDatabaseInsert(),debugShowCheckedModeBanner: false,);
  }
}
