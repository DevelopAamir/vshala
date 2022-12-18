import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:vshala/constants/theme.dart';
import 'package:vshala/storage/storage.dart';
import 'package:vshala/student/connector/connector.dart';
import 'package:vshala/student/connector/getData.dart';
import 'package:vshala/student/ui/Landing/DrawerPages/Profile.dart';
import 'package:vshala/student/ui/Landing/components/cards.dart';
import 'package:vshala/student/ui/Landing/components/drawers.dart';
import 'package:vshala/student/ui/components/DataPage.dart';
import 'package:vshala/student/ui/components/uiProvider.dart';
import 'package:vshala/student/ui/components/webView.dart';

class BottomNavigationBarPage extends StatefulWidget {
  final Widget page;
  final IconData? icon;
  final String pageLabel;
  const BottomNavigationBarPage({
    Key? key,
    required this.page,
    required this.icon,
    required this.pageLabel,
  }) : super(key: key);

  @override
  _BottomNavigationBarPageState createState() =>
      _BottomNavigationBarPageState();
}

class _BottomNavigationBarPageState extends State<BottomNavigationBarPage> {
  var _selectedIndex = 0;
  var role;
  @override
  void initState() {
    // setState(() {
    //   role = getRole();
    // });
  //print(role.toString());
    getRole();
    super.initState();
  }
  getRole()async{
    var _role = await Storage().getData('Role');
    setState(() {
      role = _role;
    });
    print(role.toString());
    return _role;
  }
  @override
  Widget build(BuildContext context) {
    List<Widget> widgetOptions = <Widget>[
      widget.page,
      LandingPage(),
      if(role != 'staff')
      NotificationData(
        label: 'Notice Board',
      ),
      LiveClassData(
        label: 'Live Class',
      ),
      Scaffold(
        backgroundColor: context.watch<UiProvider>().theme == 'light'
            ? Color.fromRGBO(135, 112, 255, 0.9)
            : Color(0xff2A2B30),
        appBar: AppBar(title: Text('About Us',style: GoogleFonts.alice(),),
          backgroundColor: context.watch<UiProvider>().theme == 'light'
              ? Color.fromRGBO(135, 112, 255, 0.9)
              : Color(0xff2A2B30),
        ),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: CircleAvatar(
                  radius: 70,
                  child: Image.network(context.watch<Connector>().logo,),
                  backgroundColor: Color.fromRGBO(135, 112, 255, 0.6)
                ),
              ),



              Card(child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(flex:1,child: Text('Name :  ',style: themeLabel,)),
                    Expanded(flex:3,child: Text(context.watch<Connector>().schoolName,style: themeSubLabel)),
                  ],
                ),
              )),

              Card(child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(flex:1,child: Text('Address :  ',style: themeLabel,)),
                    Expanded(flex:3,child: Text(context.watch<Connector>().address,style: themeSubLabel)),
                  ],
                ),
              )),
              Card(child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(flex:1,child: Text('Phone Number :  ',style: themeLabel,)),
                    Expanded(flex:3,child: Text(context.watch<Connector>().schoolNumber,style: themeSubLabel)),
                  ],
                ),
              )),

            ],
          ),
        ),
      )
    ];
    return Scaffold(
      body: widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: context.watch<UiProvider>().theme == 'light'
            ? Color.fromRGBO(135, 112, 255, 0.9)
            : Color(0xff2A2B30),
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(widget.icon),
            label: widget.pageLabel,
            backgroundColor: context.watch<UiProvider>().theme == 'light'
                ? Color.fromRGBO(135, 112, 255, 0.9)
                : Color(0xff2A2B30),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: context.watch<UiProvider>().theme == 'light'
                ? Color.fromRGBO(135, 112, 255, 0.9)
                : Color(0xff2A2B30),
          ),
          if(role != 'staff')
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notice',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.class_),
            label: 'Live Class',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.contact_support),
            label: 'Contact Us',
          ),
        ],
        onTap: (int index) {
          index == 1
              ? Navigator.pop(context)
              : setState(() {
                  _selectedIndex = index;
                });
        },
        currentIndex: _selectedIndex,
        selectedItemColor: context.watch<UiProvider>().theme == 'light'
            ? Color(0xffFFA766)
            : Color(0xff77BF22),
        selectedLabelStyle: GoogleFonts.alice(),
        unselectedLabelStyle: GoogleFonts.alice(color: Colors.white),
        unselectedItemColor: Colors.white,
        selectedIconTheme: IconThemeData(size: 30),
        showUnselectedLabels: true,
      ),
    );
  }
}

class LandingPage extends StatefulWidget {
  LandingPage({Key? key}) : super(key: key);

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {

  var role;



  getRole()async{
    var type = await Storage().getData('Role');
    setState(() {
      role = type;
    });

  }
  @override
  void initState() {
    getRole();
    GetData(context: context).getProfile();


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
            title: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Text(context.watch<Connector>().schoolName,
                    style: TextStyle())),
            actions: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: CircleAvatar(
                  backgroundColor: context.watch<UiProvider>().theme == 'light'
                      ? Colors.white
                      : Color(0xff0F1414),
                  backgroundImage:
                      NetworkImage(context.watch<Connector>().logo),
                ),
              ),
            ],
          ),
          drawer: Drawers(),
          body: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(flex: 1, child: Container()),
                  Expanded(
                    flex: 1,
                    child: Container(
                      decoration: BoxDecoration(
                          color: context.watch<UiProvider>().theme == 'light'
                              ? Color(0xffF5F7FA)
                              : Color(0xff394048),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black26,
                                offset: Offset(-4, 4),
                                blurRadius: 7,
                                spreadRadius: 0)
                          ],
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(15),
                              topRight: Radius.circular(15))),
                    ),
                  )
                ],
              ),
              Column(
                children: [
                  Expanded(
                    flex: 3,
                    child: Container(
                        padding: EdgeInsets.only(top: 10),
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height * 0.35,
                        child: CarouselSlider.builder(
                          itemCount: context.watch<UiProvider>().url.length,
                          options: CarouselOptions(
                              height: MediaQuery.of(context).size.height * 0.35,
                              autoPlay: true,
                              autoPlayInterval: Duration(seconds: 3),
                              enlargeCenterPage: true),
                          itemBuilder: (context, index, realIndex) {
                            // final image = url[index];
                            return Padding(
                              padding: const EdgeInsets.all(0.0),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return WebViewPage(
                                      title: context.watch<UiProvider>().url[index]['slug'],
                                      url: context.watch<UiProvider>().url[index]['link'],
                                    );
                                  }));
                                },
                                child: Container(
                                  padding: EdgeInsets.all(15),
                                  width: double.infinity,
                                  child: Stack(
                                    children: [
                                      Center(
                                          child: Container(
                                              child: context.watch<UiProvider>().url[index]
                                                          ['featured_media'] !=
                                                      0
                                                  ? Image.network(
                                                context.watch<UiProvider>().url[index]['_embedded'][
                                                              'wp:featuredmedia']
                                                          [0]['source_url'],
                                                      fit: BoxFit.contain,
                                                    )
                                                  : Container())),
                                      Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              context.watch<UiProvider>().url[index]['slug'],
                                              style: themeLabel.copyWith(
                                                  fontSize: 20),
                                            ),
                                            Text(
                                                context.watch<UiProvider>().url[index]['title']['rendered'],
                                                style: themeSubLabel),
                                            Spacer(),
                                            Text(
                                                context.watch<UiProvider>().url[index]['date']
                                                    .toString()
                                                    .replaceAll('T', "  "),
                                                style: themeSubLabel),
                                          ]),
                                    ],
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            );
                          },
                        )),
                  ),
                  Expanded(
                    flex: 7,
                    child: Container(
                      padding: EdgeInsets.only(left: 10, right: 10, top: 5),
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.55,
                      child: Column(
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                Expanded(
                                  child: Cards(
                                    icon: Icons.person,
                                    text: 'Profile',
                                    color: context.watch<UiProvider>().theme ==
                                            'light'
                                        ? Color(0xffffffff)
                                        : Color(0xff303539),
                                    bgColor:
                                        context.watch<UiProvider>().theme ==
                                                'light'
                                            ? Color.fromRGBO(229, 250, 253, 0.8)
                                            : Color.fromRGBO(38, 76, 91, 0.8),
                                    iconColor:
                                        context.watch<UiProvider>().theme ==
                                                'light'
                                            ? Color(0xff0DB6D1)
                                            : Color(0xff00BBD3),
                                    ontap: () async {
                                      Provider.of<UiProvider>(context,
                                              listen: false)
                                          .spinner();
                                      await GetData(context: context)
                                          .getProfile();
                                      Provider.of<UiProvider>(context,
                                              listen: false)
                                          .spinner();
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  BottomNavigationBarPage(
                                                      icon: Icons.person,
                                                      pageLabel: 'Profile',
                                                      page: Profile())));
                                    },
                                  ),
                                ),
                                Expanded(
                                  child: Cards(
                                    color: context.watch<UiProvider>().theme ==
                                            'light'
                                        ? Color(0xffffffff)
                                        : Color(0xff303539),
                                    icon: Icons.home_work,
                                    text: 'Homework',
                                    bgColor:
                                        context.watch<UiProvider>().theme ==
                                                'light'
                                            ? Color.fromRGBO(243, 230, 249, 0.8)
                                            : Color.fromRGBO(64, 63, 60, 0.8),
                                    iconColor:
                                        context.watch<UiProvider>().theme ==
                                                'light'
                                            ? Color(0xff633FD8)
                                            : Color(0xffF87381),
                                    ontap: () async{
                                      final  role =  await Storage().getData('Role');
                                      GetData(context: context).getHomeWork();
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  BottomNavigationBarPage(
                                                      icon: Icons.home_work,
                                                      pageLabel: 'Home Works',
                                                      page: HomeWorkPage(
                                                        label: 'Home Works', role: role,
                                                      ))));
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Row(
                              children: [
                                Expanded(
                                  child: Cards(
                                    color: context.watch<UiProvider>().theme ==
                                            'light'
                                        ? Color(0xffffffff)
                                        : Color(0xff303539),
                                    icon: Icons.auto_stories,
                                    text: 'Study Material',
                                    bgColor:
                                        context.watch<UiProvider>().theme ==
                                                'light'
                                            ? Color.fromRGBO(254, 233, 238, 0.8)
                                            : Color.fromRGBO(57, 67, 52, 0.8),
                                    iconColor:
                                        context.watch<UiProvider>().theme ==
                                                'light'
                                            ? Color(0xffF76D87)
                                            : Color(0xff77BF22),
                                    ontap: () async{
                                      final  role = await Storage().getData('Role');
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  BottomNavigationBarPage(
                                                      icon: Icons.auto_stories,
                                                      pageLabel:
                                                          'StudyMaterial',
                                                      page:role == 'staff'? StudyMaterialStaff(label: 'Study Material',): GetSubjectsLists(
                                                          label:
                                                              'Subject List'))));
                                    },
                                  ),
                                ),
                                Expanded(
                                  child: Cards(
                                    color: context.watch<UiProvider>().theme ==
                                            'light'
                                        ? Color(0xffffffff)
                                        : Color(0xff303539),
                                    icon: Icons.pan_tool,
                                    text: 'Attendance',
                                    bgColor:
                                        context.watch<UiProvider>().theme ==
                                                'light'
                                            ? Color.fromRGBO(238, 253, 255, 0.8)
                                            : Color.fromRGBO(51, 58, 64, 0.8),
                                    iconColor:
                                        context.watch<UiProvider>().theme ==
                                                'light'
                                            ? Color(0xff4BBAFE)
                                            : Color(0xff44C2F8),
                                    ontap: () async {
                                      final role= await Storage().getData('Role');
                                      GetData(context: context).getAttendance();
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  BottomNavigationBarPage(
                                                      icon: Icons.pan_tool,
                                                      pageLabel: 'Attendance',
                                                      page:role  == 'staff'?StaffAttendanceData(label: 'Attendance',) : AttendanceData(
                                                        label: 'Attendance',
                                                      ))));
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),

                          Expanded(
                            child: Row(
                              children: [
                                if(role != 'staff')
                                Expanded(
                                  child: Cards(
                                    color: context.watch<UiProvider>().theme ==
                                            'light'
                                        ? Color(0xffffffff)
                                        : Color(0xff303539),
                                    icon: Icons.notifications,
                                    text: 'Notice Board',
                                    bgColor:
                                        context.watch<UiProvider>().theme ==
                                                'light'
                                            ? Color.fromRGBO(242, 246, 252, 0.8)
                                            : Color.fromRGBO(56, 66, 74, 0.8),
                                    iconColor:
                                        context.watch<UiProvider>().theme ==
                                                'light'
                                            ? Color(0xffB26FE3)
                                            : Color(0xff586594),
                                    ontap: () {
                                      GetData(context: context).getNotice();
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  BottomNavigationBarPage(
                                                      icon: Icons.notifications,
                                                      pageLabel: 'Notice',
                                                      page: NotificationData(
                                                          label:
                                                              'Notice Board'))));
                                    },
                                  ),
                                ),
                                Expanded(
                                  child: Cards(
                                    color: context.watch<UiProvider>().theme ==
                                            'light'
                                        ? Color(0xffffffff)
                                        : Color(0xff303539),
                                    icon: Icons.class_,
                                    text: 'Live Class',
                                    bgColor:
                                        context.watch<UiProvider>().theme ==
                                                'light'
                                            ? Color.fromRGBO(247, 245, 241, 0.8)
                                            : Color.fromRGBO(73, 68, 62, 0.8),
                                    iconColor:
                                        context.watch<UiProvider>().theme ==
                                                'light'
                                            ? Color(0xffFFA766)
                                            : Color(0xffF3A168),
                                    ontap: () {
                                      GetData(context: context).getLiveClass();
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  BottomNavigationBarPage(
                                                      icon: Icons.class_,
                                                      pageLabel: 'Live',
                                                      page: LiveClassData(
                                                        label: 'Live Class',
                                                      ))));
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ],
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
    );
  }
}
