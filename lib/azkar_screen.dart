
import 'package:flutter/cupertino.dart'; // استيراد كلاس الويجدتس بتاعة كيويرتز لو هنستخدم Navigation خاص
import 'package:flutter/material.dart'; // استيراد مكتبة Material علشان Widgets الاساسية
import 'package:provider/provider.dart';
import 'package:zekr/show_azkar.dart';
import 'package:zekr/theme_provider.dart';

import 'data.dart'; // استيراد provider علشان نستخدم Consumer


class AzkarScreen extends StatefulWidget {
  // الويجت بتاع الشاشة الرئيسية و Stateful علشان فيها حالة
  const AzkarScreen({super.key}); // الكونستركتور

  @override
  State<AzkarScreen> createState() => _AzkarScreenState(); // انشاء الستيت
}

class _AzkarScreenState extends State<AzkarScreen> {
  // الستيت الخاص بالشاشة
  bool isDarkMode = false; // متغير قديم ممكن نلغي لكن لسه هنا مش مؤذي

  Future<List<String>> loadCategories() async {
    // دالة بتجيب اقسام الاذكار من الداتا
    final data = await loadData(); // نجيب الداتا من ملف الـ json
    // استخرج أسماء الأقسام من الكاتيجوري من غير تكرار
    final categories = data
        .map((e) => e['category'] as String) // ناخد قيمة الcategory من كل عنصر
        .toSet() // نحولها لمجموعة علشان نشيل التكرار
        .toList(); // نرجعها ليست تاني
    return categories; // نرجع النتيجة
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ال Scaffold اللي بيحتوي AppBar و Body
      appBar: AppBar(
        // الاب بار فوق
        shape: RoundedRectangleBorder(
          // شكل الاب بار مع حواف مستديرة من تحت
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
        ),
        leading: IconButton(
          // الايكون اللي على الشمال عادة للمعلومات
          onPressed: () {
            // Use showDialog so you can control barrierDismissible and the
            // action buttons explicitly. This replaces showAboutDialog when
            // you need to customize or remove the default buttons.
            showDialog<void>(
              context: context,
              barrierDismissible: true,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text(
                    'حول التطبيق',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Center(
                        child: Image.asset(
                          'assets/image.png',
                          width: 60,
                          height: 60,
                        ),
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'أذكارى',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'تطبيق أذكارى يقدم لك مجموعة من الأذكار الإسلامية المفيدة.',
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'جميع الحقوق محفوظة © 2025',
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ],
                  ),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('إغلاق'),
                    ),
                  ],
                );
              },
            );
          },
          icon: const Icon(Icons.info_outline),
        ),
        actions: [
          Consumer<ThemeProvider>(
            builder: (context, themeProvider, child) {
              return Switch(
                value: themeProvider.isDarkMode,
                onChanged: (bool value) {
                  themeProvider.toggleTheme();

                },
              );
            },
          ),
        ],
        title: Text(
          "أذكارى",
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),

      body: Directionality(
        textDirection: TextDirection.rtl,
        child: FutureBuilder(
          future: loadCategories(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }
            final categories = snapshot.data!;

            //<<====================================================================>>

            return ListView.builder(
              itemCount: categories.length,
              itemBuilder: ((context, index) {
                final category = categories[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (context) => ShowAzkar(category: category),
                      ),
                    );
                  },
                  child: Card(
                    margin: EdgeInsets.symmetric(vertical: 20, horizontal: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 4,

                    child: Padding(
                      padding: const EdgeInsets.all(25.0),
                      child: Text(
                        textAlign: TextAlign.center,
                        category,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                );
              }),
            );
          },
        ),
      ),
    );
  }
}
