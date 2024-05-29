import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mosnad_flutter/views/main_page.dart';

import 'database/my_database.dart';

void main() async{
  await MyDatabase.open();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'برنامج صيانة الهاتف المحمول',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MainPage(),
    );
  }
}
