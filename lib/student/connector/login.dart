import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:vshala/constants/api.dart';
import 'package:vshala/main.dart';
import 'package:vshala/storage/storage.dart';
import 'package:vshala/student/connector/connector.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:vshala/student/connector/getData.dart';
import 'package:vshala/student/ui/Landing/landing.dart';

class LoginConnector {
  final username;
  final password;
  final context;
  LoginConnector(
      {required this.context, required this.username, required this.password});

  Future login() async {
    var url = '${Api.domain}${Api.loginUrl}';

    try {
      var response = await http.post(
        Uri.parse(url),
        body: {
          "username": username,
          "password": password,
        },
      );
      if (response.statusCode == 200) {
        print('done');
        Storage store = Storage();
        Map data = jsonDecode(response.body);
        store.storeData('access_Token', data['token']);
        store.storeData('username', username);
        store.storeData('password', password);
        store.storeData('Role', data['user_type']);
        var type = data['user_type'];
        if(type == 'staff'){
          await GetData(context: context).getStaffSchoolData().then((value){
            data['school'] = value['message'];
          });
        }

        print(data);
        Provider.of<Connector>(context, listen: false).headingInfo(
          data['user_display_name'],
          data['user_email'],
        );


        Provider.of<Connector>(context, listen: false).schoolInfo(
           //type != 'staff' ?
           data['school']['name'] ,
              // : data['school']['name'],
           // type != 'staff' ?
            data['school']['phone'] ,
              //  : data['user_email'],
            //type != 'staff' ?
            data['school']['address'] ,
               // : '',
            //type != 'staff' ?
            data['school']['logo'],
               // :  ''
        ); //'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRaWkDTs7fln9RJo_-Azkz3BkkDM6cKv7nRag&usqp=CAU',);//data['school']['logo']);
        // print(data['school']['logo']);
        // print(data['user_display_name']);


      } else {
        print(response.statusCode);
        print(response.body);
      }
    } catch (e) {
      print(e);
    }
  }

}
