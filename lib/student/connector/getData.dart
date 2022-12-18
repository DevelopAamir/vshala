import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:vshala/constants/api.dart';
import 'package:vshala/constants/theme.dart';
import 'package:vshala/objects/AttendaceObject.dart';
import 'package:vshala/objects/Events.dart';
import 'package:vshala/objects/HomeWorkAttachements.dart';
import 'package:vshala/objects/Quiz.dart';
import 'package:vshala/objects/home_Work.dart';
import 'package:vshala/objects/leaveHistory.dart';
import 'package:vshala/objects/libraryBooks.dart';
import 'package:vshala/objects/notice.dart';
import 'package:vshala/objects/online_axam.dart';
import 'package:vshala/objects/paymentInvoices.dart';
import 'package:vshala/objects/readingAttachments.dart';
import 'package:vshala/objects/readingMaterial.dart';
import 'package:vshala/objects/subjects.dart';
import 'package:vshala/objects/timetable.dart';
import 'package:vshala/storage/storage.dart';
import 'package:vshala/student/connector/connector.dart';
import 'package:vshala/student/ui/Landing/DrawerPages/components/cards/ExamResultCard.dart';
import 'package:vshala/student/ui/Landing/DrawerPages/components/cards/ExamTimeTableCard.dart';
import 'package:vshala/student/ui/Landing/DrawerPages/components/cards/SelectExamCard.dart';
import 'package:vshala/student/ui/Landing/DrawerPages/components/cards/leavehistory.dart';
import 'package:vshala/student/ui/Landing/DrawerPages/components/cards/liveClass.dart';
import 'package:vshala/student/ui/Landing/DrawerPages/components/cards/resultCard.dart';
import 'package:vshala/student/ui/components/DataPage.dart';
import 'package:wordpress_api/wordpress_api.dart';

class GetData {
  final context;
  GetData({required this.context});

  getProfile() async {
    final role = await Storage().getData('Role');
    final url = role == 'staff'
        ? Api.domain + Api.getStaffProfileUrl
        : Api.domain + Api.getStudentProfileUrl;
    final accessToken = await Storage().getData('access_Token');
    try {
      var response = await http.get(
          Uri.parse(
            url,
          ),
          headers: {
            "Accept": Api.contentType,
            "Content-Type": Api.contentType,
            "Authorization": "Bearer " + accessToken.toString()
          }).then((value) async {
        var data = await jsonDecode(value.body);
        print(data.toString());

        if (data['success'] == true) {
          //print(data['data']['student']['email']);
          if (role == 'staff') {
            Provider.of<Connector>(context, listen: false)
                .getStaffProfile(data['data']);
            Provider.of<Connector>(context, listen: false).headingInfo(
              data['data']['name'],
              data['data']['email'],
            );

          } else {
            Provider.of<Connector>(context, listen: false).idInfo(
                data['data']['student']['name'],
                data['data']['student']['photo'],
                data['data']['student']['session'],
                data['data']['student']['class'],
                data['data']['student']['section'],
                data['data']['student']['roll_number'],
                data['data']['student']['mobileno'],
                data['data']['student']['email'],
                data['data']['student']['dob'],
                data['data']['student']['blood_group'],
                data['data']['student']['admission_date'],
                data['data']['student']['gender'],
                data['data']['student']['religion'],
                data['data']['student']['caste'],
                data['data']['student']['father_name'],
                data['data']['student']['father_phone'],
                data['data']['student']['father_occupation'],
                data['data']['student']['mother_name'],
                data['data']['student']['mother_phone'],
                data['data']['student']['mother_occupation']);
          }
        }
      });
    } catch (e) {
      print(e);
    }
  }
  Future staffGetSubmission(id) async {
    final uri = Api.domain + Api.staffHomeWorkSubmission + '/$id';
    final accessToken = await Storage().getData('access_Token');
    var datas;
    try {
      var response = await http.get(
          Uri.parse(
            uri,
          ),
          headers: {
            "Accept": Api.contentType,
            "Content-Type": Api.contentType,
            "Authorization": "Bearer " + accessToken.toString()
          }).then((value) async {
        var data = await jsonDecode(value.body);
        print(data);
        datas = data['data'];
      });
    } catch (e) {
      print(e);
    }
    return datas;
  }

  Future<String> joinEvent(id) async {
    final uri = Api.domain + Api.getEventUrl + '/$id' + '/join';
    final accessToken = await Storage().getData('access_Token');
    var joined = '';
    try {
      var response = await http.post(
          Uri.parse(
            uri,
          ),
          headers: {
            "Accept": Api.contentType,
            "Content-Type": Api.contentType,
            "Authorization": "Bearer " + accessToken.toString()
          }).then((value) async {
        var data = await jsonDecode(value.body);
        joined = data['message'];
      });
    } catch (e) {
      print(e);
    }
    return joined;
  }

  Future<String> unJoinEvent(id) async {
    final uri = Api.domain + Api.getEventUrl + '/$id' + '/unjoin';
    final accessToken = await Storage().getData('access_Token');
    var joined = '';
    try {
      var response = await http.post(
          Uri.parse(
            uri,
          ),
          headers: {
            "Accept": Api.contentType,
            "Content-Type": Api.contentType,
            "Authorization": "Bearer " + accessToken.toString()
          }).then((value) async {
        var data = await jsonDecode(value.body);
        joined = data['message'];
      });
    } catch (e) {
      print(e);
    }
    return joined;
  }

  Future staffGetStudyMaterial() async {
    final accessToken = await Storage().getData('access_Token');
    final role = await Storage().getData('Role');
    final url = Api.domain + Api.getStaffStudyMaterialUrl;
    var datas;
   // List<ReadingMaterial> reading_Material = [];
    try {
      var response = await http.get(
          Uri.parse(
            url,
          ),
          headers: {
            "Authorization": "Bearer " + accessToken.toString()
          }).then((value) async {
        var data = await jsonDecode(value.body);
        print(data);
        var readingMaterials = data['data'];
        datas = readingMaterials;
        print(data);

      });
    } catch (e) {
      print(e);
    }

    return datas;
  }

  Future<List<HomeWork>> getHomeWork() async {
    final accessToken = await Storage().getData('access_Token');
    final role = await Storage().getData('Role');
    final url = role != 'staff'
        ? Api.domain + Api.getHomeworkUrl
        : Api.domain + Api.getStaffHomework;

    List<HomeWork> homework = [];
    try {
      var response = await http.get(
          Uri.parse(
            url,
          ),
          headers: {
            "Accept": Api.contentType,
            "Content-Type": Api.contentType,
            "Authorization": "Bearer " + accessToken.toString()
          }).then((value) async {
        var data = await jsonDecode(value.body);
        print(data);
        var home_Work =
            role != 'staff' ? data['data']['homeworks']['data'] : data['data'];
        ;

        print(data);

        for (var h in home_Work) {
          HomeWork home_work = role == 'staff'
              ? HomeWork(
                  id: h['ID'], date: h['homework_date'], title: h['title'])
              : HomeWork(id: h['id'], date: h['date'], title: h['title']);
          homework.add(home_work);
        }
      });
    } catch (e) {
      print(e);
    }
    print(homework.length);
    return homework;
  }

  Future<List<Subjects>> getSubjectList() async {
    final url = Api.domain + Api.getSubjectListUrl;
    final accessToken = await Storage().getData('access_Token');
    List<Subjects> homework = [];
    try {
      var response = await http.get(
          Uri.parse(
            url,
          ),
          headers: {
            "Accept": Api.contentType,
            "Content-Type": Api.contentType,
            "Authorization": "Bearer " + accessToken.toString()
          }).then((value) async {
        var data = await jsonDecode(value.body);
        print(data);
        var home_Work = data['data']['subjects']['data'];
        print(data);

        for (var h in home_Work) {
          Subjects home_work = Subjects(
              id: h['id'],
              type: h['type'],
              teacher: h['teacher'],
              code: h['code'],
              subName: h['subjectName']);
          homework.add(home_work);
        }
      });
    } catch (e) {
      print(e);
    }
    print(homework.length);
    return homework;
  }

  Future<HomeAttachments> getHomeWorkAttachments(id) async {
    var role = await  Storage().getData('Role');
    print(role);
    final url = role.toString() != 'staff'
        ? Api.domain + Api.getHomeworkUrl + '/' + id
        : Api.domain + Api.StaffHomeworkAttachments + '/' + id;
    final accessToken = await Storage().getData('access_Token');
    List<HomeAttachment> homework = [];
    var description = '';
    try {
      var response = await http.get(
          Uri.parse(
            url,
          ),
          headers: {
            "Accept": Api.contentType,
            "Content-Type": Api.contentType,
            "Authorization": "Bearer " + accessToken.toString()
          }).then((value) async {
        var data = await jsonDecode(value.body);
        print(data);
        description = data['data']['homework']['description'];
        var home_Work = data['data']['homework']['attachments'];

        for (var h in home_Work) {
          var attach = HomeAttachment(file: h['file_name'], url: h['url']);
          homework.add(attach);
        }
      });
    } catch (e) {
      print(e);
    }
    print(homework.length);
    return HomeAttachments(homeAttachment: homework, description: description);
  }

  ///TODO creat a data page to show home works
  Future<List<ReadingMaterial>> getStudyMaterial(sid, mType, cNo) async {
    final url =
        Api.domain + 'sm/student/study-material/$sid/$mType/Chapter$cNo';
    final accessToken = await Storage().getData('access_Token');
    List<ReadingMaterial> reading_Material = [];
    try {
      var response = await http.get(
          Uri.parse(
            url,
          ),
          headers: {
            "Authorization": "Bearer " + accessToken.toString()
          }).then((value) async {
        var data = await jsonDecode(value.body);
        print(data);
        var readingMaterials = data['data']['study_materials']['data'];
        print(data);
        for (var readingMaterial in readingMaterials) {
          List<ReadingAttachments> attachments_ = [];
          var listAttachment = readingMaterial['attachments'];
          for (var l in listAttachment) {
            var attach =
                ReadingAttachments(url: l['url'], fileName: l['file_name']);
            attachments_.add(attach);
          }
          ReadingMaterial readingMaterial_ = ReadingMaterial(
            mType: mType,
            id: readingMaterial['id'],
            title: readingMaterial['title'],
            date: readingMaterial['date'],
            url: readingMaterial['url'],
            attachments: attachments_,
          );
          reading_Material.add(readingMaterial_);
        }
      });
    } catch (e) {
      print(e);
    }
    return reading_Material;
  }

  Future<List<AttendanceObjects>> getAttendance() async {
    final role = await Storage().getData('Role');
    final url = role == 'staff'?Api.domain + Api.staffAttendanceRead + '/1' : Api.domain + Api.getAttendanceUrl;
    final accessToken = await Storage().getData('access_Token');
    final List<AttendanceObjects> attendanceObj = [];
    try {
      var response = await http.get(
          Uri.parse(
            url,
          ),
          headers: {
            "Accept": Api.contentType,
            "Content-Type": Api.contentType,
            "Authorization": "Bearer " + accessToken.toString()
          },


      ).then((value) async {

        var data = await jsonDecode(value.body);
        print(data);
        if(role == 'staff'){
          for(var i = 0; i<data['data'].length; i++ ){
            attendanceObj.add(
                AttendanceObjects(percentage: data['data'][i].toString(), month: "DateFormat('yyyy-MM-dd'). parse(data['data'][i]['date'])", total_Attendance: 'total_Attendance', presents: 'presents', absents: 'absents')
            );
          }

        }else{
          var overall = data['data']['attendance']['overall'];
          var att = data['data']['attendance']['monthly'];
          for (var a in att) {
            var presentPercent = int.parse(a['total_present'].toString()) /
                int.parse(a['total_attendance'].toString()) *
                100;
            var attendance = AttendanceObjects(
                month: a['month'],
                total_Attendance: a['total_attendance'],
                presents: a['total_present'],
                absents: a['total_absent'],
                percentage: presentPercent.round().toString());

            attendanceObj.add(attendance);
          }
          var oAll = AttendanceObjects(
              percentage: overall['percentage_text'].toString(),
              month: 'Overall',
              total_Attendance: overall['total_attendance'].toString(),
              presents: overall['total_present'].toString(),
              absents: overall['total_absent'].toString());
          attendanceObj.add(oAll);
        }

      });
    } catch (e) {
      print(e);
    }
    return attendanceObj;
  }
  Future getStaffAllStudents(section_id) async {

    final url = Api.domain + Api.staffGetStudents + '/$section_id';
    final accessToken = await Storage().getData('access_Token');
    var data;
    try {
      var response = await http.get(
        Uri.parse(
          url,
        ),
        headers: {
          "Accept": Api.contentType,
          "Content-Type": Api.contentType,
          "Authorization": "Bearer " + accessToken.toString()
        },


      ).then((value) async {

        var datas = await jsonDecode(value.body);

        data = datas['data'];


      });
    } catch (e) {
      print(e);
    }
    return data;
  }


  Future getAttendanceStaff(section_id) async {

    final url = Api.domain + Api.staffAttendanceRead + '/$section_id';
    final accessToken = await Storage().getData('access_Token');
    var data;
    try {
      var response = await http.get(
        Uri.parse(
          url,
        ),
        headers: {
          "Accept": Api.contentType,
          "Content-Type": Api.contentType,
          "Authorization": "Bearer " + accessToken.toString()
        },


      ).then((value) async {

        var datas = await jsonDecode(value.body);

        data = datas['data'];


      });
    } catch (e) {
      print(e);
    }
    return data;
  }

  Future<List<NoticeObject>> getNotice() async {
    final url = Api.domain + Api.getNotificationsUrl;
    final accessToken = await Storage().getData('access_Token');
    List<NoticeObject> notices = [];
    try {
      var response = await http.get(
          Uri.parse(
            url,
          ),
          headers: {
            "Accept": Api.contentType,
            "Content-Type": Api.contentType,
            "Authorization": "Bearer " + accessToken.toString()
          }).then((value) async {
        var data = await jsonDecode(value.body);
        print(data);
        var notes = data['data']['noticeboard']['data'];
        for (var note in notes) {
          var notice = NoticeObject(
              title: note['title'],
              url: note['link'],
              isNew: note['is_new'],
              date: note['date']);
          notices.add(notice);
        }
      });
    } catch (e) {
      print(e);
    }
    return notices;
  }

  Future<List<LiveClass>> getLiveClass() async {
    final role = await Storage().getData('Role');
    final url =role == 'staff' ?Api.domain + Api.staffLiveClass : Api.domain + Api.getLiveClassesUrl;
    final accessToken = await Storage().getData('access_Token');
    List<LiveClass> classes = [];
    try {
      var response = await http.get(
          Uri.parse(
            url,
          ),
          headers: {
            "Accept": Api.contentType,
            "Content-Type": Api.contentType,
            "Authorization": "Bearer " + accessToken.toString()
          }).then((value) async {
        var data = await jsonDecode(value.body);
        print(data.toString());
        final lives = data['data']['live_classes']['data'];
        print(lives);
        for (var l in lives) {
          var class_ = LiveClass(
            time: l['start_date_time'],
            subject: l['subject'],
            url: l['join_url'],
            description: l['topic'],
          );
          classes.add(class_);
        }
      });
    } catch (e) {
      print(e);
    }
    return classes;
  }

  Future<List<EventsObject>> getEvents() async {
    final role = await Storage().getData('Role');
    final url = role == 'staff' ? Api.domain + Api.staffEvents :Api.domain + Api.getEventUrl;
    final accessToken = await Storage().getData('access_Token');
    List<EventsObject> event = [];
    try {
      var response = await http.get(
          Uri.parse(
            url,
          ),
          headers: {
            "Accept": Api.contentType,
            "Content-Type": Api.contentType,
            "Authorization": "Bearer " + accessToken.toString()
          }).then((value) async {
        var data = await jsonDecode(value.body);
        print(data);
        final events = data['data']['events']['data'];
        for (var e in events) {
          var event_ = EventsObject(
              id: e['id'],
              title: e['title'],
              event_date: e['event_date'],
              image: e['image'],
              has_joined: e['has_joined']);
          event.add(event_);
        }

        print(data);
      });
    } catch (e) {
      print(e);
    }
    return event;
  }

  Future<List<LibraryObject>> getLibraryBooks() async {
    final url = Api.domain + Api.getLibraryBookIssuedListUrl;
    final accessToken = await Storage().getData('access_Token');
    List<LibraryObject> history = [];
    try {
      var response = await http.get(
          Uri.parse(
            url,
          ),
          headers: {
            "Accept": Api.contentType,
            "Content-Type": Api.contentType,
            "Authorization": "Bearer " + accessToken.toString()
          }).then((value) async {
        var data = await jsonDecode(value.body);
        var library = data['data']['books_issued']['data'];
        print(library);
        for (var l in library) {
          var book = LibraryObject(
              id: l['id'],
              book_title: l['book_title'],
              issued_quantity: l['issued_quantity'],
              date_issued: l['date_issued'],
              return_date: l['return_date'],
              return_status: l['return_status'],
              return_at: ['returned_at'],
              author: l['author'],
              subject: l['subject'],
              rack_number: l['rack_number'],
              book_number: l['book_number'],
              isbn_number: l['isbn_number']);
          history.add(book);
        }
      });
    } catch (e) {
      print(e);
    }
    return history;
  }

  Future getPaymentHistory() async {
    final url = Api.domain + Api.getPaymentHistoryUrl;
    final accessToken = await Storage().getData('access_Token');
    try {
      var response = await http.get(
          Uri.parse(
            url,
          ),
          headers: {
            "Accept": Api.contentType,
            "Content-Type": Api.contentType,
            "Authorization": "Bearer " + accessToken.toString()
          }).then((value) async {
        var data = await jsonDecode(value.body);
        print(data);
      });
    } catch (e) {
      print(e);
    }
  }

  Future<List<Time>> getTimeTable() async {
    final url = Api.domain + Api.getClassScheduleUrl;
    final accessToken = await Storage().getData('access_Token');
    List<Time> timeTable = [];

    try {
      var response = await http.get(
          Uri.parse(
            url,
          ),
          headers: {
            "Accept": Api.contentType,
            "Content-Type": Api.contentType,
            "Authorization": "Bearer " + accessToken.toString()
          }).then((value) async {
        var data = await jsonDecode(value.body);
        print(data);
        var time_table = data['data']['class_time_table']['data'];
        for (var time in time_table) {
          List<LeaveHistoryCard> routines = [
            LeaveHistoryCard(
              t1: 'Subject',
              t2: 'Start Time',
              t3: 'Room',
              textTheme: themeLabel,
            )
          ];
          var r = time['routines'];
          for (var d in r) {
            var routine = LeaveHistoryCard(
                textTheme: themeSubLabel,
                t1: d['subject'],
                t2: d['start_time'],
                t3: d['room']);
            routines.add(routine);
          }

          var times = Time(day: time['day'], routine: routines);
          timeTable.add(times);
        }
        print(data);
      });
    } catch (e) {
      print(e);
    }
    print(timeTable.length);
    return timeTable;
  }
  Future StaffAttendance() async {
    final url = Api.domain + Api.staffAttendance;
    final accessToken = await Storage().getData('access_Token');
    var datas;
    try {
      var response = await http.get(
          Uri.parse(
            url,
          ),
          headers: {
            "Accept": Api.contentType,
            "Content-Type": Api.contentType,
            "Authorization": "Bearer " + accessToken.toString()
          }).then((value) async {
        var data = await jsonDecode(value.body);
        print(data.toString());
        datas = data['data']['data'];
      });
    } catch (e) {
      print(e);
    }
  return datas;
  }
  Future<List<SelectExamCard>> getExamTimeTable() async {
    final url = Api.domain + Api.getExamScheduleListUrl;
    final accessToken = await Storage().getData('access_Token');
    List<SelectExamCard> timeTable = [];
    try {
      var response = await http.get(
          Uri.parse(
            url,
          ),
          headers: {
            "Accept": Api.contentType,
            "Content-Type": Api.contentType,
            "Authorization": "Bearer " + accessToken.toString()
          }).then((value) async {
        var data = await jsonDecode(value.body);
        print(data);
        var times = data['data']['exams']['data'];
        for (var t in times) {
          var time = SelectExamCard(
            id: t['id'],
            title: t['title'],
            start_Date: t['start_date'],
            endDate: t['end_date'],
            widget: ExamTimeTableSelectedData(
              label: 'Time Table',
              id: t['id'],
            ),
          );
          timeTable.add(time);
        }
      });
    } catch (e) {
      print(e);
    }
    print(timeTable.length);
    return timeTable;
  }

  Future<List<ExamTimeTableCard>> getSelectedExamTimeTable(id) async {
    final url = Api.domain + Api.getExamScheduleListUrl + '/$id';
    final accessToken = await Storage().getData('access_Token');
    List<ExamTimeTableCard> timeTable = [];
    try {
      var response = await http.get(
          Uri.parse(
            url,
          ),
          headers: {
            "Accept": Api.contentType,
            "Content-Type": Api.contentType,
            "Authorization": "Bearer " + accessToken.toString()
          }).then((value) async {
        var data = await jsonDecode(value.body);
        print(data);
        var exams = data['data']['exam']['data'];
        for (var e in exams) {
          var time = ExamTimeTableCard(
              subject: e['subject'],
              room_no: e['room_number'],
              date: e['paper_date'],
              time: e['start_time']);
          timeTable.add(time);
        }
      });
    } catch (e) {
      print(e);
    }
    print(timeTable.length);
    return timeTable;
  }

  Future<List<ExamTimeTableCard>> getSelectedAdmitCard(id) async {
    final url = Api.domain + Api.getAdmitCardListUrl + '/$id';
    final accessToken = await Storage().getData('access_Token');
    List<ExamTimeTableCard> timeTable = [];
    try {
      var response = await http.get(
          Uri.parse(
            url,
          ),
          headers: {
            "Accept": Api.contentType,
            "Content-Type": Api.contentType,
            "Authorization": "Bearer " + accessToken.toString()
          }).then((value) async {
        var data = await jsonDecode(value.body);
        print(data);
        var exams = data['data']['exam']['data'];
        for (var e in exams) {
          var time = ExamTimeTableCard(
              subject: e['subject'],
              room_no: e['room_number'],
              date: e['paper_date'],
              time: e['start_time']);
          timeTable.add(time);
        }
      });
    } catch (e) {
      print(e);
    }
    print(timeTable.length);
    return timeTable;
  }

  Future<List<SelectExamCard>> getAdmitCard() async {
    final url = Api.domain + Api.getAdmitCardListUrl;
    final accessToken = await Storage().getData('access_Token');
    List<SelectExamCard> timeTable = [];
    try {
      var response = await http.get(
          Uri.parse(
            url,
          ),
          headers: {
            "Accept": Api.contentType,
            "Content-Type": Api.contentType,
            "Authorization": "Bearer " + accessToken.toString()
          }).then((value) async {
        var data = await jsonDecode(value.body);
        print(data);
        var times = data['data']['admit_cards']['data'];
        for (var t in times) {
          var time = SelectExamCard(
            id: t['id'],
            title: t['exam_title'],
            start_Date: t['start_date'],
            endDate: t['end_date'],
            widget: AdmitCardSelectedData(
              label: 'Admit Cards',
              id: t['id'],
            ),
          );
          timeTable.add(time);
        }
      });
    } catch (e) {
      print(e);
    }
    print(timeTable.length);
    return timeTable;
  }

  Future<List<ResultCard>> getSelectedResult(id) async {
    final url = Api.domain + Api.getExamResultListUrl + '/$id';
    final accessToken = await Storage().getData('access_Token');
    var total = 0;
    var totalMax = 0;
    var percent = 0.0;
    var pass = '';
    List<ResultCard> timeTable = [
      ResultCard(
        t1: 'Code',
        t2: 'Sub',
        t3: 'Sub Type',
        t4: '',
        t5: 'Obtained',
        t6: 'grade',
        theme: themeLabel,
      ),
    ];
    try {
      var response = await http.get(
          Uri.parse(
            url,
          ),
          headers: {
            "Accept": Api.contentType,
            "Content-Type": Api.contentType,
            "Authorization": "Bearer " + accessToken.toString()
          }).then((value) async {
        var data = await jsonDecode(value.body);
        print(data.toString().contains('pass'));

        var results = data['data']['result']['data'];
        for (var r in results) {
          var result = ResultCard(
            t1: r['paper_code'],
            t2: r['subject_name'],
            t3: r['subject_type'],
            t4: '/' + r['maximum_marks'],
            t5: r['obtained_marks'],
            t6: r['grade'],
            theme: themeSubLabel,
          );
          timeTable.add(result);
          total = total + int.parse(r['obtained_marks']);
          totalMax = totalMax + int.parse(r['maximum_marks']);
          percent = total / totalMax * 100;
          pass = int.parse(r['obtained_marks']) >= 35 ? 'pass' : 'failed';
        }
        var overAll = ResultCard(
          t1: 'Total :',
          t2: total.toString(),
          t3: 'Percent',
          t4: '%',
          t5: percent.toInt(),
          t6: pass,
          theme: themeLabel,
        );
        timeTable.add(overAll);
      });
    } catch (e) {
      print(e);
    }
    print(timeTable.length);
    return timeTable;
  }

  Future<List<ExamResultCard>> getExamResults() async {
    final role = await Storage().getData('Role');
    final url =role == 'staff'? Api.domain + Api.staffResults : Api.domain + Api.getExamResultListUrl;
    final accessToken = await Storage().getData('access_Token');
    final List<ExamResultCard> results = [];

    try {
      var response = await http.get(
          Uri.parse(
            url,
          ),
          headers: {
            "Accept": Api.contentType,
            "Content-Type": Api.contentType,
            "Authorization": "Bearer " + accessToken.toString()
          }).then((value) async {
        var data = await jsonDecode(value.body);
        final role = await Storage().getData('Role');
        print(data.toString());
        var times = data['data']['results']['data'];
        for (var t in times) {
          var time = ExamResultCard(
            id: t['id'],
            title: t['title'],
            start_Date: t['start_date'],
            endDate: t['end_date'],

            widget: ExamSelectedResultData(
              id: t['id'],
              label: t['title'],
            ), role: role, data: t,
          );
          results.add(time);
        }
      });
    } catch (e) {
      print(e);
    }
    return results;
  }

  Future<List<OnlineExam>> getQuizCategory() async {
    final url = Api.domain + Api.getQuizCategoryUrl;
    final accessToken = await Storage().getData('access_Token');
    List<OnlineExam> exams_ = [];
    try {
      var response = await http.get(
          Uri.parse(
            url,
          ),
          headers: {
            "Accept": Api.contentType,
            "Content-Type": Api.contentType,
            "Authorization": "Bearer " + accessToken.toString()
          }).then((value) async {
        var data = await jsonDecode(value.body);
        print(data);
        var exams = data['data']['quiz_categories']['data'];
        print(data);

        for (var exam in exams) {
          OnlineExam onlineExam = OnlineExam(
              id: exam['id'],
              title: exam['title'],
              description: exam['description']);
          exams_.add(onlineExam);
        }
      });
    } catch (e) {
      print(e);
    }
    print(exams_.length);
    return exams_;
  }

  Future<List<PaymentInvoices>> getPaymentInvoices() async {
    final url = Api.domain + Api.getFeesUrl;
    final accessToken = await Storage().getData('access_Token');
    List<PaymentInvoices> payments = [];
    try {
      var response = await http.get(
          Uri.parse(
            url,
          ),
          headers: {
            "Accept": Api.contentType,
            "Content-Type": Api.contentType,
            "Authorization": "Bearer " + accessToken.toString()
          }).then((value) async {
        var data = await jsonDecode(value.body);
        print(data);
        var payments_ = data['data']['invoices']['data'];
        print(data);

        for (var p in payments_) {
          var payment = PaymentInvoices(
              date: p['date_issued'],
              dueDate: p['due_date'],
              invoicesNo: p['invoice_number'],
              payable: p['payable'],
              paid: p['paid'],
              due: p['due'],
              title: ['invoice_title'],
              id: p['id']);
          payments.add(payment);
        }
      });
    } catch (e) {
      print(e);
    }
    print(payments.length);
    return payments;
  }

  Future<List<Quiz>> getQuiz(id) async {
    final url = Api.domain + Api.getQuizUrl + '/' + id;
    final accessToken = await Storage().getData('access_Token');
    List<Quiz> quiz_ = [];
    try {
      var response = await http.get(
          Uri.parse(
            url,
          ),
          headers: {
            "Accept": Api.contentType,
            "Content-Type": Api.contentType,
            "Authorization": "Bearer " + accessToken.toString()
          }).then((value) async {
        var data = await jsonDecode(value.body);
        print(data);
        var quizes = data['data']['quizes']['data'];
        for (var quiz in quizes) {
          var q = Quiz(
              id: quiz['id'],
              title: quiz['title'],
              description: quiz['description']);
          quiz_.add(q);
        }
      });
    } catch (e) {
      print(e);
    }
    print(quiz_.length);
    return quiz_;
  }

  Future<List<LeaveHistory>> getLeaveHistory() async {
    final url = Api.domain + Api.getLeaveRequestUrl;
    final accessToken = await Storage().getData('access_Token');
    List<LeaveHistory> history = [];
    try {
      var response = await http.get(
          Uri.parse(
            url,
          ),
          headers: {
            "Accept": Api.contentType,
            "Content-Type": Api.contentType,
            "Authorization": "Bearer " + accessToken.toString()
          }).then((value) async {
        var data = await jsonDecode(value.body);
        print(data);
        var histories = data['data']['leaves']['data'];

        for (var h in histories) {
          var material = LeaveHistory(
              reason: h['reason'],
              date: h['leave_date'],
              status: h['approval'], id: h['id'],name: h['name']);
          history.add(material);
        }
      });
    } catch (e) {
      print(e);
    }
    print(history.length);
    return history;
  }
  Future<List<LeaveHistory>> staffLeaveHistory() async {
    final url = Api.domain + Api.staffLeaveRequests;
    final accessToken = await Storage().getData('access_Token');
    List<LeaveHistory> history = [];
    try {
      var response = await http.get(
          Uri.parse(
            url,
          ),
          headers: {
            "Accept": Api.contentType,
            "Content-Type": Api.contentType,
            "Authorization": "Bearer " + accessToken.toString()
          }).then((value) async {
        var data = await jsonDecode(value.body);
        print(data);
        var histories = data['data']['leaves']['data'];

        for (var h in histories) {
          var material = LeaveHistory(
              reason: h['reason'],
              date: h['leave_date'],
              status: h['approval'],
              id: h['id'], name: h['name']);
          history.add(material);
        }
      });
    } catch (e) {
      print(e);
    }
    print(history.length);
    return history;
  }

  Future<List> getPosts() async {
    List data = [];
    await http.get(
        Uri.parse('https://samuelinstitution.com//wp-json/wp/v2/posts?_embed'),
        headers: {
          "Accept": Api.contentType,
          "Content-Type": Api.contentType,
        }).then((value) {
      print(jsonDecode(value.body.toString()));
      var posts = jsonDecode(value.body);
      for (var post in posts) {
        data.add(post);
      }
    });
    return data;
  }

  Future<Map> getStaffSchoolData() async {
    Map data = {};
    final url = Api.domain + Api.staffAboutSchool;
    final accessToken = await Storage().getData('access_Token');
    await http.get(Uri.parse(url), headers: {
      "Accept": Api.contentType,
      "Content-Type": Api.contentType,
      "Authorization": "Bearer " + accessToken.toString()
    }).then((value) {
      print(jsonDecode(value.body.toString()));
      data = jsonDecode(value.body);
    });
    return data;
  }

  Future<List> getClasses() async {
    final url = Api.domain + Api.classes;
    final accessToken = await Storage().getData('access_Token');
    var _class;
    try {
      var response = await http.get(
          Uri.parse(
            url,
          ),
          headers: {
            "Accept": Api.contentType,
            "Content-Type": Api.contentType,
            "Authorization": "Bearer " + accessToken.toString()
          }).then((value) async {
        var data = await jsonDecode(value.body);
        print(data);
        _class = data['data']['data'];
      });
    } catch (e) {
      print(e);
    }
    print(_class.length);
    return _class;
  }

  Future<List> getSections(id) async {
    final url = Api.domain + Api.sections + '/' + id;
    final accessToken = await Storage().getData('access_Token');
    var _class;
    try {
      var response = await http.get(
          Uri.parse(
            url,
          ),
          headers: {
            "Accept": Api.contentType,
            "Content-Type": Api.contentType,
            "Authorization": "Bearer " + accessToken.toString()
          }).then((value) async {
        var data = await jsonDecode(value.body);
        print(data);
        _class = data['data']['data'];
      });
    } catch (e) {
      print(e);
    }
    print(_class.length);
    return _class;
  }

  Future<List> getSubjects(id) async {
    final url = Api.domain + Api.subjects + '/' + id;
    final accessToken = await Storage().getData('access_Token');
    var _class;
    try {
      var response = await http.get(
          Uri.parse(
            url,
          ),
          headers: {
            "Accept": Api.contentType,
            "Content-Type": Api.contentType,
            "Authorization": "Bearer " + accessToken.toString()
          }).then((value) async {
        var data = await jsonDecode(value.body);
        print(data);
        _class = data['data']['data'];
      });
    } catch (e) {
      print(e);
    }
    print(_class.length);
    return _class;
  }

  Future<dynamic> getFile() async {

    final api = WordPressAPI(Api.domain);


    var _file;
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Select Source"),
            content: Row(
           //   mainAxisAlignment: MainAxisAlignment.,
              children: [
                IconButton(
                  onPressed: () async {

                    FilePickerResult? result =
                        await FilePicker.platform.pickFiles(
                      type: FileType.custom,
                      allowedExtensions: ['jpg', 'png', 'pdf', 'docs', 'mp4'],
                    );
                    if (result != null) {

                      File file = File(result.files.single.path.toString());
                      _file = file;


                    } else {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text('File selection Cancelled'),
                              actions: [
                                OutlinedButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text('Ok'))
                              ],
                            );
                          });
                      // User canceled the picker
                    }
                  },
                  icon: Icon(Icons.folder),
                ),
                IconButton(onPressed: ()async{
                  final ImagePicker _picker = ImagePicker();
                  final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
                  if(photo != null){
                    _file = photo;
                    Navigator.pop(context);
                  }else{
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text('File selection Cancelled'),
                            actions: [
                              OutlinedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text('Ok'))
                            ],
                          );
                        });
                  }
                }, icon: Icon(Icons.camera))
              ],
            ),
            actions: [
              OutlinedButton(onPressed: (){Navigator.pop(context);}, child: Text('Go Back'))
            ],
          );
        });

    return _file;
  }
}
