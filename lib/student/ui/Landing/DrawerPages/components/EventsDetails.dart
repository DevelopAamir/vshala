

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:vshala/constants/api.dart';
import 'package:vshala/student/connector/connector.dart';
import 'package:vshala/student/connector/getData.dart';
import 'package:vshala/student/ui/components/uiProvider.dart';
import 'package:http/http.dart' as http;

class EventsDetails extends StatelessWidget {
  final String label;
  final title;
  final image;
  final id;
  final is_joined;
  final role;
  const EventsDetails(
      {Key? key,
      required this.label,
      this.title,
      this.image,
      this.id,
      this.is_joined,required this.role})
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
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Text(
                '$title',
                maxLines: 1,
                style: GoogleFonts.alice(
                  fontSize: 30,
                  color: Colors.white,
                ),
              ),
              Expanded(
                  child: Container(
                child:Stack(
                  children: [
                    Center(
                      child: SpinKitCircle(color:Colors.indigo),
                    ),
                    Center(child: Image.network(image)),
                  ],
                )
              )),
              if(role != 'staff')
              MaterialButton(
                  onPressed: () async {
                    if (Provider.of<Connector>(context, listen: false).joined ==
                        'false') {
                      final response = await GetData(context: context).joinEvent(id);
                      Fluttertoast.showToast(msg: response.toString());
                      Provider.of<Connector>(context, listen: false).join('true');


                    }else{
                      final response = await GetData(context: context).unJoinEvent(id);
                      Fluttertoast.showToast(msg: response.toString());
                      Provider.of<Connector>(context, listen: false).join('false');
                    }

                  },

                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.indigo,
                        borderRadius: BorderRadius.circular(10)),
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Center(
                          child: Text(context.watch<Connector>().joined == 'true' ? 'UnJoin' : 'Join',
                              style: GoogleFonts.alice(
                                  fontSize: 20, color: Colors.white))),
                    ),
                  ))
            ],
          ),
        ));
  }
}
