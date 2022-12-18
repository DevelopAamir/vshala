import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:vshala/student/connector/getData.dart';
import 'package:vshala/student/connector/submitData.dart';
import 'package:vshala/student/ui/Landing/DrawerPages/components/textFieldWithcalender.dart';
import 'package:vshala/student/ui/Landing/components/calender.dart';
import 'package:vshala/student/ui/Landing/landing.dart';
import 'package:vshala/student/ui/components/DataPage.dart';
import 'package:vshala/student/ui/components/uiProvider.dart';
import 'package:provider/provider.dart';

class SubmitLeaveNote extends StatefulWidget {
  SubmitLeaveNote({Key? key}) : super(key: key);

  @override
  State<SubmitLeaveNote> createState() => _SubmitLeaveNoteState();
}

class _SubmitLeaveNoteState extends State<SubmitLeaveNote> {
  final TextEditingController reasonController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    String startDate = '';
    String endDate = '';
    var singleDay = true;

    void a() {
      showDialog(
          context: context,
          builder: (context) {
            return Calendars(ontap: (DateTime a) {
              final DateFormat formatter = DateFormat('yyyy-MM-dd');
              final String formatted = formatter.format(a);
              Provider.of<UiProvider>(context, listen: false)
                  .changeStartDate(formatted);
              Navigator.pop(context);
            });
          });
    }

    final TextEditingController dateControllerStart = TextEditingController(
        text: context.watch<UiProvider>().focusDay1.toString());
    final TextEditingController dateControllerEnd = TextEditingController(
        text: context.watch<UiProvider>().focusDay2.toString());

    return DefaultTabController(
      length: 2,
      child: GestureDetector(
        onTap: () {},
        child: Stack(
          children: [
            Scaffold(
              backgroundColor: context.watch<UiProvider>().theme == 'light'
                  ? Color.fromRGBO(135, 112, 255, 0.9)
                  : Color(0xff2A2B30),
              appBar: AppBar(
                backgroundColor: context.watch<UiProvider>().theme == 'light'
                    ? Color.fromRGBO(135, 112, 255, 0.9)
                    : Color(0xff2A2B30),
                title: Text(
                  'Submit Leave Notes',
                  style: GoogleFonts.alice(color: Colors.white),
                ),
                actions: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: OutlinedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>BottomNavigationBarPage(icon: Icons.article,pageLabel: 'Leave',page:GetLeaveHistoryPage(label: 'Leave Status'),)
                                      ));
                        },
                        child: Text(
                          'Leave Status',
                          style: GoogleFonts.alice(color: Colors.white),
                        )),
                  )
                ],
              ),
              body: SingleChildScrollView(
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  child: Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'Leave types',
                          style: GoogleFonts.alice(
                            fontSize: 20,
                            color: Colors.white,
                            height: 2,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        TabBar(
                          onTap: (a) {
                            if (a == 0) {
                              setState(() {
                                singleDay = true;
                              });
                            } else {
                              setState(() {
                                singleDay = false;
                              });
                            }
                          },
                          indicatorColor:
                              context.watch<UiProvider>().theme == 'light'
                                  ? Color.fromRGBO(135, 112, 255, 0.9)
                                  : Color(0xff2A2B30),
                          tabs: [
                            Tab(
                              text: 'Single Day',
                            ),
                            Tab(
                              text: 'Multiple Days',
                            ),
                          ],
                        ),
                        Expanded(
                          child: TabBarView(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    'Date for Leave',
                                    style: GoogleFonts.alice(
                                      fontSize: 20,
                                      color: Colors.white,
                                      height: 2,
                                    ),
                                  ),
                                  TextFieldWithCalendar(
                                    dateController: dateControllerStart,
                                    b: startDate,
                                    onTap: () {
                                      showDialog(
                                          context: context,
                                          builder: (context) {
                                            return Calendars(
                                                ontap: (DateTime a) {
                                              final DateFormat formatter =
                                                  DateFormat('dd-MM-yyyy');
                                              final String formatted =
                                                  formatter.format(a);
                                              Provider.of<UiProvider>(context,
                                                      listen: false)
                                                  .changeStartDate(formatted);
                                              Navigator.pop(context);
                                            });
                                          });
                                    },
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.indigo.shade300),
                                    child: TextField(
                                      controller: reasonController,
                                      style: GoogleFonts.alice(
                                          color: Colors.white),
                                      maxLines: 5,
                                      onChanged: (a) {
                                        Provider.of<UiProvider>(context,
                                                listen: false)
                                            .changeReason(a);
                                      },
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.all(15),
                                        hintStyle: GoogleFonts.alice(
                                            color: Colors.white),
                                        hintText: "Reason For leave",
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: MaterialButton(
                                      color: Colors.white70,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text('Submit',
                                            style: GoogleFonts.alice(
                                                color: Colors.black)),
                                      ),
                                      onPressed:reasonController.text.isNotEmpty? () {
                                        print(reasonController.text.toString());
                                        reasonController.clear();
                                        Provider.of<UiProvider>(context,
                                                listen: false)
                                            .spinner();
                                        SubmitData()
                                            .submitLeaveRequest(
                                          singleDay,
                                          Provider.of<UiProvider>(context,
                                                  listen: false)
                                              .focusDay1,
                                          Provider.of<UiProvider>(context,
                                                  listen: false)
                                              .focusDay1,
                                          Provider.of<UiProvider>(context,
                                                  listen: false)
                                              .reason,
                                        )
                                            .then((value) {
                                          Provider.of<UiProvider>(context,
                                                  listen: false)
                                              .spinner();
                                          showDialog(
                                              context: context,
                                              builder: (context) {
                                                return AlertDialog(
                                                  title: Text('Alert',
                                                      style:
                                                          GoogleFonts.alice()),
                                                  content: Text(
                                                    'Leave Request Successfully \n Submitted',
                                                    style: GoogleFonts.alice(),
                                                  ),
                                                  actions: [
                                                    OutlinedButton(
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context);
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) {
                                                            return GetLeaveHistoryPage(
                                                                label:
                                                                    'Leave Status');
                                                          }));
                                                        },
                                                        child: Text('Ok'))
                                                  ],
                                                );
                                              });
                                        });
                                      }:(){Fluttertoast.showToast(msg: 'Please specify Reason');},
                                    ),
                                  )
                                ],
                              ),
                              Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      'Starting Date',
                                      style: GoogleFonts.alice(
                                        fontSize: 15,
                                        color: Colors.white,
                                        height: 2,
                                      ),
                                    ),
                                    TextFieldWithCalendar(
                                      dateController: dateControllerStart,
                                      b: startDate,
                                      onTap: () {
                                        showDialog(
                                            context: context,
                                            builder: (context) {
                                              return Calendars(
                                                  ontap: (DateTime a) {
                                                final DateFormat formatter =
                                                    DateFormat('dd-MM-yyyy');
                                                final String formatted =
                                                    formatter.format(a);
                                                Provider.of<UiProvider>(context,
                                                        listen: false)
                                                    .changeStartDate(formatted);
                                                Navigator.pop(context);
                                              });
                                            });
                                      },
                                    ),
                                    Text(
                                      'Ending Date',
                                      style: GoogleFonts.alice(
                                        fontSize: 15,
                                        color: Colors.white,
                                        height: 2,
                                      ),
                                    ),
                                    TextFieldWithCalendar(
                                      dateController: dateControllerEnd,
                                      b: endDate,
                                      onTap: () {
                                        showDialog(
                                            context: context,
                                            builder: (context) {
                                              return Calendars(
                                                  ontap: (DateTime a) {
                                                final DateFormat formatter =
                                                    DateFormat('dd-MM-yyyy');
                                                final String formatted =
                                                    formatter.format(a);
                                                Provider.of<UiProvider>(context,
                                                        listen: false)
                                                    .changeEndDate(formatted);
                                                Navigator.pop(context);
                                              });
                                            });
                                      },
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.indigo.shade300),
                                      child: TextField(
                                        controller: reasonController,
                                        style: GoogleFonts.alice(
                                            color: Colors.white),
                                        onChanged: (a) {
                                          Provider.of<UiProvider>(context,
                                                  listen: false)
                                              .changeReason(a);
                                        },
                                        maxLines: 5,
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.all(15),
                                          hintStyle: GoogleFonts.alice(
                                              color: Colors.white),
                                          hintText: "Reason For leave",
                                          border: InputBorder.none,
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: MaterialButton(
                                        color: Colors.white70,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text('Submit',
                                                style: GoogleFonts.alice(
                                                    color: Colors.black)),
                                          ),
                                          onPressed: () {
                                            Provider.of<UiProvider>(context,
                                                    listen: false)
                                                .spinner();

                                            print(reasonController.text);
                                            SubmitData()
                                                .submitLeaveRequest(
                                              singleDay,
                                              Provider.of<UiProvider>(context,
                                                      listen: false)
                                                  .focusDay1,
                                              Provider.of<UiProvider>(context,
                                                      listen: false)
                                                  .focusDay2,
                                              Provider.of<UiProvider>(context,
                                                      listen: false)
                                                  .reason,
                                            )
                                                .then(
                                              (value) {
                                                Provider.of<UiProvider>(context,
                                                        listen: false)
                                                    .spinner();
                                                showDialog(
                                                    context: context,
                                                    builder: (context) {
                                                      return AlertDialog(
                                                        title: Text('Alert',
                                                            style: GoogleFonts
                                                                .alice()),
                                                        content: Text(
                                                          'Leave Request Successfully \n Submitted',
                                                          style: GoogleFonts
                                                              .alice(),
                                                        ),
                                                        actions: [
                                                          OutlinedButton(
                                                              onPressed: () {
                                                                Navigator.pop(
                                                                    context);

                                                                Navigator.push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder:
                                                                            (context) {
                                                                  return GetLeaveHistoryPage(
                                                                      label:
                                                                          'History');
                                                                }));
                                                              },
                                                              child: Text('Ok'))
                                                        ],
                                                      );
                                                    });
                                              },
                                            );
                                          }),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Center(
              child: context.watch<UiProvider>().spin == true
                  ? SpinKitCircle(
                      color: Colors.indigo,
                    )
                  : Container(),
            )
          ],
        ),
      ),
    );
  }
}
