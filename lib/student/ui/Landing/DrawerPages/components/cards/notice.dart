import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vshala/constants/theme.dart';
import 'package:vshala/student/ui/components/pdfViewer.dart';
import 'package:vshala/student/ui/components/uiProvider.dart';
import 'package:provider/provider.dart';
import 'package:vshala/student/ui/components/webView.dart';

class Notice extends StatelessWidget {
  final date;
  final url;
  final title;
  const Notice({
    Key? key,
    required this.date,
    required this.url,
    required this.title,
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
              date,
              style: themeLabel,
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.alice(color: Colors.black54),
                ),

                Container(child:url != '#' ?  OutlinedButton(
                  onPressed: () {
                    print(url);
                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                      return url.toString().contains('preview') == true ||
                          url.toString().contains('mp4') == true
                          ? WebViewFullScreen(
                        url: url,
                        title: title,
                      )
                          :PdfView(fileName: title,url: url,);
                    }));
                  },
                  child: Text('Read More'),
                ):null,)
              ],


            ),

          ),
        ),
      ),
    );
  }
}
