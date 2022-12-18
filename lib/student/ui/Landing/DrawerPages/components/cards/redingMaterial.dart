import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vshala/student/ui/components/uiProvider.dart';
import 'package:provider/provider.dart';

class ReadingMaterialCard extends StatelessWidget {
  final String id;
  final String title;
  final String date;
  final String url;
  final VoidCallback onTap;
  final buttonText;

  const ReadingMaterialCard({
    Key? key,
    required this.id,
    required this.title,
    required this.date,
    required this.url,
    required this.onTap,
    this.buttonText = 'Read Now',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: ListTile(

        leading: Icon(
          Icons.class_,
          size: 30,
          color: context.watch<UiProvider>().theme == 'light'
              ? Color(0xff0DB6D1)
              : Color(0xff00BBD3),
        ),
        title: Text(
          title,
          style: GoogleFonts.alice(color: Colors.white),
        ),
        subtitle: Text(
          date,
          style: GoogleFonts.alice(color: Colors.white54),
        ),
        trailing: OutlinedButton(
          onPressed:onTap,
          child: Text(
            buttonText,
            style: GoogleFonts.alice(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
