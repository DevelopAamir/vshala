import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:vshala/main.dart';

import 'package:vshala/storage/storage.dart';
import 'package:vshala/student/connector/connector.dart';
import 'package:vshala/student/connector/getData.dart';

import 'package:vshala/student/ui/Landing/DrawerPages/Profile.dart';
import 'package:vshala/student/ui/Landing/DrawerPages/submitLeaveNote.dart';
import 'package:vshala/student/ui/Landing/landing.dart';
import 'package:vshala/student/ui/components/uiProvider.dart';
import 'package:vshala/student/ui/components/DataPage.dart';

class Drawers extends StatefulWidget {
  const Drawers({Key? key}) : super(key: key);

  @override
  State<Drawers> createState() => _DrawersState();
}

class _DrawersState extends State<Drawers> {
  var role;
@override
  void initState() {
  getRole();
    super.initState();
  }

  getRole()async{
  var type = await Storage().getData('Role');
  setState(() {
    role = type;
  });

  }
  @override

  Widget build(BuildContext context) {
    String uri = context.watch<Connector>().photo != ''
        ? context.watch<Connector>().photo
        : context.watch<Connector>().logo;
    return Drawer(
        child: Container(
      color: context.watch<UiProvider>().theme == 'light'
          ? Colors.white
          : Color(0xff0F1414),
      child: Column(
        children: [
          DrawerHeader(
            child: Container(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 2,
                      child: CircleAvatar(
                          radius: 40,
                          backgroundColor:
                              context.watch<UiProvider>().theme == 'light'
                                  ? Colors.white
                                  : Color(0xff0F1414),
                          backgroundImage: NetworkImage(uri)),
                    ),
                    Expanded(
                      flex: 3,
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              context.watch<Connector>().nameOfStudent,
                              style: GoogleFonts.alice(
                                  fontSize: 20,
                                  color: context.watch<UiProvider>().theme ==
                                          'light'
                                      ? Color(0xff303539)
                                      : Color(0xffffffff)),
                            ),
                            if(role != 'staff')
                            Text(
                              'Class : ' +
                                  context.watch<Connector>().class_ +
                                  ' - ' +
                                  context.watch<Connector>().section,
                              style: GoogleFonts.alice(
                                  fontSize: 13,
                                  color: context.watch<UiProvider>().theme ==
                                          'light'
                                      ? Color(0xff303539)
                                      : Color(0xffffffff)),
                            ),
                            if(role == 'staff')
                              Text(
                                context.watch<Connector>().level,
                                style: GoogleFonts.alice(
                                    fontSize: 12,
                                    color: context.watch<UiProvider>().theme ==
                                        'light'
                                        ? Color(0xff303539)
                                        : Color(0xffffffff)),
                              ),
                            if(role != 'staff')
                            Text(
                              'Roll No : ' + context.watch<Connector>().roll_no,
                              style: GoogleFonts.alice(
                                  fontSize: 12,
                                  color: context.watch<UiProvider>().theme ==
                                          'light'
                                      ? Color(0xff303539)
                                      : Color(0xffffffff)),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              child: ListView(
                children: [
                  ListTile(
                    leading: Icon(
                      Icons.settings,
                      color: context.watch<UiProvider>().theme == 'light'
                          ? Color(0xff303539)
                          : Color(0xffffffff),
                    ),
                    title: Text(
                      'Theme',
                      style: GoogleFonts.alice(
                          fontSize: 14,
                          color: context.watch<UiProvider>().theme == 'light'
                              ? Color(0xff303539)
                              : Color(0xffffffff)),
                    ),
                    trailing: Switch(
                        value: context.watch<UiProvider>().theme == 'light'
                            ? true
                            : false,
                        onChanged: (v) {
                          Provider.of<UiProvider>(context, listen: false)
                              .changeTheme();
                        }),
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    leading: Icon(
                      Icons.home_filled,
                      color: context.watch<UiProvider>().theme == 'light'
                          ? Color(0xff0DB6D1)
                          : Color(0xff00BBD3),
                    ),
                    title: Text(
                      'Home',
                      style: GoogleFonts.alice(
                          fontSize: 14,
                          color: context.watch<UiProvider>().theme == 'light'
                              ? Color(0xff303539)
                              : Color(0xffffffff)),
                    ),
                  ),
                  ListTile(
                    onTap: () async {
                      Provider.of<UiProvider>(context, listen: false).spinner();
                      await GetData(context: context).getProfile();
                      Provider.of<UiProvider>(context, listen: false).spinner();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BottomNavigationBarPage(
                                    icon: Icons.person,
                                    pageLabel: 'Profile',
                                    page: Profile(),
                                  )));
                    },
                    leading: Icon(
                      Icons.person,
                      color: context.watch<UiProvider>().theme == 'light'
                          ? Color(0xffF76D87)
                          : Color(0xff77BF22),
                    ),
                    title: Text(
                      'Profile',
                      style: GoogleFonts.alice(
                          fontSize: 14,
                          color: context.watch<UiProvider>().theme == 'light'
                              ? Color(0xff303539)
                              : Color(0xffffffff)),
                    ),
                  ),
                  if(role != 'staff')
                  ListTile(
                    onTap: () {
                      GetData(context: context).getQuizCategory();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>BottomNavigationBarPage(icon: Icons.class_,pageLabel: 'Online Exam',page:GetQuizCategory(label: 'Online Quiz'),)
                                  ));
                    },
                    leading: Icon(
                      Icons.class_,
                      color: context.watch<UiProvider>().theme == 'light'
                          ? Color(0xff0DB6D1)
                          : Color(0xff00BBD3),
                    ),
                    title: Text(
                      'Online Exam',
                      style: GoogleFonts.alice(
                          fontSize: 14,
                          color: context.watch<UiProvider>().theme == 'light'
                              ? Color(0xff303539)
                              : Color(0xffffffff)),
                    ),
                  ),
                  ListTile(
                      onTap: () async{
                        final role =  await Storage().getData('Role');
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    BottomNavigationBarPage(icon: Icons.article,pageLabel: 'Leave',page:role == 'staff' ? StaffGetLeaveHistoryPage(label: 'Leave Requests',) :  SubmitLeaveNote(),)
                                    ));
                      },
                      leading: Icon(
                        Icons.article,
                        color: context.watch<UiProvider>().theme == 'light'
                            ? Color(0xff633FD8)
                            : Color(0xffF87381),
                      ),
                      title: Text(
                        'Leave Request',
                        style: GoogleFonts.alice(
                            fontSize: 14,
                            color: context.watch<UiProvider>().theme == 'light'
                                ? Color(0xff303539)
                                : Color(0xffffffff)),
                      )),
                  if(role != 'staff')
                  ListTile(
                    onTap: () {
                      GetData(context: context).getPaymentInvoices();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  BottomNavigationBarPage(icon: Icons.payment,pageLabel: 'Invoices',page:GetPaymentInvoice(
                                    label: 'Fees Invoices',
                                  ))
                                  ));
                    },
                    leading: Icon(
                      Icons.payment,
                      color: context.watch<UiProvider>().theme == 'light'
                          ? Color(0xffF76D87)
                          : Color(0xff77BF22),
                    ),
                    title: Text(
                      'Fees Invoices',
                      style: GoogleFonts.alice(
                          fontSize: 14,
                          color: context.watch<UiProvider>().theme == 'light'
                              ? Color(0xff303539)
                              : Color(0xffffffff)),
                    ),
                  ),
                  if(role != 'staff')
                  ListTile(
                    onTap: () {
                      GetData(context: context).getPaymentHistory();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  BottomNavigationBarPage(icon: Icons.history,pageLabel: 'History',page:DataPage(
                                    card: context.watch<Connector>().fees,
                                    label: 'Payment History',
                                  ))
                                  ));
                    },
                    leading: Icon(
                      Icons.history,
                      color: context.watch<UiProvider>().theme == 'light'
                          ? Color(0xff0DB6D1)
                          : Color(0xff00BBD3),
                    ),
                    title: Text(
                      'Payment History',
                      style: GoogleFonts.alice(
                          fontSize: 14,
                          color: context.watch<UiProvider>().theme == 'light'
                              ? Color(0xff303539)
                              : Color(0xffffffff)),
                    ),
                  ),
                  if(role != 'staff')
                  ListTile(
                    onTap: () {
                      GetData(context: context).getTimeTable();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  BottomNavigationBarPage(icon: Icons.task_alt,pageLabel: 'Time Table',page:GetTimeTable(
                                    label: 'Time Table',
                                  ))
                                  ));
                    },
                    leading: Icon(
                      Icons.task_alt,
                      color: context.watch<UiProvider>().theme == 'light'
                          ? Color(0xff633FD8)
                          : Color(0xffF87381),
                    ),
                    title: Text(
                      'Time Table',
                      style: GoogleFonts.alice(
                          fontSize: 14,
                          color: context.watch<UiProvider>().theme == 'light'
                              ? Color(0xff303539)
                              : Color(0xffffffff)),
                    ),
                  ),
                  ListTile(
                    onTap: () async{
                      final  role =  await Storage().getData('Role');
                      GetData(context: context).getHomeWork();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BottomNavigationBarPage(

                                    icon: Icons.home_work,
                                    pageLabel: 'Homework',
                                    page: HomeWorkPage(
                                      role : role,
                                      label: 'Home Work',
                                    ),
                                  )));
                    },
                    leading: Icon(
                      Icons.home_work,
                      color: context.watch<UiProvider>().theme == 'light'
                          ? Color(0xffF76D87)
                          : Color(0xff77BF22),
                    ),
                    title: Text(
                      'Homework',
                      style: GoogleFonts.alice(
                          fontSize: 14,
                          color: context.watch<UiProvider>().theme == 'light'
                              ? Color(0xff303539)
                              : Color(0xffffffff)),
                    ),
                  ),
                  ListTile(
                    onTap: ()async {
                      final  role = await Storage().getData('Role');
                      GetData(context: context).getSubjectList();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  BottomNavigationBarPage(icon: Icons.auto_stories,pageLabel: 'Study Material',page:role == 'staff'? StudyMaterialStaff(label: 'Study Material',):GetSubjectsLists(label: 'Subject List'))
                                  ));
                    },
                    leading: Icon(
                      Icons.auto_stories,
                      color: context.watch<UiProvider>().theme == 'light'
                          ? Color(0xff0DB6D1)
                          : Color(0xff00BBD3),
                    ),
                    title: Text(
                      'Study Material',
                      style: GoogleFonts.alice(
                          fontSize: 14,
                          color: context.watch<UiProvider>().theme == 'light'
                              ? Color(0xff303539)
                              : Color(0xffffffff)),
                    ),
                  ),
                  ListTile(
                    onTap: ()async {
                      final role= await Storage().getData('Role');
                      GetData(context: context).getAttendance();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  BottomNavigationBarPage(icon: Icons.pan_tool,pageLabel: 'Attendance',page:role  == 'staff'?StaffAttendanceData(label: 'Attendance',) :AttendanceData(

                                    label: 'Attendance',
                                  ))
                                  ));
                    },
                    leading: Icon(
                      Icons.pan_tool,
                      color: context.watch<UiProvider>().theme == 'light'
                          ? Color(0xff633FD8)
                          : Color(0xffF87381),
                    ),
                    title: Text(
                      'Attendance',
                      style: GoogleFonts.alice(
                          fontSize: 14,
                          color: context.watch<UiProvider>().theme == 'light'
                              ? Color(0xff303539)
                              : Color(0xffffffff)),
                    ),
                  ),
                  if(role != 'staff')
                  ListTile(
                    onTap: () {
                      GetData(context: context).getNotice();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  BottomNavigationBarPage(icon: Icons.notifications,pageLabel: 'Notice',page:NotificationData(
                                    label: 'Notice Board',
                                  ))
                                  ));
                    },
                    leading: Icon(
                      Icons.notifications,
                      color: context.watch<UiProvider>().theme == 'light'
                          ? Color(0xffF76D87)
                          : Color(0xff77BF22),
                    ),
                    title: Text(
                      'Notice Board',
                      style: GoogleFonts.alice(
                          fontSize: 14,
                          color: context.watch<UiProvider>().theme == 'light'
                              ? Color(0xff303539)
                              : Color(0xffffffff)),
                    ),
                  ),
                  ListTile(
                    onTap: () {
                      GetData(context: context).getEvents();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  BottomNavigationBarPage(icon: Icons.event,pageLabel: 'Events',page:EventsData(
                                    label: 'Events',
                                  ))
                                  ));
                    },
                    leading: Icon(
                      Icons.event,
                      color: context.watch<UiProvider>().theme == 'light'
                          ? Color(0xff0DB6D1)
                          : Color(0xff00BBD3),
                    ),
                    title: Text(
                      'Events',
                      style: GoogleFonts.alice(
                          fontSize: 14,
                          color: context.watch<UiProvider>().theme == 'light'
                              ? Color(0xff303539)
                              : Color(0xffffffff)),
                    ),
                  ),
                  if(role != 'staff')
                  ListTile(
                    onTap: () {
                      GetData(context: context).getLibraryBooks();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  BottomNavigationBarPage(icon: Icons.library_books,pageLabel: 'Library Books',page:LibraryData(
                                    label: 'Library Books',
                                  ))
                                  ));
                    },
                    leading: Icon(
                      Icons.library_books,
                      color: context.watch<UiProvider>().theme == 'light'
                          ? Color(0xff633FD8)
                          : Color(0xffF87381),
                    ),
                    title: Text(
                      'Library Books',
                      style: GoogleFonts.alice(
                          fontSize: 14,
                          color: context.watch<UiProvider>().theme == 'light'
                              ? Color(0xff303539)
                              : Color(0xffffffff)),
                    ),
                  ),
                  ListTile(
                    onTap: () {
                      GetData(context: context).getLiveClass();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  BottomNavigationBarPage(icon: Icons.class_,pageLabel: 'Live',page:LiveClassData(
                                    label: 'Live Class',
                                  ))
                                  ));
                    },
                    leading: Icon(
                      Icons.class_,
                      color: context.watch<UiProvider>().theme == 'light'
                          ? Color(0xff633FD8)
                          : Color(0xffF87381),
                    ),
                    title: Text(
                      'Live Class',
                      style: GoogleFonts.alice(
                          fontSize: 14,
                          color: context.watch<UiProvider>().theme == 'light'
                              ? Color(0xff303539)
                              : Color(0xffffffff)),
                    ),
                  ),
                  if(role == 'staff')
                  ListTile(
                    onTap: () {
                      GetData(context: context).StaffAttendance();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  BottomNavigationBarPage(icon: Icons.timeline,pageLabel: 'Attendance',page:StaffAttendances(
                                    label: 'Staff Attendance',
                                  ))
                          ));
                    },
                    leading: Icon(
                      Icons.pan_tool,
                      color: context.watch<UiProvider>().theme == 'light'
                          ? Color(0xffF76D87)
                          : Color(0xff77BF22),
                    ),
                    title: Text(
                      'Staff Attendance',
                      style: GoogleFonts.alice(
                          fontSize: 14,
                          color: context.watch<UiProvider>().theme == 'light'
                              ? Color(0xff303539)
                              : Color(0xffffffff)),
                    ),
                  ),
                  if(role != 'staff')
                  ListTile(
                    onTap: () {
                      GetData(context: context).getExamTimeTable();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  BottomNavigationBarPage(icon: Icons.timeline,pageLabel: 'Exam Time',page:ExamTimeTableData(
                                    label: 'Exam Time Table',
                                  ))
                                  ));
                    },
                    leading: Icon(
                      Icons.timeline,
                      color: context.watch<UiProvider>().theme == 'light'
                          ? Color(0xffF76D87)
                          : Color(0xff77BF22),
                    ),
                    title: Text(
                      'Exam Time Table',
                      style: GoogleFonts.alice(
                          fontSize: 14,
                          color: context.watch<UiProvider>().theme == 'light'
                              ? Color(0xff303539)
                              : Color(0xffffffff)),
                    ),
                  ),
                  if(role != 'staff')
                  ListTile(
                    onTap: () {
                      GetData(context: context).getAdmitCard();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  BottomNavigationBarPage(icon: Icons.card_membership,pageLabel: 'Card',page:AdmitCardData(
                                    label: 'Admit Card',
                                  ))
                                  ));
                    },
                    leading: Icon(
                      Icons.card_membership,
                      color: context.watch<UiProvider>().theme == 'light'
                          ? Color(0xff0DB6D1)
                          : Color(0xff00BBD3),
                    ),
                    title: Text(
                      'Admit Card',
                      style: GoogleFonts.alice(
                          fontSize: 14,
                          color: context.watch<UiProvider>().theme == 'light'
                              ? Color(0xff303539)
                              : Color(0xffffffff)),
                    ),
                  ),
                  ListTile(
                      onTap: () {
                        GetData(context: context).getExamResults();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    BottomNavigationBarPage(icon: Icons.assessment_sharp,pageLabel: 'Results',page:ExamResultData(
                                      label: 'Exam Results',
                                    ))
                                    ));
                      },
                      leading: Icon(
                        Icons.assessment_sharp,
                        color: context.watch<UiProvider>().theme == 'light'
                            ? Color(0xff633FD8)
                            : Color(0xffF87381),
                      ),
                      title: Text(
                        'Exam Results',
                        style: GoogleFonts.alice(
                            fontSize: 14,
                            color: context.watch<UiProvider>().theme == 'light'
                                ? Color(0xff303539)
                                : Color(0xffffffff)),
                      )),
                  ListTile(
                    onTap: () async {
                      Provider.of<UiProvider>(context, listen: false).spinner();
                      final user = await Storage().logOut().whenComplete(() {
                        Provider.of<UiProvider>(context, listen: false)
                            .spinner();
                        return Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SplashScreen()));
                      });
                    },
                    leading: Icon(
                      Icons.logout_outlined,
                      color: context.watch<UiProvider>().theme == 'light'
                          ? Color(0xffF76D87)
                          : Color(0xff77BF22),
                    ),
                    title: Text(
                      'Logout',
                      style: GoogleFonts.alice(
                          fontSize: 14,
                          color: context.watch<UiProvider>().theme == 'light'
                              ? Color(0xff303539)
                              : Color(0xffffffff)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
