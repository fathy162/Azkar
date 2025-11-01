import 'package:flutter/material.dart'; // استيراد فلاتر مادتيريال
import 'package:zekr/zekr_item.dart';

import 'data.dart'; // ويدجت لعرض عنصر الذكر

class ShowAzkar extends StatelessWidget {
  // صفحة عرض الأذكار لقسم معين
  final String category; // اسم القسم اللي جاي من الشاشة الرئيسية

  const ShowAzkar({
    super.key,
    required this.category,
  }); // كونستركتور بياخد الcategory

  Future<List> zekr() async {
    // دالة بترجع الاذكار اللي بتنتمي للقسم ده
    final data = await loadData(); // نحمل كل الداتا

    return data
        .where((e) => e['category'] == category)
        .toSet()
        .toList(); // نفرز العناصر اللي بتطابق الcategory ونشيل التكرارات
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      // نخلي الاتجاه من اليمين لليسار
      textDirection: TextDirection.rtl,
      child: Scaffold(
      appBar: AppBar(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
          ),

        title: Text(
            category, // اسم القسم في العنوان
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: FutureBuilder(
            // بنعرض لودر لحد ما نجيب الاذكار
          future: zekr(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
                return Center(child: CircularProgressIndicator()); // لودر
            }
              final zekr = snapshot.data!; // داتا الاذكار بعد التحميل

            return ListView.builder(
                // قائمة الاذكار
              itemCount: zekr.length,

              itemBuilder: (context, index) {
                  final item = zekr[index]; // العنصر الحالي
                  return ZekrItem(item: item); // ويدجت جاهز لعرض كل ذكر
              },
            );
          },
          ),
        ),
      ),
    );
  }
}
