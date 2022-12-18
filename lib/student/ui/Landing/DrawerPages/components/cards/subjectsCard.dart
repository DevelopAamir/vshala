import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:vshala/student/ui/components/uiProvider.dart';

class SubjectsCard extends StatelessWidget {
  final id;
  final subName;
  final code;
  final type;
  final teacher;
  final VoidCallback ontap;
  const SubjectsCard({Key? key, required this.id, required this.subName, required this.code, required this.type, required this.teacher, required this.ontap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: CircleAvatar(

                        child: Icon(Icons.account_balance_wallet,color: context.watch<UiProvider>().theme == 'light'
                            ? Color(0xffF76D87)
                            : Color(0xff77BF22),),
                        backgroundColor: context.watch<UiProvider>().theme == 'light'
                            ? Color.fromRGBO(254, 233, 238, 0.8)
                            : Color.fromRGBO(57, 67, 52, 0.8),
                      ),
                    ),
                    SizedBox(width: 10,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Subject : $subName', style: GoogleFonts.alice(fontSize: 15,fontWeight: FontWeight.bold),),

                        Text ('Type : $type',style: GoogleFonts.alice(color: Colors.black54,height: 1.5))
                      ],
                    ),
                    Spacer(),
                    CircleAvatar(
                      child: Icon(Icons.chevron_right,color: context.watch<UiProvider>().theme == 'light'
                          ? Color(0xffF76D87)
                          : Color(0xff77BF22),),
                      backgroundColor:context.watch<UiProvider>().theme == 'light'
                          ? Color.fromRGBO(254, 233, 238, 0.8)
                          : Color.fromRGBO(57, 67, 52, 0.8) ,
                    )
                  ],
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: [
              //       Text('Type : $type',style: GoogleFonts.alice()),
              //       Text('Teacher : $teacher',style: GoogleFonts.alice()),
              //     ],
              //   ),
              // )
            ],
          ),
        ),
      ),
    );
  }
}
