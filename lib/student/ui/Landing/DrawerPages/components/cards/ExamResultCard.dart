import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vshala/constants/theme.dart';
import 'package:vshala/student/ui/components/DataPage.dart';
import 'package:vshala/student/ui/components/uiProvider.dart';
import 'package:provider/provider.dart';

class ExamResultCard extends StatelessWidget {
  final id;
  final title;
  final start_Date;
  final endDate;
  final widget;
  final role;
  final data;


  const ExamResultCard(
      {Key? key,
        required this.id,
        required this.title,
        required this.start_Date,
        required this.endDate,required this.widget,required this.role,required this.data})
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
              style:themeLabel),
          subtitle: Text(
            start_Date + ' to ' + endDate,
            style: GoogleFonts.alice(fontSize: 14, color: Colors.black),
          ),
          trailing: OutlinedButton(
            onPressed: () {
              role == 'staff'?
                  showDialog(context: context, builder: (context){
                    return AlertDialog(
                      title: Text(data['name'],style: GoogleFonts.alice(fontWeight: FontWeight.bold,color: Colors.indigo),),
                      content: Container(
                        height: 200,
                        child: Column(
                          children: [
                            Text(data['title'],style: GoogleFonts.alice(fontWeight: FontWeight.bold,color: Colors.indigo),),
                            SizedBox(height: 50,),
                            Align(alignment: Alignment.centerLeft,child: Text('Total marks obtained: ' + data['total'].toString() + ' / ' +data['maximum_number'].toString(),style: GoogleFonts.alice(fontWeight: FontWeight.bold,color: Colors.indigo),)),
                            SizedBox(height: 10,),
                            Align(alignment: Alignment.centerLeft,child: Text('Percentage : '+data['percentage'],style: GoogleFonts.alice(fontWeight: FontWeight.bold,color: Colors.indigo),)),
                          ],
                        ),
                      ),
                      actions: [
                        OutlinedButton(onPressed: (){Navigator.pop(context);}, child: Text('Back'))
                      ],
                    );
                  })
                  :Navigator.push(context, MaterialPageRoute(builder: (context){
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
