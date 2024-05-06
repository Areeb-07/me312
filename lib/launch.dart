import 'package:flutter/material.dart';
import 'package:me312/colors.dart' as color;
import 'package:me312/form.dart';

class Launch extends StatelessWidget {
  const Launch({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Image(
                  image: AssetImage('assets/launch.png'),
                ),
                Center(
                  child: ElevatedButton(
                    onPressed: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ApexForm(),
                        ),
                      );
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
                      "Get Started",
                      style: TextStyle(
                          fontSize: 13,
                          color: Colors.white
                      ),
                    ),
                  ),
                )
              ],
            )
        )
    );
  }
}
