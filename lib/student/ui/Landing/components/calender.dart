import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendars extends StatefulWidget {
  final Function(DateTime) ontap;
  const Calendars({
    Key? key,
    required this.ontap,
  }) : super(key: key);

  @override
  _CalendarsState createState() => _CalendarsState();
}

class _CalendarsState extends State<Calendars> {
  DateTime focusDay = DateTime.now();
  DateTime selectedDay = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Column(
        children: [
          Expanded(
            child: Container(
              child: TableCalendar(
                firstDay: DateTime.utc(2019, 10, 16),
                lastDay: DateTime.utc(5019, 10, 16),
                focusedDay: focusDay,
                onDaySelected: (a, b) {
                  setState(() {
                    focusDay = a;
                    selectedDay = b;
                  });
                },
                onHeaderTapped: (e) {
                  print(e);
                },
                onFormatChanged: (a) {},
                selectedDayPredicate: (DateTime date) {
                  return isSameDay(selectedDay, date);
                },
                calendarStyle: CalendarStyle(
                  isTodayHighlighted: true,
                  selectedDecoration: BoxDecoration(
                    color: Colors.indigoAccent,
                    shape: BoxShape.circle,
                  ),
                  selectedTextStyle: TextStyle(color: Colors.white),
                  todayDecoration: BoxDecoration(
                    color: Colors.indigo,
                    shape: BoxShape.circle,
                  ),
                  defaultDecoration: BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
              OutlinedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Cancel')),
              SizedBox(
                width: 15,
              ),
              OutlinedButton(
                  onPressed: () {
                    widget.ontap(focusDay);
                  },
                  child: Text('Next')),
            ]),
          )
        ],
      ),
    );
  }
}
