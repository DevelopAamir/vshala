import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextFieldWithCalendar extends StatelessWidget {
  const TextFieldWithCalendar({
    Key? key,
    required this.dateController,
    required this.b,
    required this.onTap,
  }) : super(key: key);

  final TextEditingController dateController;
  final String b;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextField(
        style: GoogleFonts.alice(color: Colors.white),
        controller: dateController,
        decoration: InputDecoration(
          hintStyle: TextStyle(color: Colors.white),
          suffixIcon: IconButton(
            onPressed: onTap,
            icon: Icon(Icons.calendar_today),
          ),
          hintText: '$b',
        ),
      ),
    );
  }
}
