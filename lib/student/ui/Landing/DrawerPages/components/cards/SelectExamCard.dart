import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vshala/constants/theme.dart';
import 'package:vshala/student/ui/components/DataPage.dart';
import 'package:vshala/student/ui/components/uiProvider.dart';
import 'package:provider/provider.dart';

class SelectExamCard extends StatelessWidget {
  final id;
  final title;
  final start_Date;
  final endDate;
  final widget;
  const SelectExamCard(
      {Key? key,
      required this.id,
      required this.title,
      required this.start_Date,
      required this.endDate,required this.widget})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        child: ListTile(
      leading: Icon(
        Icons.timeline,
        color: context.watch<UiProvider>().theme == 'light'
            ? Color(0xffF76D87)
            : Color(0xff77BF22),
      ),
      title: Text(title,
          style: themeLabel),
      subtitle: Text(
        start_Date + ' to ' + endDate,
        style: GoogleFonts.alice(fontSize: 14, color: Colors.black),
      ),
      trailing: OutlinedButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context){
            return widget;
          }));
        },
        child: Text('View',
            style: GoogleFonts.alice(
              fontSize: 14,
              color: Colors.black,
            )),
      ),
    ));
  }
}
