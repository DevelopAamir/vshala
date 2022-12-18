import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vshala/student/ui/components/uiProvider.dart';
import 'package:provider/provider.dart';

class OnlineExamCards extends StatelessWidget {
  final String sub;
  final String time;
  final VoidCallback onTap;

  const OnlineExamCards({
    Key? key,
    required this.sub,
    required this.time,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            leading: Icon(
              Icons.class_,
              size: 30,
              color: context.watch<UiProvider>().theme == 'light'
                  ? Color(0xff0DB6D1)
                  : Color(0xff00BBD3),
            ),
            title: Text(
              sub,
              style: GoogleFonts.alice(color: Colors.black),
            ),
            subtitle: Text(
              time,
              style: GoogleFonts.alice(color: Colors.black54),
            ),
            trailing: OutlinedButton(
              onPressed: onTap,
              child: Text(
                'Join Now',
                style: GoogleFonts.alice(color: Colors.black),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
