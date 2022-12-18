import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';
import 'package:vshala/student/connector/connector.dart';
import 'package:vshala/student/ui/components/pdfViewer.dart';
import 'package:vshala/student/ui/components/uiProvider.dart';
import 'package:vshala/student/ui/components/webView.dart';

class StudyMaterialDataCard extends StatelessWidget {
  final String title;
  final String url;
  final date;
  final mType;
  final attachments;
  const StudyMaterialDataCard({
    Key? key,
    required this.title,
    required this.url,
    required this.attachments,
    required this.date,
    required this.mType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: mType == 'Video'
          ? AspectRatio(
              aspectRatio: 6 / 4,
              child: Container(
                child: Column(
                  children: [
                    Expanded(
                      child: Container(
                          decoration: BoxDecoration(
                              color:
                                  context.watch<UiProvider>().theme == 'light'
                                      ? Color.fromRGBO(135, 112, 255, 0.9)
                                      : Color(0xff2A2B30),
                              borderRadius: BorderRadius.circular(20)),
                          child: Center(
                            child: Stack(
                              children: [

                                InAppWebView(
                                  initialUrlRequest: URLRequest(
                                    url: Uri.parse(
                                        url == '' ? attachments[0].url : url),
                                  ),
                                  onWebViewCreated: (a) {
                                    a.isLoading() == true
                                        ? SpinKitCircle()
                                        : Container();
                                  },
                                  initialOptions: InAppWebViewGroupOptions(
                                      android: AndroidInAppWebViewOptions()),
                                  onReceivedServerTrustAuthRequest:
                                      (controller, challenge) async {
                                    return ServerTrustAuthResponse(
                                        action: ServerTrustAuthResponseAction
                                            .PROCEED);
                                  },
                                ),
                                Align(
                                    alignment: Alignment.bottomRight,
                                    child: GestureDetector(
                                      onTap: (){
                                        Navigator.pushReplacement(context,
                                            MaterialPageRoute(builder: (context) {
                                              return WebViewFullScreen(url:url,title: title,);
                                            }));
                                      },
                                        child: AbsorbPointer(
                                          child: Container(
                                            width: 60,
                                      height: 40,
                                    ),
                                        ))),
                                Align(
                                  alignment: Alignment.topRight,
                                  child: Padding(
                                    padding: const EdgeInsets.all(3.0),
                                    child: CircleAvatar(
                                      radius: 30,
                                      backgroundImage:NetworkImage(context.watch<Connector>().logo,)
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )),
                    ),
                    ListTile(
                      onTap: () {
                        print(url);
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) {
                          return WebViewFullScreen(url:url,title: title,);
                        }));
                      },
                      leading: Icon(
                        Icons.play_circle_filled,
                        size: 30,
                        color: context.watch<UiProvider>().theme == 'light'
                            ? Color(0xff0DB6D1)
                            : Color(0xff00BBD3),
                      ),
                      title: Text(
                        title,
                        style: GoogleFonts.alice(color: Colors.white),
                      ),
                      subtitle: Text(
                        date,
                        style: GoogleFonts.alice(color: Colors.white54),
                      ),
                    ),
                  ],
                ),
              ),
            )
          : Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                  onTap: () {
                    print(url);
                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                      return PdfView(
                        fileName: title,
                        url: url,
                        attachments: attachments,
                      );
                    }));
                  },
                  leading: Icon(
                    Icons.picture_as_pdf,
                    size: 30,
                    color: context.watch<UiProvider>().theme == 'light'
                        ? Color(0xff0DB6D1)
                        : Color(0xff00BBD3),
                  ),
                  title: Text(
                    title,
                    style: GoogleFonts.alice(color: Colors.black),
                  ),
                  subtitle: Text(
                    date,
                    style: GoogleFonts.alice(color: Colors.black54),
                  ),
                ),
            ),
          ),
    );
  }
}
