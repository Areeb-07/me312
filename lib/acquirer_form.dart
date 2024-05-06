import 'package:flutter/material.dart';
import 'package:me312/form_text.dart';
import 'package:me312/screen.dart';

import 'final.dart';

class AcquirerForm extends StatefulWidget {
  final Map data;
  const AcquirerForm({super.key, required this.data});

  @override
  State<AcquirerForm> createState() => _AcquirerFormState();
}

class _AcquirerFormState extends State<AcquirerForm> {

  final TextEditingController acquirerDebtController = TextEditingController();
  final TextEditingController acquirerEquityController = TextEditingController();

  @override
  void dispose() {
    acquirerDebtController.dispose();
    acquirerEquityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Screen(
        widgetList: [
          FormTextField(
            controller: acquirerDebtController,
            title: "Optimal Debt of Acquirer (INR Crores)",
            hint: "Debt of Acquirer",
            numeric: true,
          ),
          FormTextField(
            controller: acquirerEquityController,
            title: "Optimal Equity of Acquirer (INR Crores)",
            hint: "Equity of Acquirer",
            numeric: true,
          ),
        ],
        title: "Company Information",
        onSubmit: () {
          widget.data['acquirer_debt'] = double.parse(acquirerDebtController.text.toString());
          widget.data['acquirer_equity'] = double.parse(acquirerEquityController.text.toString());

          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Final(data: widget.data)
            ),
          );
        }
    );
  }
}
