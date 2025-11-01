import 'package:flutter/material.dart'; // استيراد Widgets بتاعة Material

class ZekrItem extends StatelessWidget {
  // ويدجت لعرض عنصر الذكر داخل لست
  final Map<String, dynamic> item; // الخريطة اللي بتمثل الذِكر وبياناته

  const ZekrItem({super.key, required this.item}); // كونستركتور بياخد الـ item

  @override
  Widget build(BuildContext context) {
    return Card(
      // كارد لكل ذكر
      margin: EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 12,
      ), // المسافات حول الكارت
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ), // حواف دائرية
      elevation: 4, // ارتفاع الظل
      child: Padding(
        padding: const EdgeInsets.all(16.0), // حشوة جوه الكارت
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // محاذاة المحتوى لليسار
          children: [
            Text(
              item['zekr'], // نص الذِكر نفسه
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ), // ستايل النص
            ),

            SizedBox(height: 10), // فاصل

            if (item['description'] != null &&
                item['description'].toString().isNotEmpty)
              Text(
                // لو فيه وصف نعرضه
                item['description'],
                style: TextStyle(fontSize: 14, color: Colors.grey[700]),
              ),

            SizedBox(height: 10), // فاصل تاني

            if (item['reference'] != null &&
                item['reference'].toString().isNotEmpty)
              Text(
                // لو فيه مرجع نعرضه مع ايقونة كتاب
                "📖 ${item['reference']}",
                style: TextStyle(fontSize: 12, color: Colors.blueGrey),
              ),

            SizedBox(height: 10), // فاصل
            Align(
              alignment: Alignment.bottomRight, // العداد في الزاوية اليمين تحت
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ), // حشوة حوالين العداد
                decoration: BoxDecoration(
                  color: Colors.green[400], // خلفية بسيطة
                  borderRadius: BorderRadius.circular(12), // حواف دائرية بسيطة
                ),
                child: Text(
                  item['count'] == "" ? "1" : item['count'].toString(),

                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w900),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
