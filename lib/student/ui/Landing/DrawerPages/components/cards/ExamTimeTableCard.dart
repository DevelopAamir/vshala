import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:vshala/student/ui/components/uiProvider.dart';
class ExamTimeTableCard extends StatelessWidget {
  final subject;
  final room_no;
  final date;
  final time;
  const ExamTimeTableCard({Key? key,required this.subject,required this.room_no,required this.date,required this.time}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.account_balance_wallet_outlined,
                        color: context.watch<UiProvider>().theme == 'light'
                            ? Color(0xffF76D87)
                            : Color(0xff77BF22),
                      ),
                    ),
                    Expanded(child: Text('Subject : $subject',style: GoogleFonts.alice(fontSize: 15),)),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.airline_seat_legroom_reduced_outlined,
                        color: context.watch<UiProvider>().theme == 'light'
                            ? Color(0xffF76D87)
                            : Color(0xff77BF22),
                      ),
                    ),
                    Expanded(child: Text('Room no : $room_no',style: GoogleFonts.alice(fontSize: 15),)),

                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.calendar_today,
                        color: context.watch<UiProvider>().theme == 'light'
                            ? Color(0xffF76D87)
                            : Color(0xff77BF22),
                      ),
                    ),
                    Expanded(child: Text('Date : $date',style: GoogleFonts.alice(fontSize: 15),)),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.alarm_outlined,
                        color: context.watch<UiProvider>().theme == 'light'
                            ? Color(0xffF76D87)
                            : Color(0xff77BF22),
                      ),
                    ),
                    Expanded(child: Text('Time :  $time',style: GoogleFonts.alice(fontSize: 15),))

                  ],
                ),
              )
            ],
          ),
        )
    );
  }
}
