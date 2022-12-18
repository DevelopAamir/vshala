import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vshala/constants/theme.dart';
import 'package:vshala/constants/theme.dart';
import 'package:vshala/constants/theme.dart';


class LeaveHistoryCard extends StatelessWidget {
  final String t1;
  final String t2;
  final String t3;
  final textTheme;


  const LeaveHistoryCard(
      {Key? key,
        required this.t1,
        required this.t2,
        required this.t3,required this.textTheme
        })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                      child: Center(
                        child: Text(t1,
                            style: textTheme),
                      )),
                )),
            Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                      child: Center(
                        child: Text(t2,
                            style: textTheme),
                      )),
                )),
            Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                      child: Center(
                        child: Text(t3,
                            style: textTheme),
                      )),
                )),

          ],
        ),
      ),
    );
  }
}



