import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vshala/constants/api.dart';
import 'package:vshala/constants/theme.dart';
import 'package:vshala/objects/readingAttachments.dart';
import 'package:vshala/staff/Component/DropdopwnButton.dart';
import 'package:vshala/staff/assign.dart';
import 'package:vshala/storage/storage.dart';
import 'package:vshala/student/connector/connector.dart';
import 'package:vshala/student/connector/getData.dart';
import 'package:vshala/student/connector/submitData.dart';
import 'package:vshala/student/ui/Landing/DrawerPages/components/EventsDetails.dart';
import 'package:vshala/student/ui/Landing/DrawerPages/components/cards/PaymentInvoices.dart';
import 'package:vshala/student/ui/Landing/DrawerPages/components/cards/attendance.dart';
import 'package:vshala/student/ui/Landing/DrawerPages/components/cards/homeworkCard.dart';
import 'package:vshala/student/ui/Landing/DrawerPages/components/cards/leavehistory.dart';
import 'package:vshala/student/ui/Landing/DrawerPages/components/cards/libraryBooks.dart';
import 'package:vshala/student/ui/Landing/DrawerPages/components/cards/notice.dart';
import 'package:vshala/student/ui/Landing/DrawerPages/components/cards/onlineExamCard.dart';
import 'package:vshala/student/ui/Landing/DrawerPages/components/cards/redingMaterial.dart';
import 'package:vshala/student/ui/Landing/DrawerPages/components/cards/studyMaterialDataCard.dart';
import 'package:vshala/student/ui/Landing/DrawerPages/components/cards/subjectsCard.dart';
import 'package:vshala/student/ui/Landing/DrawerPages/components/cards/timeTable.dart';
import 'package:vshala/student/ui/Landing/components/cards.dart';
import 'package:vshala/student/ui/Landing/landing.dart';
import 'package:vshala/student/ui/components/pdfViewer.dart';
import 'package:vshala/student/ui/components/uiProvider.dart';
import 'package:provider/provider.dart';
import 'package:vshala/student/ui/components/webView.dart';

class HomeworkSubmission extends StatelessWidget {
  final id;
  const HomeworkSubmission({Key? key, this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.watch<UiProvider>().theme == 'light'
          ? Color.fromRGBO(135, 112, 255, 0.9)
          : Color(0xff2A2B30),
      appBar: AppBar(
        title: Text('Submission'),
        backgroundColor: context.watch<UiProvider>().theme == 'light'
            ? Color.fromRGBO(135, 112, 255, 0.9)
            : Color(0xff2A2B30),
      ),
      body: FutureBuilder(
        future: GetData(context: context).staffGetSubmission(id),
        builder: (context, AsyncSnapshot snapshot) {
          return snapshot.hasData
              ? ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, i) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text(
                                    snapshot.data[i]['description'],
                                    style: GoogleFonts.alice(),
                                  ),
                                  content: OutlinedButton(
                                    onPressed: () {
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (context) {
                                        return PdfView(
                                          fileName: 'Attachment',
                                          url: snapshot.data[i]['url'],
                                          attachments: null,
                                        );
                                      }));
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Text('Read More',
                                              style: GoogleFonts.alice()),
                                          Icon(Icons.folder),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              });
                        },
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                    flex: 3,
                                    child: Container(
                                        padding: EdgeInsets.all(2),
                                        child: Text(snapshot.data[i]['name'],
                                            style: GoogleFonts.alice()))),
                                Expanded(
                                    flex: 2,
                                    child: Container(
                                        padding: EdgeInsets.all(2),
                                        child: Text(snapshot.data[i]['roll_no'],
                                            style: GoogleFonts.alice()))),
                                Expanded(
                                    flex: 2,
                                    child: Container(
                                        padding: EdgeInsets.all(2),
                                        child: Text(snapshot.data[i]['class'],
                                            style: GoogleFonts.alice()))),
                                Expanded(
                                    flex: 2,
                                    child: Container(
                                        padding: EdgeInsets.all(2),
                                        child: Center(
                                          child: Text(snapshot.data[i]['title'],
                                              style: GoogleFonts.alice()),
                                        ))),
                                Expanded(
                                    flex: 2,
                                    child: Container(
                                        padding: EdgeInsets.all(2),
                                        child: Center(
                                          child: Text(
                                              snapshot.data[i]['status'],
                                              style: GoogleFonts.alice()),
                                        ))),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  })
              : Center(
                  child: SpinKitCircle(
                  color: Colors.indigo,
                ));
        },
      ),
    );
  }
}

class StudyMaterialStaff extends StatelessWidget {
  final String label;

  const StudyMaterialStaff({Key? key, required this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.watch<UiProvider>().theme == 'light'
          ? Color.fromRGBO(135, 112, 255, 0.9)
          : Color(0xff2A2B30),
      appBar: AppBar(
          backgroundColor: context.watch<UiProvider>().theme == 'light'
              ? Color.fromRGBO(135, 112, 255, 0.9)
              : Color(0xff2A2B30),
          actions: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: OutlinedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return BottomNavigationBarPage(icon: Icons.auto_stories,pageLabel: 'Assign',page:AssignStudyMaterial(
                      title: 'Assign study Material',
                    ));


                  }));
                },
                child: Text(
                  'Assign',
                  style: GoogleFonts.alice(color: Colors.white),
                ),
              ),
            )
          ],
          title: Text(
            label,
            style: GoogleFonts.alice(),
          )),
      body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: FutureBuilder(
            future: GetData(context: context).staffGetStudyMaterial(),
            builder: (context, AsyncSnapshot snapshot) {
              return snapshot.hasData
                  ? ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        List<ReadingAttachments> attachments_ = [];
                        if(snapshot.data[index]['attachments'] != ''){
                          for (var m in snapshot.data[index]['attachments']) {

                            attachments_.add(ReadingAttachments(
                                url: m['url'], fileName: m['file_name']));


                          }
                        }
                        return attachments_.isEmpty  &&  snapshot.data[index]['url'].toString() == ''?  Container() :StudyMaterialDataCard(
                                attachments: attachments_,
                                url: snapshot.data[index]['url'],
                                date: snapshot.data[index]['date'],
                                title: snapshot.data[index]['title'],
                                mType: snapshot.data[index]['material_type'],
                              );

                      })
                  : SpinKitCircle(
                      color: Colors.indigo,
                    );
            },
          )),
    );
  }
}

class DataPage extends StatelessWidget {
  final String label;
  final List<Widget> card;
  const DataPage({Key? key, required this.card, required this.label})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.watch<UiProvider>().theme == 'light'
          ? Color.fromRGBO(135, 112, 255, 0.9)
          : Color(0xff2A2B30),
      appBar: AppBar(
          backgroundColor: context.watch<UiProvider>().theme == 'light'
              ? Color.fromRGBO(135, 112, 255, 0.9)
              : Color(0xff2A2B30),
          title: Text(
            label,
            style: GoogleFonts.alice(),
          )),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ListView(children: card),
      ),
    );
  }
}

class StaffAttendanceData extends StatefulWidget {
  final String label;

  const StaffAttendanceData({Key? key, required this.label}) : super(key: key);

  @override
  State<StaffAttendanceData> createState() => _StaffAttendanceDataState();
}

class _StaffAttendanceDataState extends State<StaffAttendanceData> {
  var section_id = '1';
  var spin = true;
  var rollNo = ['1'];
  var selectedValue = '1';
  String dropdownvalueClass = 'Select Class';
  var dropdownvalueSections = '';
  List<String> ClassItems = [];
  List<String> SectionsItems = [];
  Map classNameWithId = {};
  Map sectionNameWithId = {};

  @override
  void initState() {
    GetData(context: context).getAttendanceStaff(section_id).then((value) {
      setState(() {
        rollNo.clear();
        rollNo.add('1');
        if (value.isEmpty) {
        } else {
          for (var v in value) {
            if (rollNo.contains(v['roll_no'].toString()) == false) {
              rollNo.add(v['roll_no'].toString());
            }
          }
          selectedValue = value[0]['roll_no'].toString();
          print('dddd' + value.toString());
        }
      });
      print(rollNo.toString());
    });
    var data = GetData(context: context).getClasses().then((value) {
      for (var i = 0; i < value.length; i++) {
        ClassItems.add(value[i]['label']);
        classNameWithId.addAll({value[i]['label']: value[i]['ID']});
      }
      setState(() {
        spin = false;
      });
      print(classNameWithId.toString());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.watch<UiProvider>().theme == 'light'
          ? Color.fromRGBO(135, 112, 255, 0.9)
          : Color(0xff2A2B30),
      appBar: AppBar(
        backgroundColor: context.watch<UiProvider>().theme == 'light'
            ? Color.fromRGBO(135, 112, 255, 0.9)
            : Color(0xff2A2B30),
        title: Text(
          widget.label,
          style: GoogleFonts.alice(),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: OutlinedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return
                      BottomNavigationBarPage(icon: Icons.pan_tool,pageLabel: 'Attendance',page:TakeAttendance());

                  }));
                },
                child: Text(
                  'Take Attendance',
                  style: GoogleFonts.alice(color: Colors.white),
                )),
          )
        ],
      ),
      body: spin == true
          ? Container(
              child: Center(
                  child: SpinKitCircle(
                color: Colors.indigo,
              )),
            )
          : Padding(
              padding: const EdgeInsets.all(15.0),
              child: FutureBuilder(
                future:
                    GetData(context: context).getAttendanceStaff(section_id),
                builder: (context, AsyncSnapshot snapshot) {
                  return SingleChildScrollView(
                    child: Container(
                      height: MediaQuery.of(context).size.height,
                      child: Column(
                        children: [
                          Container(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          'Class',
                                          style: GoogleFonts.alice(
                                              color: Colors.white),
                                        ),
                                      ),
                                      Card(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8.0),
                                          child: CustomMultiselectDropDown(
                                            selectedList: (newValue) async {
                                              print(newValue.toString());

                                              showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return Center(
                                                        child:
                                                            CircularProgressIndicator(
                                                                color: Colors
                                                                    .indigo));
                                                  });
                                              if (classNameWithId[
                                                      newValue.toString()] !=
                                                  null) {
                                                await GetData(context: context)
                                                    .getSections(
                                                        classNameWithId[newValue
                                                            .toString()])
                                                    .then((value) {
                                                  setState(() {
                                                    SectionsItems.clear();
                                                    for (var i = 0;
                                                        i < value.length;
                                                        i++) {
                                                      SectionsItems.add(
                                                          value[i]['label']);
                                                      sectionNameWithId.addAll({
                                                        value[i]['label']:
                                                            value[i]['ID']
                                                      });
                                                    }
                                                  });
                                                  Navigator.pop(context);
                                                });
                                              } else {
                                                setState(() {
                                                  SectionsItems.removeRange(
                                                      1, SectionsItems.length);
                                                });
                                              }

                                              setState(() {
                                                dropdownvalueClass =
                                                    newValue.toString();
                                              });
                                            },
                                            listOFStrings: ClassItems,
                                            multiSelect: false,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          'Section',
                                          style: GoogleFonts.alice(
                                              color: Colors.white),
                                        ),
                                      ),
                                      Card(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8.0),
                                          child: CustomMultiselectDropDown(
                                            selectedList: (a) {
                                              print(a.toString());
                                              setState(() {
                                                selectedValue = '1';
                                                dropdownvalueSections = a;
                                                section_id =
                                                    sectionNameWithId[a]
                                                        .toString();
                                                GetData(context: context)
                                                    .getAttendanceStaff(
                                                        section_id)
                                                    .then((value) {
                                                  setState(() {
                                                    rollNo.clear();
                                                    for (var v in value) {
                                                      if (rollNo.contains(v[
                                                                  'roll_no']
                                                              .toString()) ==
                                                          false) {
                                                        rollNo.add(v['roll_no']
                                                            .toString());
                                                      }
                                                    }
                                                    selectedValue = value[0]
                                                            ['roll_no']
                                                        .toString();
                                                  });
                                                  print(rollNo.toString());
                                                });
                                              });
                                            },
                                            listOFStrings: SectionsItems,
                                            multiSelect: false,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        'Roll No',
                                        style: GoogleFonts.alice(
                                            color: Colors.white),
                                      ),
                                    ),
                                    Card(
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 20.0, horizontal: 10),
                                            child: Text(
                                              'Roll No ',
                                              style: GoogleFonts.alice(),
                                            ),
                                          ),
                                          DropdownButton(
                                            onChanged: (s) {
                                              setState(() {
                                                selectedValue = s.toString();
                                              });
                                            },
                                            underline: Container(),
                                            value: selectedValue,
                                            items: rollNo
                                                .map<DropdownMenuItem<String>>(
                                                    (String value) {
                                              return DropdownMenuItem<String>(
                                                value: value,
                                                child: Text(
                                                  value,
                                                  style: GoogleFonts.alice(),
                                                ),
                                              );
                                            }).toList(),
                                            onTap: () {},
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Card(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Expanded(
                                      flex: 3,
                                      child: Padding(
                                        padding: const EdgeInsets.all(2.0),
                                        child: Text(
                                          'Name',
                                          style: GoogleFonts.alice(),
                                        ),
                                      )),
                                  Expanded(
                                      flex: 3,
                                      child: Text(
                                        'Date',
                                        style: GoogleFonts.alice(),
                                      )),
                                  Expanded(
                                      flex: 2,
                                      child: Text(
                                        'Roll No',
                                        style: GoogleFonts.alice(),
                                      )),
                                  Expanded(
                                      flex: 2,
                                      child: Text(
                                        'Status',
                                        style: GoogleFonts.alice(),
                                      )),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: snapshot.hasData
                                ? ListView.builder(
                                    itemCount: snapshot.data.length,
                                    itemBuilder: (context, i) {
                                      return snapshot.data[i]['date']
                                                      .toString() !=
                                                  'null' &&
                                              snapshot.data[i]['roll_no']
                                                      .toString() ==
                                                  selectedValue
                                          ? InkWell(
                                        onTap: (){
                                          showDialog(context: context, builder: (context){
                                            return AlertDialog(
                                              title: Text('Alert'),
                                              content: Text(

                                                  'Are You Sure To Modify Attendance'
                                              ),
                                              actions: [
                                                OutlinedButton(onPressed: ()async{
                                                  await SubmitData().attendanceUpdate(snapshot.data[i]['id']).then((value){
                                                    Fluttertoast.showToast(msg: value.toString());
                                                  });
                                                  setState(() {

                                                  });
                                                  Navigator.pop(context);

                                                  print(snapshot.data[i]['id'].toString());
                                                }, child: Text('Yes')),
                                                OutlinedButton(onPressed: ()async{
                                                  Navigator.pop(context);
                                                }, child: Text('Cancel')),
                                              ],
                                            );
                                          });

                                        },
                                            child: Card(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    children: [
                                                      Expanded(
                                                          flex: 3,
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(2.0),
                                                            child: Text(
                                                              snapshot.data[i]
                                                                      ['name']
                                                                  .toString(),
                                                              style: GoogleFonts
                                                                  .alice(),
                                                            ),
                                                          )),
                                                      Expanded(
                                                          flex: 3,
                                                          child: Text(
                                                            snapshot.data[i]
                                                                    ['date']
                                                                .toString(),
                                                            style: GoogleFonts
                                                                .alice(),
                                                          )),
                                                      Expanded(
                                                          flex: 2,
                                                          child: Text(
                                                            snapshot.data[i]
                                                                    ['roll_no']
                                                                .toString(),
                                                            style: GoogleFonts
                                                                .alice(),
                                                          )),
                                                      Expanded(
                                                          flex: 2,
                                                          child: Text(
                                                            snapshot.data[i]
                                                                    ['status']
                                                                .toString(),
                                                            style: GoogleFonts
                                                                .alice(),
                                                          )),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                          )
                                          : Container();
                                    })
                                : Container(
                                    child: Center(
                                        child: SpinKitCircle(
                                    color: Colors.indigo,
                                  ))),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }
}

class ExamTimeTableSelectedData extends StatelessWidget {
  final id;
  final String label;
  const ExamTimeTableSelectedData({Key? key, required this.label, this.id})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
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
                label,
                style: GoogleFonts.alice(),
              )),
          body: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
                child: FutureBuilder(
              future: GetData(context: context).getSelectedExamTimeTable(id),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.data == null) {
                  return SpinKitCircle(
                    color: Colors.indigo,
                  );
                } else {
                  return RefreshIndicator(
                      onRefresh: () {
                        return GetData(context: context)
                            .getSelectedExamTimeTable(id);
                      },
                      child: ListView(
                        children: snapshot.data,
                      ));
                }
              },
            )),
          ),
        ),
        context.watch<UiProvider>().spin == true
            ? SpinKitCircle(color: Colors.indigo)
            : Container()
      ],
    );
  }
}

class ExamSelectedResultData extends StatelessWidget {
  final id;
  final String label;
  const ExamSelectedResultData({Key? key, required this.label, this.id})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String url = context.watch<Connector>().photo != ''
        ? context.watch<Connector>().photo
        : context.watch<Connector>().logo;
    return Stack(
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
                label,
                style: GoogleFonts.alice(),
              )),
          body: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
                child: FutureBuilder(
              future: GetData(context: context).getSelectedResult(id),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.data == null) {
                  return SpinKitCircle(
                    color: Colors.indigo,
                  );
                } else {
                  return RefreshIndicator(
                      onRefresh: () {
                        return GetData(context: context).getSelectedResult(id);
                      },
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CircleAvatar(
                              backgroundColor:
                                  context.watch<UiProvider>().theme == 'light'
                                      ? Color.fromRGBO(135, 112, 255, 0.9)
                                      : Color(0xff2A2B30),
                              radius: 50,
                              child: context.watch<Connector>().logo == ''
                                  ? Icon(Icons.person)
                                  : Container(
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                            image: NetworkImage(url),
                                            fit: BoxFit.contain),
                                      ),
                                    ),
                            ),
                          ),
                          Center(
                            child: Text(
                              context.watch<Connector>().nameOfStudent,
                              style: GoogleFonts.alice(
                                  fontSize: 15, color: Colors.white),
                            ),
                          ),
                          Center(
                            child: Text(
                              'Class ' +
                                  context.watch<Connector>().class_ +
                                  ' - ' +
                                  context.watch<Connector>().section,
                              style: GoogleFonts.alice(
                                  fontSize: 12, color: Colors.white, height: 2),
                            ),
                          ),
                          Center(
                            child: Text(
                              'Roll No : ' + context.watch<Connector>().roll_no,
                              style: GoogleFonts.alice(
                                  fontSize: 12, color: Colors.white, height: 2),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 15.0),
                              child: ListView(
                                children: snapshot.data,
                              ),
                            ),
                          ),
                        ],
                      ));
                }
              },
            )),
          ),
        ),
        context.watch<UiProvider>().spin == true
            ? SpinKitCircle(color: Colors.indigo)
            : Container()
      ],
    );
  }
}

class ExamResultData extends StatelessWidget {
  final String label;
  const ExamResultData({
    Key? key,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
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
                label,
                style: GoogleFonts.alice(),
              )),
          body: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
                child: FutureBuilder(
              future: GetData(context: context).getExamResults(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.data == null) {
                  return SpinKitCircle(
                    color: Colors.indigo,
                  );
                } else {
                  return RefreshIndicator(
                      onRefresh: () {
                        return GetData(context: context).getExamResults();
                      },
                      child: ListView(
                        children: snapshot.data,
                      ));
                }
              },
            )),
          ),
        ),
        context.watch<UiProvider>().spin == true
            ? SpinKitCircle(color: Colors.indigo)
            : Container()
      ],
    );
  }
}

class AdmitCardSelectedData extends StatelessWidget {
  final id;
  final String label;
  const AdmitCardSelectedData({Key? key, required this.label, this.id})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String url = context.watch<Connector>().photo != ''
        ? context.watch<Connector>().photo
        : context.watch<Connector>().logo;
    return Stack(
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
                label,
                style: GoogleFonts.alice(),
              )),
          body: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
                child: FutureBuilder(
              future: GetData(context: context).getSelectedAdmitCard(id),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.data == null) {
                  return SpinKitCircle(
                    color: Colors.indigo,
                  );
                } else {
                  return RefreshIndicator(
                      onRefresh: () {
                        return GetData(context: context)
                            .getSelectedAdmitCard(id);
                      },
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CircleAvatar(
                              backgroundColor:
                                  context.watch<UiProvider>().theme == 'light'
                                      ? Color.fromRGBO(135, 112, 255, 0.9)
                                      : Color(0xff2A2B30),
                              radius: 50,
                              child: context.watch<Connector>().logo == ''
                                  ? Icon(Icons.person)
                                  : Container(
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                            image: NetworkImage(url),
                                            fit: BoxFit.contain),
                                      ),
                                    ),
                            ),
                          ),
                          Center(
                            child: Text(
                              context.watch<Connector>().nameOfStudent,
                              style: GoogleFonts.alice(
                                  fontSize: 15, color: Colors.white),
                            ),
                          ),
                          Center(
                            child: Text(
                              'Class ' +
                                  context.watch<Connector>().class_ +
                                  ' - ' +
                                  context.watch<Connector>().section,
                              style: GoogleFonts.alice(
                                  fontSize: 12, color: Colors.white, height: 2),
                            ),
                          ),
                          Center(
                            child: Text(
                              'Roll No : ' + context.watch<Connector>().roll_no,
                              style: GoogleFonts.alice(
                                  fontSize: 12, color: Colors.white, height: 2),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 15.0),
                              child: ListView(
                                children: snapshot.data,
                              ),
                            ),
                          ),
                        ],
                      ));
                }
              },
            )),
          ),
        ),
        context.watch<UiProvider>().spin == true
            ? SpinKitCircle(color: Colors.indigo)
            : Container()
      ],
    );
  }
}

class AdmitCardData extends StatelessWidget {
  final String label;
  const AdmitCardData({Key? key, required this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
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
                label,
                style: GoogleFonts.alice(),
              )),
          body: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
                child: FutureBuilder(
              future: GetData(context: context).getAdmitCard(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.data == null) {
                  return SpinKitCircle(
                    color: Colors.indigo,
                  );
                } else {
                  return RefreshIndicator(
                      onRefresh: () {
                        return GetData(context: context).getAdmitCard();
                      },
                      child: ListView(
                        children: snapshot.data,
                      ));
                }
              },
            )),
          ),
        ),
        context.watch<UiProvider>().spin == true
            ? SpinKitCircle(color: Colors.indigo)
            : Container()
      ],
    );
  }
}

class StaffAttendances extends StatelessWidget {
  final String label;
  const StaffAttendances({Key? key, required this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
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
                label,
                style: GoogleFonts.alice(),
              )),
          body: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
                child: FutureBuilder(
              future: GetData(context: context).StaffAttendance(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.data == null) {
                  return SpinKitCircle(
                    color: Colors.indigo,
                  );
                } else {
                  return RefreshIndicator(
                      onRefresh: () {
                        return GetData(context: context).getExamTimeTable();
                      },
                      child: Column(
                        children: [
                          Card(
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'Date',
                                      style: GoogleFonts.alice(),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'Date',
                                      style: GoogleFonts.alice(),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: ListView.builder(
                                itemCount: snapshot.data.length,
                                itemBuilder: (context, i) {
                                  return Card(
                                    child: Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(snapshot.data[i]
                                                    ['attendance_date']
                                                .toString()),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(snapshot.data[i]
                                                    ['status']
                                                .toString()),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }),
                          ),
                        ],
                      ));
                }
              },
            )),
          ),
        ),
        context.watch<UiProvider>().spin == true
            ? SpinKitCircle(color: Colors.indigo)
            : Container()
      ],
    );
  }
}

class ExamTimeTableData extends StatelessWidget {
  final String label;
  const ExamTimeTableData({Key? key, required this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
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
                label,
                style: GoogleFonts.alice(),
              )),
          body: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
                child: FutureBuilder(
              future: GetData(context: context).getExamTimeTable(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.data == null) {
                  return SpinKitCircle(
                    color: Colors.indigo,
                  );
                } else {
                  return RefreshIndicator(
                      onRefresh: () {
                        return GetData(context: context).getExamTimeTable();
                      },
                      child: ListView(
                        children: snapshot.data,
                      ));
                }
              },
            )),
          ),
        ),
        context.watch<UiProvider>().spin == true
            ? SpinKitCircle(color: Colors.indigo)
            : Container()
      ],
    );
  }
}

class LiveClassData extends StatelessWidget {
  final String label;
  const LiveClassData({Key? key, required this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
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
                label,
                style: GoogleFonts.alice(),
              )),
          body: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
                child: FutureBuilder(
              future: GetData(context: context).getLiveClass(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.data == null) {
                  return SpinKitCircle(
                    color: Colors.indigo,
                  );
                } else {
                  return RefreshIndicator(
                      onRefresh: () {
                        return GetData(context: context).getLiveClass();
                      },
                      child: ListView(
                        children: snapshot.data,
                      ));
                }
              },
            )),
          ),
        ),
        context.watch<UiProvider>().spin == true
            ? SpinKitCircle(color: Colors.indigo)
            : Container()
      ],
    );
  }
}

class LibraryData extends StatelessWidget {
  final String label;
  const LibraryData({Key? key, required this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
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
                label,
                style: GoogleFonts.alice(),
              )),
          body: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
                child: FutureBuilder(
              future: GetData(context: context).getLibraryBooks(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.data == null) {
                  return SpinKitCircle(
                    color: Colors.indigo,
                  );
                } else {
                  return RefreshIndicator(
                    onRefresh: () {
                      return GetData(context: context).getLibraryBooks();
                    },
                    child: ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Books(
                            title: snapshot.data[index].book_title,
                            author: snapshot.data[index].author,
                            issued_date: snapshot.data[index].date_issued,
                            bookNumber: snapshot.data[index].book_number,
                            returnDate: snapshot.data[index].return_date,
                            status: snapshot.data[index].return_status);
                      },
                    ),
                  );
                }
              },
            )),
          ),
        ),
        context.watch<UiProvider>().spin == true
            ? SpinKitCircle(color: Colors.indigo)
            : Container()
      ],
    );
  }
}

class EventsData extends StatelessWidget {
  final String label;
  const EventsData({Key? key, required this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
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
                label,
                style: GoogleFonts.alice(),
              )),
          body: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
                child: FutureBuilder(
              future: GetData(context: context).getEvents(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.data == null) {
                  return SpinKitCircle(
                    color: Colors.indigo,
                  );
                } else {
                  return RefreshIndicator(
                    onRefresh: () {
                      return GetData(context: context).getEvents();
                    },
                    child: ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Card(
                          child: ListTile(
                              leading: Icon(
                                Icons.event,
                                size: 30,
                                color:
                                    context.watch<UiProvider>().theme == 'light'
                                        ? Color(0xff0DB6D1)
                                        : Color(0xff00BBD3),
                              ),
                              title: Text(
                                snapshot.data[index].title,
                                style: themeLabel,
                              ),
                              subtitle: Text(
                                'Date : ${snapshot.data[index].event_date}',
                                style: GoogleFonts.alice(color: Colors.black54),
                              ),
                              trailing: OutlinedButton(
                                onPressed: () async {
                                  final role = await Storage().getData('Role');
                                  Provider.of<Connector>(context, listen: false)
                                      .join(snapshot.data[index].has_joined
                                          .toString());
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return
                                      BottomNavigationBarPage(icon: Icons.event,pageLabel: 'Events',page:EventsDetails(
                                        label: snapshot.data[index].title,
                                        title: snapshot.data[index].title,
                                        id: snapshot.data[index].id,
                                        image: snapshot.data[index].image,
                                        is_joined: snapshot.data[index].has_joined
                                            .toString(),
                                        role: role,
                                      ));



                                  }));
                                },
                                child: Text(
                                  'View',
                                  style: GoogleFonts.alice(color: Colors.black),
                                ),
                              )),
                        );
                      },
                    ),
                  );
                }
              },
            )),
          ),
        ),
        context.watch<UiProvider>().spin == true
            ? SpinKitCircle(color: Colors.indigo)
            : Container()
      ],
    );
  }
}

class NotificationData extends StatelessWidget {
  final String label;
  const NotificationData({Key? key, required this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
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
                label,
                style: GoogleFonts.alice(),
              )),
          body: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
                child: FutureBuilder(
              future: GetData(context: context).getNotice(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.data == null) {
                  return SpinKitCircle(
                    color: Colors.indigo,
                  );
                } else {
                  return RefreshIndicator(
                    onRefresh: () {
                      return GetData(context: context).getNotice();
                    },
                    child: ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Notice(
                          url: snapshot.data[index].url,
                          title: snapshot.data[index].title,
                          date: snapshot.data[index].date,
                        );
                      },
                    ),
                  );
                }
              },
            )),
          ),
        ),
        context.watch<UiProvider>().spin == true
            ? SpinKitCircle(color: Colors.indigo)
            : Container()
      ],
    );
  }
}

class AttendanceData extends StatelessWidget {
  final String label;
  const AttendanceData({Key? key, required this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
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
                label,
                style: GoogleFonts.alice(),
              )),
          body: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
                child: FutureBuilder(
              future: GetData(context: context).getAttendance(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.data == null) {
                  return SpinKitCircle(
                    color: Colors.indigo,
                  );
                } else {
                  return RefreshIndicator(
                    onRefresh: () {
                      return GetData(context: context).getAttendance();
                    },
                    child: Column(
                      children: [
                        Attendance(
                          t1: 'Months',
                          t2: 'Total',
                          t3: 'Presents',
                          theme: themeLabel,
                          t4: 'absents',
                          t5: '%',
                        ),
                        Expanded(
                          child: ListView.builder(
                            itemCount: snapshot.data.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Attendance(
                                t1: snapshot.data[index].month,
                                t2: snapshot.data[index].total_Attendance,
                                t3: snapshot.data[index].presents,
                                t4: snapshot.data[index].absents,
                                t5: snapshot.data[index].percentage,
                                theme: themeSubLabel,
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                }
              },
            )),
          ),
        ),
        context.watch<UiProvider>().spin == true
            ? SpinKitCircle(color: Colors.indigo)
            : Container()
      ],
    );
  }
}

class HomeWorkPage extends StatelessWidget {
  final String label;
  final role;
  HomeWorkPage({Key? key, required this.label, required this.role})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
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
              label,
              style: GoogleFonts.alice(),
            ),
            actions: [
              role.toString() == 'staff'
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: OutlinedButton(
                          onPressed: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return
                                BottomNavigationBarPage(icon: Icons.home_work,pageLabel: 'Home Work',page:role  == 'staff'?AssignHomeWork( title: 'Assign HomeWork',) :AttendanceData(

                                  label: 'Assign',
                                ));


                            }));
                          },
                          child: Text(
                            'Assign',
                            style: GoogleFonts.alice(color: Colors.white),
                          )),
                    )
                  : Container()
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
                child: FutureBuilder(
              future: GetData(context: context).getHomeWork(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.data == null) {
                  return SpinKitCircle(
                    color: Colors.indigo,
                  );
                } else {
                  return RefreshIndicator(
                    onRefresh: () {
                      return GetData(context: context).getHomeWork();
                    },
                    child: ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return HomeWork(
                          title: snapshot.data[index].title,
                          subtitle: snapshot.data[index].date,
                          onTap: () async {
                            print(snapshot.data[index].id.toString());
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        HomeWorkAttachmentsPage(
                                          id: snapshot.data[index].id,
                                          label: 'Attachments',
                                        )));
                          },
                        );
                      },
                    ),
                  );
                }
              },
            )),
          ),
        ),
        context.watch<UiProvider>().spin == true
            ? SpinKitCircle(color: Colors.indigo)
            : Container()
      ],
    );
  }
}

class HomeWorkAttachmentsPage extends StatefulWidget {
  final id;
  final String label;
  const HomeWorkAttachmentsPage({Key? key, required this.label, this.id})
      : super(key: key);

  @override
  State<HomeWorkAttachmentsPage> createState() =>
      _HomeWorkAttachmentsPageState();
}

class _HomeWorkAttachmentsPageState extends State<HomeWorkAttachmentsPage> {
  var role;
  getRole() async {
    var rol = await Storage().getData('Role');
    setState(() {
      role = rol;
    });
  }

  @override
  void initState() {
    getRole();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
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
              widget.label,
              style: GoogleFonts.alice(),
            ),
            actions: [
              role == 'staff'
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: OutlinedButton(
                          onPressed: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return HomeworkSubmission(id: widget.id);
                            }));
                          },
                          child: Text('Submission')),
                    )
                  : Container()
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
                child: FutureBuilder(
              future:
                  GetData(context: context).getHomeWorkAttachments(widget.id),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.data == null) {
                  return SpinKitCircle(
                    color: Colors.indigo,
                  );
                } else {
                  return RefreshIndicator(
                    onRefresh: () {
                      return GetData(context: context)
                          .getHomeWorkAttachments(widget.id);
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            snapshot.data.description,
                            style: GoogleFonts.alice(
                                color: Colors.white, fontSize: 20),
                          ),
                        ),
                        Expanded(
                          child: ListView.builder(
                            itemCount: snapshot.data.homeAttachment.length,
                            itemBuilder: (BuildContext context, int index) {
                              return HomeWork(
                                title: snapshot.data.homeAttachment[index].file,
                                subtitle: '',
                                onTap: () async {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return PdfView(
                                      attachments: [],
                                      fileName: snapshot
                                          .data.homeAttachment[index].file,
                                      url: snapshot
                                          .data.homeAttachment[index].url,
                                    );
                                  }));
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                }
              },
            )),
          ),
        ),
        context.watch<UiProvider>().spin == true
            ? SpinKitCircle(color: Colors.indigo)
            : Container()
      ],
    );
  }
}

class GetQuizCategory extends StatelessWidget {
  ///this is category
  final String label;
  const GetQuizCategory({Key? key, required this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
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
                label,
                style: GoogleFonts.alice(),
              )),
          body: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
                child: FutureBuilder(
              future: GetData(context: context).getQuizCategory(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.data == null) {
                  return SpinKitCircle(
                    color: Colors.indigo,
                  );
                } else {
                  return RefreshIndicator(
                    onRefresh: () {
                      return GetData(context: context).getQuizCategory();
                    },
                    child: ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return OnlineExamCards(
                            sub: snapshot.data[index].title,
                            time: snapshot.data[index].description,
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          BottomNavigationBarPage(
                                              icon: Icons.class_,
                                              pageLabel: 'Online Exam',
                                              page: GetQuiz(
                                                label: 'Online Exam',
                                                id: snapshot.data[index].id,
                                              ))));
                            });
                      },
                    ),
                  );
                }
              },
            )),
          ),
        ),
        context.watch<UiProvider>().spin == true
            ? SpinKitCircle(color: Colors.indigo)
            : Container()
      ],
    );
  }
}

class GetQuiz extends StatelessWidget {
  ///this is category
  final id;
  final String label;
  const GetQuiz({Key? key, required this.label, this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
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
                label,
                style: GoogleFonts.alice(),
              )),
          body: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
                child: FutureBuilder(
              future: GetData(context: context).getQuiz(id),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.data == null) {
                  return SpinKitCircle(
                    color: Colors.indigo,
                  );
                } else {
                  return RefreshIndicator(
                    onRefresh: () {
                      return GetData(context: context).getQuiz(id);
                    },
                    child: ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return OnlineExamCards(
                            sub: snapshot.data[index].title,
                            time: snapshot.data[index].description,
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => WebViewPage(
                                            title: snapshot.data[index].title,
                                            url: Api.getExamUrl +
                                                snapshot.data[index].id,
                                          )));
                            });
                      },
                    ),
                  );
                }
              },
            )),
          ),
        ),
        context.watch<UiProvider>().spin == true
            ? SpinKitCircle(color: Colors.indigo)
            : Container()
      ],
    );
  }
}

class GetTimeTable extends StatelessWidget {
  final String label;
  const GetTimeTable({Key? key, required this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
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
                label,
                style: GoogleFonts.alice(),
              )),
          body: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
                child: FutureBuilder(
              future: GetData(context: context).getTimeTable(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.data == null) {
                  return SpinKitCircle(
                    color: Colors.indigo,
                  );
                } else {
                  return RefreshIndicator(
                    onRefresh: () {
                      return GetData(context: context).getTimeTable();
                    },
                    child: ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return TimeTableCard(
                          t1: snapshot.data[index].day,
                          routine: snapshot.data[index].routine,
                        );
                      },
                    ),
                  );
                }
              },
            )),
          ),
        ),
        context.watch<UiProvider>().spin == true
            ? SpinKitCircle(color: Colors.indigo)
            : Container()
      ],
    );
  }
}

class GetSubjectsLists extends StatelessWidget {
  final String label;
  const GetSubjectsLists({Key? key, required this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
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
                label,
                style: GoogleFonts.alice(),
              )),
          body: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
                child: FutureBuilder(
              future: GetData(context: context).getSubjectList(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.data == null) {
                  return SpinKitCircle(
                    color: Colors.indigo,
                  );
                } else {
                  return RefreshIndicator(
                    onRefresh: () {
                      return GetData(context: context).getSubjectList();
                    },
                    child: ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return SubjectsCard(
                          id: snapshot.data[index].id,
                          subName: snapshot.data[index].subName,
                          code: snapshot.data[index].code,
                          type: snapshot.data[index].type,
                          teacher: snapshot.data[index].teacher,
                          ontap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => GetMaterialType(
                                    label: '${snapshot.data[index].subName}',
                                    id: snapshot.data[index].id,
                                  ),
                                ));
                          },
                        );
                      },
                    ),
                  );
                }
              },
            )),
          ),
        ),
        context.watch<UiProvider>().spin == true
            ? SpinKitCircle(color: Colors.indigo)
            : Container()
      ],
    );
  }
}

class GetChapters extends StatelessWidget {
  final mType;
  final id;
  final String label;
  const GetChapters({Key? key, required this.label, this.id, this.mType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
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
                label,
                style: GoogleFonts.alice(),
              )),
          body: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
                child: ListView.builder(
                    itemCount: 25,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        child: ListTile(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return GetStudyMaterials(
                                label: label + ' Chapter ${index + 1}',
                                cNo: index + 1,
                                mType: mType,
                                sid: id,
                              );
                            }));
                          },
                          leading: Icon(
                            Icons.auto_stories,
                            color: context.watch<UiProvider>().theme == 'light'
                                ? Color(0xff0DB6D1)
                                : Color(0xff00BBD3),
                          ),
                          title: Text(
                            'Chapter ${index + 1}',
                            style: GoogleFonts.alice(
                              color: Colors.black,
                            ),
                          ),
                          trailing: CircleAvatar(
                            child: Icon(
                              Icons.chevron_right,
                              color:
                                  context.watch<UiProvider>().theme == 'light'
                                      ? Color(0xffF76D87)
                                      : Color(0xff77BF22),
                            ),
                            backgroundColor:
                                context.watch<UiProvider>().theme == 'light'
                                    ? Color.fromRGBO(254, 233, 238, 0.8)
                                    : Color.fromRGBO(57, 67, 52, 0.8),
                          ),
                        ),
                      );
                    })),
          ),
        ),
        context.watch<UiProvider>().spin == true
            ? SpinKitCircle(color: Colors.indigo)
            : Container()
      ],
    );
  }
}

class GetMaterialType extends StatelessWidget {
  final id;
  final String label;
  const GetMaterialType({Key? key, required this.label, this.id})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
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
                label,
                style: GoogleFonts.alice(),
              )),
          body: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
                child: context
                                .watch<Connector>()
                                .class_
                                .contains('10') ==
                            true ||
                        context
                                .watch<Connector>()
                                .class_
                                .contains('9') ==
                            true ||
                        context
                                .watch<Connector>()
                                .class_
                                .contains('8') ==
                            true ||
                        context
                                .watch<Connector>()
                                .class_
                                .contains('7') ==
                            true ||
                        context
                                .watch<Connector>()
                                .class_
                                .contains('6') ==
                            true ||
                        context
                                .watch<Connector>()
                                .class_
                                .contains('5') ==
                            true ||
                        context
                                .watch<Connector>()
                                .class_
                                .contains('4') ==
                            true ||
                        context
                                .watch<Connector>()
                                .class_
                                .contains('3') ==
                            true ||
                        context.watch<Connector>().class_.contains('2') ==
                            true ||
                        context.watch<Connector>().class_.contains('1') == true
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                  child: Cards(
                                      icon: Icons.play_arrow,
                                      text: 'Video',
                                      color:
                                          context.watch<UiProvider>().theme ==
                                                  'light'
                                              ? Color(0xffffffff)
                                              : Color(0xff303539),
                                      bgColor: context
                                                  .watch<UiProvider>()
                                                  .theme ==
                                              'light'
                                          ? Color.fromRGBO(229, 250, 253, 0.8)
                                          : Color.fromRGBO(38, 76, 91, 0.8),
                                      iconColor:
                                          context.watch<UiProvider>().theme ==
                                                  'light'
                                              ? Colors.redAccent
                                              : Color(0xff00BBD3),
                                      ontap: () {
                                        Navigator.push(context,
                                            MaterialPageRoute(
                                                builder: (context) {
                                          return GetChapters(
                                            label: label + ' Videos',
                                            id: id,
                                            mType: 'Video',
                                          );
                                        }));
                                      })),
                              Expanded(
                                  child: Cards(
                                      icon: Icons.library_books,
                                      text: 'Notes',
                                      color:
                                          context.watch<UiProvider>().theme ==
                                                  'light'
                                              ? Color(0xffffffff)
                                              : Color(0xff303539),
                                      bgColor: context
                                                  .watch<UiProvider>()
                                                  .theme ==
                                              'light'
                                          ? Color.fromRGBO(243, 230, 249, 0.8)
                                          : Color.fromRGBO(64, 63, 60, 0.8),
                                      iconColor:
                                          context.watch<UiProvider>().theme ==
                                                  'light'
                                              ? Color(0xff633FD8)
                                              : Color(0xffF87381),
                                      ontap: () {
                                        Navigator.push(context,
                                            MaterialPageRoute(
                                                builder: (context) {
                                          return GetChapters(
                                            label: label + ' Notes',
                                            id: id,
                                            mType: 'Notes',
                                          );
                                        }));
                                      })),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                  child: Cards(
                                      icon: Icons.quiz,
                                      text: 'Question Bank',
                                      color:
                                          context.watch<UiProvider>().theme ==
                                                  'light'
                                              ? Color(0xffffffff)
                                              : Color(0xff303539),
                                      bgColor: context
                                                  .watch<UiProvider>()
                                                  .theme ==
                                              'light'
                                          ? Color.fromRGBO(254, 233, 238, 0.8)
                                          : Color.fromRGBO(57, 67, 52, 0.8),
                                      iconColor:
                                          context.watch<UiProvider>().theme ==
                                                  'light'
                                              ? Color(0xffF76D87)
                                              : Color(0xff77BF22),
                                      ontap: () {
                                        Navigator.push(context,
                                            MaterialPageRoute(
                                                builder: (context) {
                                          return GetChapters(
                                            label: label + ' QuestionBank',
                                            id: id,
                                            mType: 'QuestionBank',
                                          );
                                        }));
                                      })),
                              Expanded(
                                  child: Cards(
                                      icon: Icons
                                          .airline_seat_legroom_extra_rounded,
                                      text: 'Others',
                                      color:
                                          context.watch<UiProvider>().theme ==
                                                  'light'
                                              ? Color(0xffffffff)
                                              : Color(0xff303539),
                                      bgColor: context
                                                  .watch<UiProvider>()
                                                  .theme ==
                                              'light'
                                          ? Color.fromRGBO(238, 253, 255, 0.8)
                                          : Color.fromRGBO(51, 58, 64, 0.8),
                                      iconColor:
                                          context.watch<UiProvider>().theme ==
                                                  'light'
                                              ? Color(0xff4BBAFE)
                                              : Color(0xff44C2F8),
                                      ontap: () {
                                        Navigator.push(context,
                                            MaterialPageRoute(
                                                builder: (context) {
                                          return GetChapters(
                                            label: label + ' Others',
                                            id: id,
                                            mType: 'Others',
                                          );
                                        }));
                                      })),
                            ],
                          ),
                        ],
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                  child: Cards(
                                      icon: Icons.play_arrow,
                                      text: 'Video',
                                      color:
                                          context.watch<UiProvider>().theme ==
                                                  'light'
                                              ? Color(0xffffffff)
                                              : Color(0xff303539),
                                      bgColor: context
                                                  .watch<UiProvider>()
                                                  .theme ==
                                              'light'
                                          ? Color.fromRGBO(229, 250, 253, 0.8)
                                          : Color.fromRGBO(38, 76, 91, 0.8),
                                      iconColor:
                                          context.watch<UiProvider>().theme ==
                                                  'light'
                                              ? Colors.redAccent
                                              : Color(0xff00BBD3),
                                      ontap: () {
                                        Navigator.push(context,
                                            MaterialPageRoute(
                                                builder: (context) {
                                          return GetChapters(
                                            label: label + ' Videos',
                                            id: id,
                                            mType: 'Video',
                                          );
                                        }));
                                      })),
                              Expanded(
                                  child: Cards(
                                      icon: Icons.library_books,
                                      text: 'Notes',
                                      color:
                                          context.watch<UiProvider>().theme ==
                                                  'light'
                                              ? Color(0xffffffff)
                                              : Color(0xff303539),
                                      bgColor: context
                                                  .watch<UiProvider>()
                                                  .theme ==
                                              'light'
                                          ? Color.fromRGBO(243, 230, 249, 0.8)
                                          : Color.fromRGBO(64, 63, 60, 0.8),
                                      iconColor:
                                          context.watch<UiProvider>().theme ==
                                                  'light'
                                              ? Color(0xff633FD8)
                                              : Color(0xffF87381),
                                      ontap: () {
                                        Navigator.push(context,
                                            MaterialPageRoute(
                                                builder: (context) {
                                          return GetChapters(
                                            label: label + ' Notes',
                                            id: id,
                                            mType: 'Notes',
                                          );
                                        }));
                                      })),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                  child: Cards(
                                      icon: Icons.quiz,
                                      text: 'Question Bank',
                                      color:
                                          context.watch<UiProvider>().theme ==
                                                  'light'
                                              ? Color(0xffffffff)
                                              : Color(0xff303539),
                                      bgColor: context
                                                  .watch<UiProvider>()
                                                  .theme ==
                                              'light'
                                          ? Color.fromRGBO(254, 233, 238, 0.8)
                                          : Color.fromRGBO(57, 67, 52, 0.8),
                                      iconColor:
                                          context.watch<UiProvider>().theme ==
                                                  'light'
                                              ? Color(0xffF76D87)
                                              : Color(0xff77BF22),
                                      ontap: () {
                                        Navigator.push(context,
                                            MaterialPageRoute(
                                                builder: (context) {
                                          return GetChapters(
                                            label: label + ' QuestionBank',
                                            id: id,
                                            mType: 'QuestionBank',
                                          );
                                        }));
                                      })),
                              Expanded(
                                  child: Cards(
                                      icon: Icons
                                          .airline_seat_legroom_extra_rounded,
                                      text: 'Entrance Exam',
                                      color:
                                          context.watch<UiProvider>().theme ==
                                                  'light'
                                              ? Color(0xffffffff)
                                              : Color(0xff303539),
                                      bgColor: context
                                                  .watch<UiProvider>()
                                                  .theme ==
                                              'light'
                                          ? Color.fromRGBO(238, 253, 255, 0.8)
                                          : Color.fromRGBO(51, 58, 64, 0.8),
                                      iconColor:
                                          context.watch<UiProvider>().theme ==
                                                  'light'
                                              ? Color(0xff4BBAFE)
                                              : Color(0xff44C2F8),
                                      ontap: () {
                                        Navigator.push(context,
                                            MaterialPageRoute(
                                                builder: (context) {
                                          return GetChapters(
                                            label: label + ' Entrance Exam',
                                            id: id,
                                            mType: 'EntranceExam',
                                          );
                                        }));
                                      })),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                  child: Cards(
                                      icon: Icons.architecture_outlined,
                                      text: 'Unit Test',
                                      color:
                                          context.watch<UiProvider>().theme ==
                                                  'light'
                                              ? Color(0xffffffff)
                                              : Color(0xff303539),
                                      bgColor: context
                                                  .watch<UiProvider>()
                                                  .theme ==
                                              'light'
                                          ? Color.fromRGBO(242, 246, 252, 0.8)
                                          : Color.fromRGBO(56, 66, 74, 0.8),
                                      iconColor:
                                          context.watch<UiProvider>().theme ==
                                                  'light'
                                              ? Color(0xffB26FE3)
                                              : Color(0xff586594),
                                      ontap: () {
                                        Navigator.push(context,
                                            MaterialPageRoute(
                                                builder: (context) {
                                          return GetChapters(
                                            label: label + ' UnitTest',
                                            id: id,
                                            mType: 'UnitTest',
                                          );
                                        }));
                                      })),
                              Expanded(
                                  child: Cards(
                                      icon: Icons.library_books,
                                      text: 'NCERT Text',
                                      color:
                                          context.watch<UiProvider>().theme ==
                                                  'light'
                                              ? Color(0xffffffff)
                                              : Color(0xff303539),
                                      bgColor: context
                                                  .watch<UiProvider>()
                                                  .theme ==
                                              'light'
                                          ? Color.fromRGBO(247, 245, 241, 0.8)
                                          : Color.fromRGBO(73, 68, 62, 0.8),
                                      iconColor:
                                          context.watch<UiProvider>().theme ==
                                                  'light'
                                              ? Color(0xffFFA766)
                                              : Color(0xffF3A168),
                                      ontap: () {
                                        Navigator.push(context,
                                            MaterialPageRoute(
                                                builder: (context) {
                                          return GetChapters(
                                            label: label + ' NCERTText',
                                            id: id,
                                            mType: 'NCERTText',
                                          );
                                        }));
                                      })),
                            ],
                          )
                        ],
                      )),
          ),
        ),
        context.watch<UiProvider>().spin == true
            ? SpinKitCircle(color: Colors.indigo)
            : Container()
      ],
    );
  }
}

class GetLeaveHistoryPage extends StatelessWidget {
  final String label;
  const GetLeaveHistoryPage({Key? key, required this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
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
                label,
                style: GoogleFonts.alice(),
              )),
          body: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
                child: FutureBuilder(
              future: GetData(context: context).getLeaveHistory(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.data == null) {
                  return SpinKitCircle(
                    color: Colors.indigo,
                  );
                } else {
                  return RefreshIndicator(
                    onRefresh: () {
                      return GetData(context: context).getLeaveHistory();
                    },
                    child: Column(
                      children: [
                        LeaveHistoryCard(
                          t1: 'Reason',
                          t2: 'Date',
                          t3: 'Status',
                          textTheme: themeLabel,
                        ),
                        Expanded(
                          child: ListView.builder(
                            itemCount: snapshot.data.length,
                            itemBuilder: (BuildContext context, int index) {
                              return LeaveHistoryCard(
                                textTheme: themeSubLabel,
                                t1: snapshot.data[index].reason,
                                t2: snapshot.data[index].date,
                                t3: snapshot.data[index].status,
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                }
              },
            )),
          ),
        ),
        context.watch<UiProvider>().spin == true
            ? SpinKitCircle(color: Colors.indigo)
            : Container()
      ],
    );
  }
}

class StaffGetLeaveHistoryPage extends StatefulWidget {
  final String label;
  const StaffGetLeaveHistoryPage({Key? key, required this.label})
      : super(key: key);

  @override
  State<StaffGetLeaveHistoryPage> createState() =>
      _StaffGetLeaveHistoryPageState();
}

class _StaffGetLeaveHistoryPageState extends State<StaffGetLeaveHistoryPage> {
  @override
  Widget build(BuildContext context) {
    return Stack(
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
                widget.label,
                style: GoogleFonts.alice(),
              )),
          body: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
                child: FutureBuilder(
              future: GetData(context: context).staffLeaveHistory(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.data == null) {
                  return SpinKitCircle(
                    color: Colors.indigo,
                  );
                } else {
                  return RefreshIndicator(
                    onRefresh: () {
                      return GetData(context: context).getLeaveHistory();
                    },
                    child: Column(
                      children: [
                        LeaveHistoryCard(
                          t1: 'Name',
                          t2: 'Date',
                          t3: 'Status',
                          textTheme: themeLabel,
                        ),
                        Expanded(
                          child: ListView.builder(
                            itemCount: snapshot.data.length,
                            itemBuilder: (BuildContext context, int index) {
                              return InkWell(
                                onTap: () async {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: snapshot.data[index].status
                                                      .toString() ==
                                                  'false'
                                              ? Text(
                                                  'Are you sure to approve the leave')
                                              : Text(
                                                  'Are you sure to reject the leave'),
                                          content: Container(
                                            height: 80,
                                            child: Stack(
                                              children: [
                                                Text('Reason:  \n' +
                                                    snapshot.data[index].reason),
                                                context.watch<UiProvider>().spin == true
                                                    ? SpinKitCircle(color: Colors.indigo)
                                                    : Container()
                                              ],
                                            ),
                                          ),
                                          actions: [
                                            OutlinedButton(
                                                onPressed: () async {
                                                  Navigator.pop(context);
                                                },
                                                child: Text(
                                                  'Cancel',
                                                  style: GoogleFonts.alice(
                                                      color: Colors.indigo),
                                                )),
                                            OutlinedButton(
                                                onPressed: () async {
                                                  Provider.of<UiProvider>(
                                                          context,
                                                          listen: false)
                                                      .spinner();
                                                  await SubmitData()
                                                      .approveLeave(snapshot
                                                          .data[index].id)
                                                      .then((value) {
                                                    Navigator.pop(context);
                                                    Fluttertoast.showToast(
                                                        msg: value.toString());
                                                    print(value.toString());
                                                    setState(() {});
                                                  });
                                                  Provider.of<UiProvider>(
                                                          context,
                                                          listen: false)
                                                      .spinner();
                                                },
                                                child: Text(
                                                  'Yes',
                                                  style: GoogleFonts.alice(
                                                      color: Colors.indigo),
                                                )),
                                          ],
                                        );
                                      });
                                },
                                child: LeaveHistoryCard(
                                  textTheme: themeSubLabel,
                                  t1: snapshot.data[index].name,
                                  t2: snapshot.data[index].date,
                                  t3: snapshot.data[index].status.toString() == 'true' ? 'Approved' : 'Pending',
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                }
              },
            )),
          ),
        ),

      ],
    );
  }
}

class GetStudyMaterials extends StatefulWidget {
  final sid, mType, cNo;
  final String label;
  const GetStudyMaterials(
      {Key? key,
      required this.label,
      required this.sid,
      required this.mType,
      required this.cNo})
      : super(key: key);

  @override
  State<GetStudyMaterials> createState() => _GetStudyMaterialsState();
}

class _GetStudyMaterialsState extends State<GetStudyMaterials> {
  @override
  Widget build(BuildContext context) {
    return Stack(
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
                widget.label,
                style: GoogleFonts.alice(),
              )),
          body: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
                child: FutureBuilder(
              future: GetData(context: context)
                  .getStudyMaterial(widget.sid, widget.mType, widget.cNo),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.data == null) {
                  return SpinKitCircle(
                    color: Colors.indigo,
                  );
                } else {
                  return RefreshIndicator(
                    onRefresh: () {
                      return GetData(context: context).getStudyMaterial(
                          widget.sid, widget.mType, widget.cNo);
                    },
                    child: ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return StudyMaterialDataCard(
                          attachments: snapshot.data[index].attachments,
                          url: snapshot.data[index].url,
                          date: snapshot.data[index].date,
                          title: snapshot.data[index].title,
                          mType: snapshot.data[index].mType,
                        );
                      },
                    ),
                  );
                }
              },
            )),
          ),
        ),
        context.watch<UiProvider>().spin == true
            ? SpinKitCircle(color: Colors.indigo)
            : Container()
      ],
    );
  }
}

class GetPaymentInvoice extends StatelessWidget {
  final String label;
  const GetPaymentInvoice({Key? key, required this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
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
                label,
                style: GoogleFonts.alice(),
              )),
          body: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
                child: FutureBuilder(
              future: GetData(context: context).getPaymentInvoices(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.data == null) {
                  return SpinKitCircle(
                    color: Colors.indigo,
                  );
                } else {
                  return RefreshIndicator(
                    onRefresh: () {
                      return GetData(context: context).getPaymentInvoices();
                    },
                    child: ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return PaymentInvoicesCard(
                            date: snapshot.data[index].date,
                            dueDate: snapshot.data[index].dueDate,
                            invoicesNo: snapshot.data[index].invoicesNo,
                            payable: snapshot.data[index].payable,
                            paid: snapshot.data[index].paid,
                            due: snapshot.data[index].due,
                            title: snapshot.data[index].title);
                      },
                    ),
                  );
                }
              },
            )),
          ),
        ),
        context.watch<UiProvider>().spin == true
            ? SpinKitCircle(color: Colors.indigo)
            : Container()
      ],
    );
  }
}
