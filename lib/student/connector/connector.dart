import 'package:flutter/material.dart';

import 'package:vshala/student/ui/Landing/DrawerPages/components/cards/fees.dart';

import 'package:vshala/student/ui/Landing/DrawerPages/components/cards/homeworkCard.dart';

import 'package:vshala/student/ui/Landing/DrawerPages/components/cards/onlineExamCard.dart';


class Connector with ChangeNotifier {
  String joined = 'false';
  var staffInfo;
  String completed = '0';

  complete(v){
    completed = v;
    notifyListeners();
  }

  getStaffProfile(data){
    staffInfo = data;
    notifyListeners();
  }

  join(value){
    joined = value;
    notifyListeners();
  }



  String quizId ='';
  getQuizId(id){
    quizId = id;
    notifyListeners();
  }
  ///home details students
  List<HomeWork> homeWorks = [];

  getHomeWorks(homework){
    homeWorks.add(homework);
    notifyListeners();
  }




  String nameOfStudent = 'name';
  String level = 'level';
  String schoolName = '';
  String schoolNumber = '';
  String address = '';
  String logo = '';

  ///students profile[

  String name = 'v';
  String photo = '';
  String session = '';
  String class_ = '';
  String section = '';
  String roll_no = '';
  String mobile_no = '';
  String email = '';
  String dob = '';
  String blood_group = '';
  String admission_Data = '';
  String gender = '';
  String religion = '';
  String caste = '';

  ///  ] this is of student section
  ///this is father information [

  String father_name = '';
  String father_phone = '';
  String father_occupation = '';
  String mother_name = '';
  String mother_phone = '';
  String mother_occupation = '';

  headingInfo(value, email) {
    nameOfStudent = value;
    level = email;

    notifyListeners();
  }

  schoolInfo(school, number, address_, image) {
    schoolName = school;
    schoolNumber = number;
    address = address_;
    logo = image;
    notifyListeners();
  }

  idInfo(
    name_,
    photo_,
    session_,
    class__,
    section_,
    roll_no_,


    mobile_no_,
    email_,
    dob_,
    blood_group_,
    admission_Data_,
    gender_,
    religion_,
    caste_,
    father_name_,
    father_phone_,
    father_occupation_,
    mother_name_,
    mother_phone_,
    mother_occupation_,
  ) {
    name = name_;
    photo = photo_;
    session = session_;
    class_ = class__;
    section = section_;
    roll_no = roll_no_;


    mobile_no = mobile_no_;
    email = email_;
    dob = dob_;
    blood_group = blood_group_;
    admission_Data = admission_Data_;
    gender = gender_;
    religion = religion_;
    caste = caste_;
    father_name = father_name_;
    father_phone = father_phone_;
    father_occupation = father_occupation_;
    mother_name = mother_name_;
    mother_phone = mother_phone_;
    mother_occupation = mother_occupation_;
    notifyListeners();
  }


  /// this is for online exam
  List<OnlineExamCards> onlineExams = [
    OnlineExamCards(
      sub: 'math',
      onTap: () {},
      time: '10:30',
    )
  ];

  /// this is for online exam



  List<FeesCard> fees = [FeesCard(), FeesCard()];









}
