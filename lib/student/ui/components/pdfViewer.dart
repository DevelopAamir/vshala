import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:open_file/open_file.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:vshala/student/connector/connector.dart';
import 'package:vshala/student/ui/components/uiProvider.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PdfView extends StatefulWidget {
  final url;
  final attachments;
  final fileName;
  const PdfView({Key? key, this.url, this.attachments, required this.fileName})
      : super(key: key);

  @override
  State<PdfView> createState() => _PdfViewState();
}

class _PdfViewState extends State<PdfView> {
  //var localPath
  var uri;

  // getLocalPath() async {
  //   if (uri != '') {
  //     await ApiServiceProvider()
  //         .loadPDF(uri, widget.fileName)
  //         .then((value) async {
  //       setState(() {
  //
  //       });
  //       // Navigator.pop(context);
  //       // o();
  //     });
  //   }
  // }

  // o() async {
  //   try {
  //     await OpenFile.open(localPath);
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.url != ''
        ? setState(() {
          mounted;
            uri = widget.url;
          })
        : setState(() {
          mounted;
            uri = widget.attachments[0].url;
          });
    //getLocalPath();
  }
  var load = true;
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
          widget.fileName,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: uri != ''
          ?  uri.toString().contains('jpg') == true ||
                      uri.toString().contains('jpeg') == true ||
                      uri.toString().contains('png') == true
                  ? Center(child: InteractiveViewer(child: AspectRatio(aspectRatio:1,child: Image.network(uri))))
                  : Stack(
                      children: [
                        WebView(
                          initialUrl:
                              ('https://docs.google.com/gview?embedded=true&url=${uri}'),
                          javascriptMode: JavascriptMode.unrestricted,
                          onPageStarted: (a){
                            setState(() {
                              load = true;
                            });

                          },
                          onPageFinished:(a){
                            setState(() {
                              load = false;
                            });


                          },

                        ),
                        Align(
                            alignment: Alignment.topRight,
                            child: Padding(
                              padding: const EdgeInsets.all(1.0),
                              child: CircleAvatar(
                                  radius: 15,
                                  backgroundImage: NetworkImage(
                                    context.watch<Connector>().logo,
                                  )),
                            )),
                        Center(
                          child: load == true
                              ? SpinKitCircle(
                            color: Colors.indigo,
                          )
                              : Container(),
                        )

                      ],
                    )
              : Center(child: CircularProgressIndicator())

    );
  }
}

// class ApiServiceProvider {
//   Future<String> loadPDF(url, fileName) async {
//     var response = await http.get(Uri.parse(url));
//
//     var dir = await getApplicationDocumentsDirectory();
//     File file = new File("${dir.path}/$fileName");
//     file.writeAsBytesSync(response.bodyBytes, flush: true);
//     return file.path;
//   }
// }
