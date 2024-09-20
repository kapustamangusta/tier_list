import 'package:flutter/material.dart';
import 'package:tier_list_maker/categories/categories.dart';

class TierListApp extends StatelessWidget {
  const TierListApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var primaryColor = const Color(0xffFFB422);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: primaryColor,
        cardColor: Colors.white,
        appBarTheme: AppBarTheme(
          scrolledUnderElevation: 0.0,
          centerTitle: true,
          backgroundColor: Colors.white,
          titleTextStyle: const TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
          actionsIconTheme: IconThemeData(color: primaryColor, size: 30),
        ),
        scaffoldBackgroundColor: const Color(0xffEFF1F3),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const CategoriesPage(),
    );
  }
}
