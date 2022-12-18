import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ResultCard extends StatelessWidget {
  final t1, t2, t3, t4, t5, t6,theme;
  const ResultCard(
      {Key? key,
      required this.t1,
      required this.t2,
      required this.t3,
      required this.t4,
      required this.t5,
      required this.t6, required this.theme})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: Text(t1,style: theme,),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: Text(t2,style: theme,),
              ),
            ),
            // Expanded(
            //   child: Padding(
            //     padding: const EdgeInsets.all(2.0),
            //     child: Text(t3,style: GoogleFonts.alice(),),
            //   ),
            // ),

            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: Text("$t5$t4",style: theme,),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: Text(t6,style: theme,),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
