import 'package:flutter/material.dart';
import 'package:me312/form_text.dart';
import 'package:me312/intermediate.dart';
import 'package:me312/screen.dart';

class ApexForm extends StatefulWidget {
  const ApexForm({super.key});

  @override
  State<ApexForm> createState() => _ApexFormState();
}

class _ApexFormState extends State<ApexForm> {
  
  final TextEditingController nameController = TextEditingController();
  final TextEditingController cashFlowController = TextEditingController();
  final TextEditingController cocController = TextEditingController();
  final TextEditingController rfController = TextEditingController();
  final TextEditingController taxController = TextEditingController();
  final TextEditingController betaController = TextEditingController();
  final TextEditingController erpController = TextEditingController();
  final TextEditingController ebitController = TextEditingController();
  final TextEditingController equityController = TextEditingController();
  final TextEditingController currentDebtController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    cashFlowController.dispose();
    cocController.dispose();
    rfController.dispose();
    taxController.dispose();
    betaController.dispose();
    erpController.dispose();
    ebitController.dispose();
    equityController.dispose();
    currentDebtController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    rfController.text = "7.062";
    erpController.text = "4.702";
  }

  @override
  Widget build(BuildContext context) {
    return Screen(
        widgetList: [
          FormTextField(
              controller: nameController,
              hint: "Name",
              title: "Name of the Company"
          ),
          FormTextField(
              controller: cashFlowController,
              title: "Cash Flows (separated with ' , ')",
              hint: "Cash Flows",
              numeric: true,
          ),
          FormTextField(
              controller: cocController,
              title: "Current Cost of Capital",
              hint: "Cost of Capital",
              numeric: true,
          ),
          FormTextField(
              controller: rfController,
              title: "Risk Free Rate (%)",
              hint: "Risk Free Rate",
              numeric: true,
          ),
          FormTextField(
              controller: taxController,
              title: "Tax Rate (%)",
              hint: "Tax Rate",
              numeric: true,
          ),
          FormTextField(
              controller: betaController,
              title: "Beta Unlevered",
              hint: "Beta Unlevered",
              numeric: true,
          ),
          FormTextField(
              controller: erpController,
              title: "Equity Risk Premium (%)",
              hint: "ERP",
              numeric: true,
          ),
          FormTextField(
              controller: ebitController,
              title: "Earnings Before Interest and Taxes (INR Crores)",
              hint: "EBIT",
              numeric: true,
          ),
          FormTextField(
              controller: equityController,
              title: "Equity (INR Crores)",
              hint: "Equity",
              numeric: true,
          ),
          FormTextField(
            controller: currentDebtController,
            title: "Current Debt of the Firm (INR Crores)",
            hint: "Current Debt",
            numeric: true,
          ),
        ],
        title: "Company Information",
        onSubmit: () {
          Map data = {};
          data['name'] = nameController.text.toString();
          data['cash_flow'] = cashFlowController.text.toString();
          data['coc'] = double.parse(cocController.text.toString());
          data['rf'] = double.parse(rfController.text.toString());
          data['tax'] = double.parse(taxController.text.toString()) / 100;
          data['beta'] = double.parse(betaController.text.toString());
          data['erp'] = double.parse(erpController.text.toString());
          data['ebit'] = double.parse(ebitController.text.toString());
          data['equity'] = double.parse(equityController.text.toString());
          data['current_debt'] = double.parse(currentDebtController.text.toString());

          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Intermediate(data: data)
            ),
          );
        }
    );
  }
}
