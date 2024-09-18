import 'package:flutter/material.dart';
import 'package:tier_list_maker/categories/categories.dart';

class TierListApp extends StatelessWidget {
  const TierListApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xffEFF1F3),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const CategoriesPage(),
    );
  }
}
