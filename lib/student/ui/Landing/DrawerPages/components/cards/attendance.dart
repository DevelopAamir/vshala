import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Attendance extends StatelessWidget {
  final String t1;
  final String t2;
  final String t3;
  final String t4;
  final String t5;
  final theme;

  const Attendance(
      {Key? key,
      required this.t1,
      required this.t2,
      required this.t3,
      required this.t4,
      required this.t5,required this.theme})
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
                flex: 3,
                child: Container(
                    padding: EdgeInsets.all(2),
                    child: Text(t1,
                        style: theme))),
            Expanded(
                flex: 2,
                child: Container(
                    padding: EdgeInsets.all(2),
                    child: Text(t2,
                        style: theme))),
            Expanded(
                flex: 2,
                child: Container(
                    padding: EdgeInsets.all(2),
                    child: Text(t3,
                        style: theme))),
            Expanded(
                flex: 2,
                child: Container(
                    padding: EdgeInsets.all(2),
                    child: Center(
                      child: Text(t4,
                          style: theme),
                    ))),
            Expanded(
                flex: 2,
                child: Container(
                    padding: EdgeInsets.all(2),
                    child: Center(
                      child: Text(t5,
                          style: theme),
                    ))),
          ],
        ),
      ),
    );
  }
}
