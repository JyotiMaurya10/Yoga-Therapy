import 'package:flutter/material.dart';
import 'Screens/home_screen.dart';
// import 'Screens/ruReady.dart';
// import 'Screens/start.dart';
// import 'Screens/finish.dart';
// import 'Screens/break.dart';
// import 'Screens/workout.dart';
// import 'Services/yogadb.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // await YogaDatabase.instance.database;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Yoga Therapy',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      //  home: const StartUp(),
      // home: const FinishScreen(),
      home: const Home(),
      // home: const BreakScreen(),
      // // home: const rUready(),
    );
  }
}
