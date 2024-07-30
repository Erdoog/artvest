import 'package:artvest/widgets/charity.dart';
import 'package:artvest/widgets/chat.dart';
import 'package:artvest/widgets/educational_page.dart';
import 'package:artvest/widgets/home_page.dart';
import 'package:artvest/widgets/nodes-test.dart';
import 'package:artvest/widgets/post_test.dart';
import 'package:artvest/widgets/registration_page.dart';
import 'package:artvest/widgets/chart_page.dart';
import 'package:artvest/widgets/sign-in_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  await dotenv.load(fileName: "lib/.env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      themeMode: ThemeMode.system,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0x00000000),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        // scaffoldBackgroundColor: const Color(0x00000033),
        // colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        primaryColor: Colors.white,
        useMaterial3: true,
      ),
      // home: ChartPage(),
      home: VideoPage(),
    );
  }
}
