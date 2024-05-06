import 'package:flutter/material.dart';
import 'package:me312/colors.dart' as color;
import 'package:me312/header.dart';

class Screen extends StatefulWidget {
  final String title;
  final List<Widget> widgetList;
  final VoidCallback onSubmit;
  const Screen({super.key, required this.widgetList, required this.title, required this.onSubmit});

  @override
  State<Screen> createState() => _ScreenState();
}

class _ScreenState extends State<Screen> {
  final formKey = GlobalKey<FormState>();

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
                Container(
                  padding: const EdgeInsets.only(left: 22, right: 22, top: 40, bottom: 10),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top -  180,
                  child: ListView(
                    children: [
                      Text(
                        widget.title,
                        style: TextStyle(
                            fontSize: 18,
                            color: color.AppColor.workerLoginCard,
                            fontWeight: FontWeight.w600
                        ),
                      ),
                      const SizedBox(height: 30,),
                      Form(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 7),
                          child: Form(
                            key: formKey,
                            child: Column(
                              children: widget.widgetList,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Center(
                  child: ElevatedButton(
                    onPressed: (){
                      if (formKey.currentState!.validate()) widget.onSubmit();
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(140, 39),
                      backgroundColor: color.AppColor.workerLoginButton,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)
                      ),
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                    ),
                    child: const Text(
                      "Submit",
                      style: TextStyle(
                          fontSize: 13,
                          color: Colors.white
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
