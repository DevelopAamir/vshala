import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Textfield extends StatelessWidget {
  final TextEditingController? controller;
  final String hintText;
  const Textfield({
    Key? key,
    required this.controller,
    required this.hintText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        padding: EdgeInsets.only(left: 10),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 3,
                blurRadius: 5,
                offset: Offset(1, 2),
              )
            ]),
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
              border: InputBorder.none,
              focusColor: Colors.white,
              hintStyle: GoogleFonts.alice(color: Colors.grey[400]),
              hintText: hintText,
              fillColor: Colors.white70),
        ),
      ),
    );
  }
}
