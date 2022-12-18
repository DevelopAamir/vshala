import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vshala/student/connector/connector.dart';
import 'package:vshala/student/connector/getData.dart';
import 'package:vshala/student/ui/Landing/DrawerPages/components/cards/redingMaterial.dart';
import 'package:vshala/student/ui/components/uiProvider.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter/material.dart';
import 'package:webview_cookie_manager/webview_cookie_manager.dart';
import 'package:provider/provider.dart';

class WebViewPage extends StatefulWidget {
  final title;
  final url;

  WebViewPage({
    Key? key,
    this.title,
    this.url,
  }) : super(key: key);

  @override
  State<WebViewPage> createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  final cookieManager = WebviewCookieManager();

  getCookies() async {
    final gotCookies = await cookieManager.getCookies(widget.url);
    for (var item in gotCookies) {
      print(item);
    }
  }

  @override
  void initState() {
    getCookies();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: context.watch<UiProvider>().theme == 'light'
            ? Color.fromRGBO(135, 112, 255, 0.9)
            : Color(0xff2A2B30),
        title: Text(widget.title),
      ),
      body: Container(
        child: InAppWebView(
          initialUrlRequest: URLRequest(url: Uri.parse(widget.url)),
          onExitFullscreen: (a)async{
            await a.android.pause();
           Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
             return WebViewWithAttachment(title: widget.title,url: widget.url,);
           }));
          },

          onReceivedServerTrustAuthRequest: (controller, challenge) async {
            print(challenge);
            return ServerTrustAuthResponse(
                action: ServerTrustAuthResponseAction.PROCEED);
          },
        ),
      ),
    );
  }
}

class WebViewWithAttachment extends StatefulWidget {
  final url;
  final title;
  final attachments;
  const WebViewWithAttachment(
      {Key? key, this.url, this.title, this.attachments})
      : super(key: key);

  @override
  _WebViewWithAttachmentState createState() => _WebViewWithAttachmentState();
}

class _WebViewWithAttachmentState extends State<WebViewWithAttachment> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.watch<UiProvider>().theme == 'light'
          ? Color.fromRGBO(135, 112, 255, 0.9)
          : Color(0xff2A2B30),
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child:  Stack(
              children: [
                WebViewPage(
                        title: widget.title,
                        url: widget.url
                      ),
                AbsorbPointer(
                  child: Container(
                    color: Colors.transparent,
                    width: 70,height: 40,
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: GestureDetector(
                    onTap: (){
                      Navigator.pop(context);

                      Navigator.push(context, MaterialPageRoute(builder: (context){
                        return WebViewFullScreen(url: widget.url,title: widget.title,);
                      }));

                    },
                    child: Container(
                      color: Colors.transparent,
                      width: 70,height: 40,
                    ),
                  ),
                )
              ],
            )

          ),
          Expanded(
            flex: 1,
              child: Padding(
            padding: const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
            child: Container(

              decoration: BoxDecoration(
                  color:context.watch<UiProvider>().theme == 'light'
                      ? Color.fromRGBO(135, 112, 255, 1)
                      : Color(0xff2A2B30),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  )),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Text(
                      widget.title,
                      style: GoogleFonts.alice(
                          fontSize: 20,
                          color: Colors.white70,
                          fontWeight: FontWeight.normal),
                    ),
                  ),

                ],
              ),
            ),
          ))
        ],
      ),
    );
  }
  @override
  void deactivate() {
    // TODO: implement deactivate
    super.deactivate();
  }
}

class WebViewFullScreen extends StatefulWidget {
  final url;
  final title;
  const WebViewFullScreen({Key? key, this.url, this.title}) : super(key: key);

  @override
  State<WebViewFullScreen> createState() => _WebViewFullScreenState();
}

class _WebViewFullScreenState extends State<WebViewFullScreen> {
  final cookieManager = WebviewCookieManager();

  getCookies() async {
    final gotCookies = await cookieManager.getCookies(widget.url);
    for (var item in gotCookies) {
      print(item);
    }
  }
  @override
  void initState() {
    getCookies();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            child: InAppWebView(
              initialUrlRequest: URLRequest(url: Uri.parse(widget.url)),
              onWebViewCreated: (a){

              },
              onExitFullscreen: (a)async{

                await a.android.pause();
                Navigator.pop(context);

              },

              onReceivedServerTrustAuthRequest: (controller, challenge) async {
                print(challenge);
                return ServerTrustAuthResponse(
                    action: ServerTrustAuthResponseAction.PROCEED);
              },
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                  radius: 30,
                  backgroundImage:NetworkImage(context.watch<Connector>().logo,)
              ),
            ),
          ),
        ],
      ),
    );
  }
  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }
}



