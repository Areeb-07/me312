import 'package:flutter/material.dart';
import 'package:me312/header.dart';
import 'package:me312/report.dart';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:me312/report_page.dart';
import 'package:me312/report_row.dart';
import 'package:me312/file_storage.dart';
import 'dart:math';
import 'package:me312/colors.dart' as color;
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:printing/printing.dart';

class Intermediate extends StatefulWidget {
  final Map data;
  const Intermediate({super.key, required this.data});

  @override
  State<Intermediate> createState() => _IntermediateState();
}

class _IntermediateState extends State<Intermediate> {

  Future<void> getValues({
    required double rf,
    required double tax,
    required double betaUnlev,
    required double erp,
    required double ebit,
    required double equity,
    required double coc,
    required String cashFlows,

  }) async {
    String uri = 'http://10.0.2.2:8000';
    try {
      http.Response response = await http.post(
          Uri.parse('$uri/optimise'),
          body: jsonEncode({
            "rf": rf,
            "tax": tax,
            "beta_unlev": betaUnlev,
            "erp": erp,
            "ebit": ebit,
            "equity": equity,
            "coc": coc,
            "cash_flows": cashFlows
          }),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          }
      );
      Map value = jsonDecode(response.body);
      final netImage = await networkImage("http://10.0.2.2:8000${value['img']}");
      final valueImage = await networkImage("http://10.0.2.2:8000${value['value_img']}");
      final pw.Document pdf = pw.Document();
      final bytes = await rootBundle.load('assets/report.jpg');
      final byteList = bytes.buffer.asUint8List();
      pdf.addPage(
          pw.Page(
              margin: const pw.EdgeInsets.all(0),
              pageFormat: PdfPageFormat.a4,
              build: (context) {
                return ReportPage(
                    [
                      pw.SizedBox(height: 20),
                      ReportRow("Company Name", [widget.data['name']]),
                      ReportRow("Current Value of Company", [calculateValue(widget.data['cash_flow'], widget.data['coc'])]),
                      ReportRow("Optimisation", []),
                      pw.Image(netImage),
                    ],
                    byteList
                );
              }
          )
      );
      pdf.addPage(
          pw.Page(
              margin: const pw.EdgeInsets.all(0),
              pageFormat: PdfPageFormat.a4,
              build: (context) {
                return ReportPage(
                    [
                      pw.Image(valueImage),
                      ReportRow("Debt to Equity Ratio for Optimised COC", [(value["d"]/widget.data["equity"]).toStringAsFixed(3)]),
                      ReportRow("Optimised Cost of Capital", [value["coc"].toStringAsFixed(3)]),
                      ReportRow("Optimised Value of Company", [calculateValue(widget.data['cash_flow'], value["coc"])]),
                      ReportRow("Increase in Value of Company", [(double.parse(calculateValue(widget.data['cash_flow'], value["coc"])) - double.parse(calculateValue(widget.data['cash_flow'], widget.data['coc']))).toStringAsFixed(3)]),
                      ReportRow("If the firm's D/E deviates too much from optimal,\nit becomes acquisition target", [""]),
                    ],
                    byteList
                );
              }
          )
      );

      FileStorage.writeCounter(await pdf.save(), widget.data['name']);
      final tempPath = '${(await getTemporaryDirectory()).path}/report.pdf';
      final tempFile = File(tempPath);
      await tempFile.create(recursive: true);
      await tempFile.writeAsBytes(await pdf.save());

      widget.data['d/e'] = value["d"]/widget.data["equity"];

      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Report(path: tempPath, data: widget.data,)
        ),
      );
    } catch (e) {
      print(e);
    }
  }

  String calculateValue(String cashFlows, double coc) {
    List<double> cashFlowsList = cashFlows.split(',').map((e) => double.parse(e.trim())).toList();
    double value = 0;
    for (int i = 0; i < cashFlowsList.length; i++) {
      value += cashFlowsList[i]/pow(1 + coc, i);
    }
    return value.toStringAsFixed(3);
  }

  Future<void> generateReport() async {
    getValues(rf: widget.data['rf'], tax: widget.data['tax'], betaUnlev: widget.data['beta'], erp: widget.data['erp'], ebit: widget.data['ebit'], equity: widget.data['equity'], coc: widget.data['coc'], cashFlows: widget.data['cash_flow']);
  }

  @override
  void initState() {
    super.initState();
    generateReport();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: color.AppColor.formBackground,
        body: SafeArea(
            child: SingleChildScrollView(
                child: SizedBox(
                    height: MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top,
                    child: Column(
                        children: [
                          const Header(),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                const Image(
                                  image: AssetImage("assets/tick.png"),
                                  width: 320,
                                ),
                                Text(
                                  "Great things take time",
                                  style: TextStyle(
                                    fontSize: 22,
                                    color: color.AppColor.finalText,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                Text(
                                  "Please wait while\nyour report is being generated",
                                  style: TextStyle(
                                    fontSize: 22,
                                    color: color.AppColor.finalText,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ]
                    )
                )
            )
        )
    );
  }
}