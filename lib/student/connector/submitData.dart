import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:vshala/constants/api.dart';
import 'package:http/http.dart' as http;
import 'package:vshala/storage/storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:vshala/student/connector/connector.dart';

class SubmitData {
  Future<void> submitLeaveRequest(
      isSingleDay, start_date, endDate, reason) async {
    final url = Api.domain + Api.submitLeaveRequestUrl;
    final accessToken = await Storage().getData('access_Token');
    try {
      var response = await http
          .post(Uri.parse(url),
              headers: {
                "Accept": Api.contentType,
                "Authorization": "Bearer " + accessToken.toString()
              },
              body: isSingleDay == true
                  ? {
                      //
                      //  'title' : 'test',
                      //  'description':'not to do',
                      //  'attachments':'',
                      //  'homework_date':'2020-08-06',
                      // ' added_by':'962',
                      //  'session_id':'1',
                      //  'school_id':'1',
                      //  'created_at':'',
                      //  'updated_at':'',
                      //  'subject':'',
                      //  'class':'1',
                      //  'section':'A',
                      //study material add
                      // 'class': '10th',
                      // 'section': 'A',
                      // 'subject': 'English',
                      // 'chapter': '1',
                      // 'material_type': 'Video',
                      // 'title': 'testing1', 'url': 'test',
                      // 'updated_at': '',
                      // 'description': 'apple',
                      ///leave request
                      'start_date': start_date,
                      'end_date': endDate,
                      'reason': reason,
                    }
                  : {
                      'start_date': start_date,
                      'end_date': endDate,
                      'reason': reason,
                      'multiple_days': 'true'
                    })
          .then((value) {
        var data = jsonDecode(value.body);
        Fluttertoast.showToast(msg: '${data['message'].toString()}');
        print(data);
      });
    } catch (e) {
      print(e);
    }
  }

  Future<dynamic> uploadMedia(String filePath) async {
    var downloadUrl;
    var contentType;
    if (filePath != null) {}
    if (filePath.contains('jpg')) {
      contentType = "image/jpg";
    } else if (filePath.contains('jpeg')) {
      contentType = "image/jpg";
    } else{
      contentType ='multipart/form-data';
    }

    final url = Api.domain + 'wp/v2/media';
    final fileName = filePath.split('/').last;
    final accessToken = await Storage().getData('access_Token');

    Map<String, String> requestHeaders = {
      "Authorization": "Bearer " + accessToken.toString(),
      "Content-Type": contentType,
      "Content-Disposition": "attachment; filename=$fileName"
    };
    var imageBytes = File(filePath).readAsBytesSync();

    try {
      var req = await http
          .post(Uri.parse(url), body: imageBytes, headers: requestHeaders)
          .then((value) {
        var data = jsonDecode(value.body);
        print(data);
        downloadUrl = data['id'];
        Fluttertoast.showToast(msg: 'File Uploaded Successfully');
      });
    } catch (e) {
      print(e);
      Fluttertoast.showToast(msg: e.toString());
    }

    return downloadUrl;
  }

  Future<void> uploadHomeWork(
      class_, section, subject, date, title, description, file) async {
    Map sections = {};
    for (var i = 0; i < section.length; i++) {
      sections.addAll({i.toString(): section[i]});
    }
    if (class_ != null &&
        section != null &&
        date != null &&
        subject != null &&
        title != null) {
      if (file != null) {
        final fileID = await uploadMedia(file.path);
        final url = Api.domain + Api.uploadStaffHomework;
        final accessToken = await Storage().getData('access_Token');
        try {
          var response = await http.post(Uri.parse(url), headers: {
            "Accept": Api.contentType,
            //"Content-Type": Api.contentType,
            "Authorization": "Bearer " + accessToken.toString()
          }, body: {
            'title': title,

            ///title
            'description': description,

            ///description
            'attachments': 'a:1:{i:0;i:${fileID.toString()};}',

            ///file
            'homework_date': date,

            ///date
            'subject': subject,

            ///code
            'class': class_,

            ///class id
            'section': section[0]

            ///label
          }).then((value) async {
            var data = jsonDecode(value.body);
            Fluttertoast.showToast(msg: '${data['message'].toString()}');
            if (section.length > 1) {
              Fluttertoast.showToast(msg: 'Uploading for all sections');
              final uri = Api.domain + Api.multiSectionHomeWorkUpload;
              for (var i = 1; i < section.length; i++) {
                var res = await http.post(Uri.parse(uri), headers: {
                  "Accept": Api.contentType,
                  //"Content-Type": Api.contentType,
                  "Authorization": "Bearer " + accessToken.toString()
                }, body: {
                  'homework_id': data['homework_id'].toString(),
                  'class': class_,
                  'section': section[i]
                }).then((value) {
                  var a = jsonDecode(value.body);
                  print(a.toString());
                });
              }
            }
            print(data);
          });
        } catch (e) {
          print(e);
        }
      } else {
        Fluttertoast.showToast(msg: 'Please specify the file');
      }
    } else {
      Fluttertoast.showToast(msg: 'Please Fill All Fields');
    }
  }

  Future<void> uploadStudyMaterial(
      {class_,
      section,
      subject,
      title,
      description,
      file,
      chapter,
      material_type,uri}) async {
    // Set<Set<String>> sections = {{''}};
    // for(var i = 0; i<section.length; i++){
    //   sections.addAll({section[i]});
    //   print({sections.toString()});
    // }
    if (class_ != null && section != null && subject != null && title != null) {
      if (file != null || uri != '' ) {
        final fileID = file == null ? '' :await uploadMedia(file.path);
        final url = Api.domain + Api.uploadStaffStudyMaterialUrl;
        final accessToken = await Storage().getData('access_Token');
        try {
          var response = await http.post(Uri.parse(url), headers: {
            "Accept": Api.contentType,
            //"Content-Type": Api.contentType,
            "Authorization": "Bearer " + accessToken.toString()
          }, body: {
            'title': title,
            'chapter': chapter,
            'description': description,
            'material_type': material_type,
            'attachments':file == null? '': 'a:1:{i:0;i:${fileID.toString()};}',
            'subject': subject,
            'class': class_,
            'url' : uri,
            'section': section[0]
          }).then((value) async {
            var data = jsonDecode(value.body);
            Fluttertoast.showToast(msg: '${data['message'].toString()}');
            if (section.length > 1) {
              Fluttertoast.showToast(msg: 'Uploading for all sections');
              final uri = Api.domain + Api.multiSectionStudyMaterialUpload;
              for (var i = 1; i < section.length; i++) {
                var res = await http.post(Uri.parse(uri), headers: {
                  "Accept": Api.contentType,
                  //"Content-Type": Api.contentType,
                  "Authorization": "Bearer " + accessToken.toString()
                }, body: {
                  'study_material_id':
                      data['response']['study_material_id'].toString(),
                  'class_school_id':
                      data['response']['class_school_id'].toString(),
                  'section': section[i],
                  'study_material_subject_id':
                      data['response']['study_material_subject_id'].toString()
                }).then((value) {
                  var a = jsonDecode(value.body);
                  print(a.toString());
                });
              }
            }
            print(data);
          });
        } catch (e) {
          print(e);
        }
      } else {
        Fluttertoast.showToast(msg: 'Please specify the file');
      }
    } else {
      Fluttertoast.showToast(msg: 'Please Fill All Fields');
    }
  }
  Future submitAttendance(List data,BuildContext context)async{
    final api =Api.domain +  Api.submitAttendance;
    final accessToken = await Storage().getData('access_Token');
    var datas;
    int uploaded = 0;
    try{
      for(var d in data){

        await http.post(Uri.parse(api),

            headers: {
              "Accept": Api.contentType,
              //"Content-Type": Api.contentType,
              "Authorization": "Bearer " + accessToken.toString()
            },
            body: {
          'student_id' : d['id'],
          'status' : d['status'],
        }).then((value) {
         var res =  jsonDecode(value.body);
         datas = res['message'];
         Provider.of<Connector>(context, listen: false)
             .complete(uploaded.toString() + '/${data.length.toString()}');
        // Fluttertoast.showToast(msg: uploaded.toString() + '/'+data.length.toString()+ 'Uploaded',);
         uploaded++;
        });
      }
      Provider.of<Connector>(context, listen: false)
          .complete('0');
    }catch (e){
      print(e);

    }
    return uploaded == data.length ? datas : 'Uploaded' +  uploaded.toString() +'/'+data.length.toString();
  }
  Future approveLeave(id)async{
    final api =Api.domain +  Api.staffApproveLeave;
    final accessToken = await Storage().getData('access_Token');
    var datas;
    try{

        await http.post(Uri.parse(api),

            headers: {
              "Accept": Api.contentType,
              //"Content-Type": Api.contentType,
              "Authorization": "Bearer " + accessToken.toString()
            },
            body: {
              'id' : id,

            }).then((value) {
          var res =  jsonDecode(value.body);
          datas = res['message'];
        });


    }catch (e){
      print(e);

    }
    return datas;
  }
  Future attendanceUpdate(id)async{
    final api =Api.domain +  Api.staffUpdateAttendance;
    final accessToken = await Storage().getData('access_Token');
    var datas;
    try{

      await http.post(Uri.parse(api),

          headers: {
            "Accept": Api.contentType,
            //"Content-Type": Api.contentType,
            "Authorization": "Bearer " + accessToken.toString()
          },
          body: {
            'id' : id,

          }).then((value) {
        var res =  jsonDecode(value.body);
        datas = res['message'];
        print(res.toString());
      });


    }catch (e){
      print(e);

    }
    return datas;
  }

}
