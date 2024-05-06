import 'package:flutter/services.dart';
import 'package:pdf/widgets.dart' as pw;

class ReportRow extends pw.StatelessWidget {
  final String title;
  final List content;
  ReportRow(this.title, this.content);

  @override
  pw.Widget build(pw.Context context) {
    return pw.Container(
        child: pw.Row(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text("$title:", style: const pw.TextStyle(fontSize: 22)),
              pw.SizedBox(width: 20),
              pw.Expanded(
                  child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: content.map((e) => pw.Text(e, style: const pw.TextStyle(fontSize: 22))).toList()
                  )
              )
            ]
        )
    );
  }
}
