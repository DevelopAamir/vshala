import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Button extends StatelessWidget {
  final VoidCallback ontap;
  const Button({
    Key? key,
    required this.ontap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: InkWell(
        onTap: ontap,
        child: Container(
          decoration: BoxDecoration(
              color: Colors.indigo,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 3,
                  blurRadius: 5,
                  offset: Offset(1, 2),
                )
              ]),
          width: double.infinity,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                "Login",
                style: GoogleFonts.alice(fontSize: 18, color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
