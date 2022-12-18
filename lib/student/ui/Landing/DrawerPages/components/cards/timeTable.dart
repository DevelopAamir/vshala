import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vshala/objects/timetable.dart';
import 'package:vshala/student/connector/getData.dart';
import 'package:vshala/student/ui/Landing/DrawerPages/components/cards/leavehistory.dart';

class TimeTableCard extends StatelessWidget {
  final String t1;
  final List<LeaveHistoryCard> routine;

  const TimeTableCard(
      {Key? key,
      required this.t1, required this.routine,}
    )
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration( color: Colors.white,
          borderRadius: BorderRadius.circular(15)
        ),

        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15),
          child: Container(

            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(child: Text(t1,style: GoogleFonts.alice(fontSize: 20,color: Colors.black,fontWeight: FontWeight.bold),)),
                ),

                Container(
                  child:Column(
                    children:routine
                  )


                )



              ],
            ),
          )
        ),

      ),
    );
  }
}
