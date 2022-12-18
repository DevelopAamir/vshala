import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InformationTile extends StatelessWidget {
  final String title;
  final String subtitle;
  const InformationTile({
    Key? key,
    required this.title,
    required this.subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text(
        title,
        style: GoogleFonts.alice(
          color: Colors.white,
          fontWeight: FontWeight.bold
        ),
      ),
      trailing: Text(
        subtitle,
        style: GoogleFonts.alice(
          color: Colors.white60,
        ),
      ),
    );
  }
}
