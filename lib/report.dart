import 'package:flutter/material.dart';
import 'package:me312/main.dart';
import 'package:pdf_viewer_plugin/pdf_viewer_plugin.dart';
import 'package:me312/colors.dart' as color;
import 'package:me312/header.dart';

import 'acquirer_form.dart';

class Report extends StatefulWidget {
  final Map data;
  final String path;
  const Report({super.key, required this.path, required this.data});

  @override
  State<Report> createState() => _ReportState();
}

class _ReportState extends State<Report> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: color.AppColor.formBackground,
        body: SafeArea(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Header(),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                    decoration: const BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 10,
                              color: Colors.black26
                          )
                        ]
                    ),
                    height: 510,
                    child: PdfView(path: widget.path,gestureNavigationEnabled: true,),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 40),
                    child: Center(
                      child: ElevatedButton(
                        onPressed: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AcquirerForm(data: widget.data)
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(180, 40),
                          backgroundColor: color.AppColor.workerLoginButton,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)
                          ),
                          padding: const EdgeInsets.only(top: 10, bottom: 10),
                        ),
                        child: const Text(
                          "Calculate how the acquisition\nwill structure optimally",
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 13,
                              color: Colors.white
                          ),
                        ),
                      ),
                    ),
                  ),
                ]
            )
        )
    );
  }
}
