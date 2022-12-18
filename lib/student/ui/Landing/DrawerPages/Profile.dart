

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:provider/provider.dart';
import 'package:vshala/storage/storage.dart';
import 'package:vshala/student/connector/connector.dart';
import 'package:vshala/student/connector/getData.dart';
import 'package:vshala/student/ui/Landing/DrawerPages/components/informationTile.dart';

import 'package:vshala/student/ui/components/uiProvider.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  var role = '';
  @override
  void initState() {

      getRole().then((value){
        setState(() {
          role = value.toString();
      });
    });
    super.initState();
  }
  Future getRole()async{
    var role = await Storage().getData('Role');
    print(role);
    return role;
  }
  @override
  Widget build(BuildContext context) {



    List<Widget> staffProfile = role == 'staff'? [

      Padding(
        padding: const EdgeInsets.all(10.0),
        child: Text(
          'Details',
          style: GoogleFonts.alice(
              fontSize: 20,
              color: Colors.white,
              height: 2,
              fontWeight: FontWeight.bold
          ),
        ),
      ),
      InformationTile(
        title: 'Name',
        subtitle: context.watch<Connector>().staffInfo['name'],
      ),
      InformationTile(
        title: 'Email',
        subtitle: context.watch<Connector>().staffInfo['email'],
      ),
      InformationTile(
        title: 'DOB',
        subtitle: context.watch<Connector>().staffInfo['dob'],
      ),
      InformationTile(
        title: 'Phone No : ',
        subtitle: context.watch<Connector>().staffInfo['phone'],
      ),
      InformationTile(
          title: 'Joining Date',
          subtitle: context.watch<Connector>().staffInfo['joining_date']),
      InformationTile(
        title: 'Gender',
        subtitle: context.watch<Connector>().staffInfo['gender'],
      ),
      InformationTile(
        title: 'Address',
        subtitle: context.watch<Connector>().staffInfo['address'],
      ),
      InformationTile(
        title: 'Salary',
        subtitle: context.watch<Connector>().staffInfo['salary'],
      ),
    ] : [];
    List<Widget> details = [
      Text(
        'Details',
        style: GoogleFonts.alice(
          fontSize: 20,
          color: Colors.white,
          height: 2,
          fontWeight: FontWeight.bold
        ),
      ),
      InformationTile(
        title: 'Mobile No',
        subtitle: context.watch<Connector>().mobile_no,
      ),
      InformationTile(
        title: 'Email',
        subtitle: context.watch<Connector>().email,
      ),
      InformationTile(
        title: 'DOB',
        subtitle: context.watch<Connector>().dob,
      ),
      InformationTile(
        title: 'Blood Group',
        subtitle: context.watch<Connector>().blood_group,
      ),
      InformationTile(
          title: 'Admission Date',
          subtitle: context.watch<Connector>().admission_Data),
      InformationTile(
        title: 'Gender',
        subtitle: context.watch<Connector>().gender,
      ),
      InformationTile(
        title: 'Religion',
        subtitle: context.watch<Connector>().religion,
      ),
      InformationTile(
        title: 'Caste',
        subtitle: context.watch<Connector>().caste,
      ),
    ];

    List<Widget> id = [
      Text(
        'Identity',
        style: GoogleFonts.alice(
          fontSize: 20,
          color: Colors.white,
          height: 2,
          fontWeight: FontWeight.bold
        ),
      ),
      InformationTile(
          title: 'Name ', subtitle: context.watch<Connector>().name),
      InformationTile(
          title: 'Class', subtitle: context.watch<Connector>().class_),
      InformationTile(
          title: 'Section', subtitle: context.watch<Connector>().section),
      InformationTile(
          title: 'Roll No', subtitle: context.watch<Connector>().roll_no),
      InformationTile(
          title: 'Session', subtitle: context.watch<Connector>().session),
    ];

    List<Widget> fatherDetails = [
      Text(
        'Father',
        style: GoogleFonts.alice(
          fontSize: 20,
          color: Colors.white,
          height: 2,fontWeight: FontWeight.bold
        ),
      ),
      InformationTile(
          title: 'Father Name',
          subtitle: context.watch<Connector>().father_name),
      InformationTile(
          title: 'Father Phone',
          subtitle: context.watch<Connector>().father_phone),
      InformationTile(
          title: 'Father Occupation',
          subtitle: context.watch<Connector>().father_occupation),
    ];

    ///this is for mother's details
    List<Widget> motherDetails = [
      Text(
        'Mother',
        style: GoogleFonts.alice(
          fontSize: 20,
          color: Colors.white,
          height: 2,fontWeight: FontWeight.bold
        ),
      ),
      InformationTile(
          title: 'Mother Name',
          subtitle: context.watch<Connector>().mother_name),
      InformationTile(
          title: 'Mother Phone',
          subtitle: context.watch<Connector>().mother_phone),
      InformationTile(
          title: 'Mother Occupation',
          subtitle: context.watch<Connector>().mother_occupation),
    ];
    String url = context.watch<Connector>().photo != ''
        ? context.watch<Connector>().photo
        : context.watch<Connector>().logo;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: context.watch<UiProvider>().theme == 'light'
            ? Color.fromRGBO(135, 112, 255, 0.9)
            : Color(0xff2A2B30),
        appBar: AppBar(
          backgroundColor: context.watch<UiProvider>().theme == 'light'
              ? Color.fromRGBO(135, 112, 255, 0.9)
              : Color(0xff2A2B30),
          title: Text(
            'Profile',
            style: GoogleFonts.alice(
              color: Colors.white,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  backgroundColor: context.watch<UiProvider>().theme == 'light'
                      ? Color.fromRGBO(135, 112, 255, 0.9)
                      : Color(0xff2A2B30),
                  radius: 50,
                  child: context.watch<Connector>().logo == ''
                      ? Icon(Icons.person)
                      : Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: NetworkImage(
                                    url),
                                fit: BoxFit.contain),
                          ),
                        ),
                ),
              ),
              Center(
                child: Text(
                  context.watch<Connector>().nameOfStudent,
                  style: GoogleFonts.alice(fontSize: 15, color: Colors.white),
                ),
              ),
              Center(
                child: Text(
                  context.watch<Connector>().level,
                  style: GoogleFonts.alice(
                      fontSize: 12, color: Colors.white, height: 2),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              role != 'staff' ?   TabBar(
                indicatorColor: context.watch<UiProvider>().theme == 'light'
                    ? Color.fromRGBO(135, 112, 255, 0.9)
                    : Color(0xff2A2B30),
                tabs: [
                  Tab(
                    text: 'Student',
                  ),
                  Tab(
                    text: 'Parents',
                  ),
                ],
              ):Container(),
              Expanded(
                child: Container(
                  child: role == 'staff' ? ListView.builder(
                    itemCount: staffProfile.length,
                      itemBuilder:(context,i){
                    return staffProfile[i];
                  }) : TabBarView(
                    children: [
                      RefreshIndicator(

                        onRefresh: ()async{
                          try{
                            await GetData(context: context).getProfile();
                          }catch (e) {
                            print(e);

                          }
                        },
                        child: ListView(
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          children: [
                            Column(children: id),
                            Column(children: details),
                          ],
                        ),
                      ),
                      RefreshIndicator(
                        onRefresh: ()async{
                          try{
                            await GetData(context: context).getProfile();
                          }catch (e) {
                            print(e);

                          }
                        },
                        child: ListView(
                          children: [
                            Column(children: fatherDetails),
                            Column(children: motherDetails),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
