import 'dart:typed_data';
import 'package:pdf/widgets.dart' as pw;

class ReportPage extends pw.StatelessWidget {
  final List<pw.Widget> widgetList;
  final Uint8List byteList;
  ReportPage(this.widgetList, this.byteList);

  @override
  pw.Widget build(pw.Context context) {
    return pw.Container(
        padding: const pw.EdgeInsets.symmetric(horizontal: 55, vertical: 120),
        decoration: pw.BoxDecoration(
          image: pw.DecorationImage(
            image: pw.MemoryImage(byteList),
          ),
        ),
        child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
            children: widgetList
        )
    );
  }
}
