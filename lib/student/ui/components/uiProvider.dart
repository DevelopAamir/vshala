import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vshala/student/connector/getData.dart';

class UiProvider with ChangeNotifier {
  List url = [

  ];
  posts(context) async {
    var file = await GetData(context: context).getPosts();
    url.addAll(file);
    notifyListeners();
  }
  String reason = '';
  bool spin = false;
  String theme = 'light';
  String focusDay1 = DateFormat('dd-MM-yyyy')
      .format(DateTime.now())
      .toString();
  String focusDay2 = DateFormat('dd-MM-yyyy')
      .format(DateTime.now())
      .toString();   ///// This is focused Date from calender for single Days

  void changeTheme() {
    theme == 'light' ? theme = 'Dark' : theme = 'light';
    notifyListeners();
  }

  void changeReason(a){
    reason =a;
    notifyListeners();
  }


  void changeStartDate(String focusedDay1) {
    focusDay1 = focusedDay1;


    notifyListeners();
  }
  void changeEndDate(String focusedDay2) {

    focusDay2 = focusedDay2;

    notifyListeners();
  }
  void spinner(){
    if(spin == false){
      spin = true;
      notifyListeners();
    }else{
      spin =false;
      notifyListeners();
    }
  }
}
