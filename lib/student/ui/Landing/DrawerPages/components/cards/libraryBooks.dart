import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vshala/constants/theme.dart';
import 'package:vshala/student/ui/components/uiProvider.dart';
import 'package:provider/provider.dart';

class Books extends StatelessWidget {
  final title;
  final author;
  final issued_date;
  final bookNumber;
  final returnDate;
  final status;
  const Books({
    Key? key,required this.title,required this.author,required this.issued_date,required this.bookNumber,required this.returnDate,required this.status,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Container(
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
            color: Colors.white,
          borderRadius: BorderRadius.circular(15)
        ),

        child: Column(
          children: [
            ListTile(
              leading: Icon(
                Icons.class_,
                size: 30,
                color: context.watch<UiProvider>().theme == 'light'
                    ? Color(0xff0DB6D1)
                    : Color(0xff00BBD3),
              ),
              title: Text(
                '$title',
                style: themeLabel,
              ),
              subtitle: Text(
                '$author',
                style: GoogleFonts.alice(color: Colors.black),
              ),
            ),
            ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      'Issued Date',
                      style: GoogleFonts.alice(color: Colors.black),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      'Book No.',
                      style: GoogleFonts.alice(color: Colors.black),
                    ),
                  ),
                ],
              ),
              subtitle: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      '$issued_date',
                      style: GoogleFonts.alice(color: Colors.black),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      '$bookNumber',
                      style: GoogleFonts.alice(color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      'Return Date',
                      style: GoogleFonts.alice(color: Colors.black),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      'Status',
                      style: GoogleFonts.alice(color: Colors.black),
                    ),
                  ),
                ],
              ),
              subtitle: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      '$returnDate',
                      style: GoogleFonts.alice(color: Colors.black),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      '$status',
                      style: GoogleFonts.alice(color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
