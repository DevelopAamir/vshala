import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vshala/student/connector/getData.dart';
import 'package:vshala/student/connector/submitData.dart';
import 'package:vshala/student/ui/components/DataPage.dart';
import 'package:vshala/student/ui/components/uiProvider.dart';
import 'package:provider/provider.dart';

class HomeWork extends StatelessWidget {

  final title;
  final subtitle;
  final VoidCallback onTap;

  const HomeWork({
    Key? key,
    required this.title,
    required this.subtitle,
   required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Card(
        
        child: ListTile(

          leading: CircleAvatar(
            backgroundColor: context.watch<UiProvider>().theme == 'light'
                ? Color.fromRGBO(243, 230, 249, 0.8)
                : Color.fromRGBO(64, 63, 60, 0.8),
            child: Icon(
              Icons.class_,
              size: 25,
              color: context.watch<UiProvider>().theme == 'light'
                  ? Color(0xff0DB6D1)
                  : Color(0xff00BBD3),
            ),
          ),
          title: Text(
            title,
            style: GoogleFonts.alice(color: Colors.black),
          ),
          subtitle: Text(
            '$subtitle',
            style: GoogleFonts.alice(color: Colors.black54),
          ),
          trailing: OutlinedButton(
            onPressed: onTap,


            child: Text(
              'Read More',
              style: GoogleFonts.alice(color: Colors.black),
            ),
          ),
        ),
      ),
    );
  }
}
