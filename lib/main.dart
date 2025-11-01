import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:zekr/theme_provider.dart';

import 'azkar_screen.dart';
import 'data.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await loadData();

  // Create ThemeProvider and load saved theme before running the app
  final themeProvider = ThemeProvider();
  await themeProvider.loadTheme();

  runApp(
    // شغّل التطبيق
    ChangeNotifierProvider(
      // وفر ThemeProvider لكل شجرة الواجهه
      create: (_) => ThemeProvider(), // انشاء نسخة من ThemeProvider
      child: const MyApp(), // الواجهة اللي هنستخدمها كجذر
    ),
  );
}

class MyApp extends StatelessWidget {
  // الويجدج الاساسي للتطبيق
  const MyApp({super.key}); // الكونستركتور

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      // نستخدم Consumer علشان نتابع تغييرات ThemeProvider
      builder: (context, themeProvider, child) {
        return MaterialApp(
          // الـ MaterialApp اللي بيحط الموارد بتاعة Material لل app كله
          debugShowCheckedModeBanner: false, // اخفاء شارة الـ debug
          themeAnimationCurve:
              Curves.fastEaseInToSlowEaseOut, // تأثيرات تغيير الثيم
          title: "أذكارى", // عنوان التطبيق
          themeMode:
              themeProvider
                  .isDarkMode // استخدام الحالة من ThemeProvider
              ? ThemeMode
                    .dark // لو true يبقى دارك
              : ThemeMode.light, // غير كده لايت
          theme: ThemeData(
            // تعريف الثيم الفاتح
            primarySwatch: Colors.blue, // لون اساسي
            scaffoldBackgroundColor: Colors.white, // خلفية الشاشات
            appBarTheme: AppBarTheme(
              backgroundColor: Colors.blue,
            ), // ستايل الاب بار
            cardTheme: const CardThemeData(
              color: Colors.white,
            ), // ستايل للكارطات (مودرن)
          ),
          darkTheme: ThemeData(
            // تعريف الثيم الداكن
            brightness: Brightness.dark, // اضاءة داكنة
            primarySwatch: Colors.blueGrey, // لون اساسي للداكن
            scaffoldBackgroundColor: Color(0XFF0A0E21), // خلفية داكنة
            appBarTheme: AppBarTheme(
              backgroundColor: const Color.fromARGB(
                255,
                20,
                30,
                63,
              ), // لون الاب بار في الداكن
            ),
            cardTheme: const CardThemeData(
              color: Color(0xFF1D1E33),
            ), // لون الكارت في الداكن
          ),
          home: const AzkarScreen(), // الشاشة الرئيسية
        );
      },
    );
  }
}
