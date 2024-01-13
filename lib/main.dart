import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:notepadsss/models/note_data.dart';
import 'package:notepadsss/pages/home_page.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox('note_database');

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => NoteData()),
        // Add more providers if needed
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}
