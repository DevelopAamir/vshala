import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vshala/constants/theme.dart';
import 'package:vshala/student/ui/components/uiProvider.dart';
import 'package:provider/provider.dart';

class LiveClass extends StatelessWidget {
  final time;
  final subject;
  final url;
  final description;

  const LiveClass({
    Key? key,required this.time,required this.subject,required this.url,required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(

            leading: Icon(
              Icons.class_,
              size: 30,
              color: context.watch<UiProvider>().theme == 'light'
                  ? Color(0xff0DB6D1)
                  : Color(0xff00BBD3),
            ),
            title: Text(
              subject,
              style: themeLabel
            ),
            subtitle: Text(
              description + '\n'+
              time,
              style: GoogleFonts.alice(color: Colors.black54),
            ),
            trailing: OutlinedButton(
              onPressed: ()async {
                await launch(url);
              },
              child: Text(
                'Join Now',
                style: GoogleFonts.alice(color: Colors.black),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
