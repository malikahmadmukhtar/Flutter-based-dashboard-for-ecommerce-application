import 'package:firebase_core/firebase_core.dart';
import 'package:firedart/firestore/firestore.dart';
import 'package:flutter/material.dart';
import 'next.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Firestore.initialize("shopping-zone-36ab7");
  await Firebase.initializeApp(
      options: const FirebaseOptions(
        //add your firebase api here
        )
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: RealtimeDatabaseInsert(),debugShowCheckedModeBanner: false,);
  }
}
