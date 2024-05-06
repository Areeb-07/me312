import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 100,
      color: Colors.white,
      child: const Center(
          child: Image(
            image: AssetImage("assets/header.png"),
            width: 320,
          )
      ),
    );
  }
}
