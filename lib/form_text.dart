import 'package:flutter/material.dart';
import 'package:me312/colors.dart' as color;

class FormTextField extends StatelessWidget {
  final TextEditingController controller;
  final String title;
  final String hint;
  final String? error;
  final bool? numeric;
  final bool? required;
  const FormTextField({super.key, required this.controller, required this.hint, required this.title, this.error, this.numeric, this.required});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 14,
                fontWeight: FontWeight.w500
              ),
            ),
            const SizedBox(height: 10,),
            TextFormField(
              controller: controller,
              decoration: InputDecoration(
                errorStyle: TextStyle(
                    color: color.AppColor.error,
                    fontWeight: FontWeight.w500
                ),
                fillColor: Colors.white,
                filled: true,
                hintText: hint,
                contentPadding: const EdgeInsets.only(top: 0, bottom: 0, left: 18, right: 18),
                hintStyle: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 13,
                    color: Colors.black54,
                ),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(7),
                    borderSide: const BorderSide(
                        width: 0,
                        style: BorderStyle.none
                    )
                ),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(7),
                    borderSide: const BorderSide(
                        width: 0,
                        style: BorderStyle.none
                    )
                ),
              ),
              textInputAction: TextInputAction.next,
              keyboardType: numeric == null ? TextInputType.text : TextInputType.number,
              validator: (val){
                if (required != null && !required!){
                  return null;
                }
                if (val == null || val.isEmpty){
                  return error ?? "Enter $hint";
                } return null;
              },
            ),
          ],
        ),
        const SizedBox(height: 30),
      ],
    );
  }
}
