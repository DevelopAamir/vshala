import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vshala/main.dart';
import 'package:provider/provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:vshala/student/connector/login.dart';

import 'package:vshala/student/ui/Login/components/background.dart';
import 'package:vshala/student/ui/Login/components/button.dart';
import 'package:vshala/student/ui/Login/components/textField.dart';
import 'package:vshala/student/ui/components/uiProvider.dart';

class Login extends StatelessWidget {
  Login({Key? key}) : super(key: key);
  final TextEditingController user = TextEditingController();
  final TextEditingController pass = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Background(),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset('assets/illustration.svg'),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        "Login",
                        style: GoogleFonts.alice(fontSize: 30),
                      ),
                    ),
                  ),
                  Textfield(
                    controller: user,
                    hintText: 'Enter ID',
                  ),
                  Textfield(
                    controller: pass,
                    hintText: 'Enter password',
                  ),
                  Button(
                    ontap: () async {
                      Provider.of<UiProvider>(context, listen: false).spinner();
                      try {
                        await LoginConnector(
                          context: context,
                          username: user.text.trim(),
                          password: pass.text.trim(),
                        ).login().whenComplete(() {
                          user.clear();
                          pass.clear();
                          Provider.of<UiProvider>(context, listen: false).spinner();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SplashScreen()));
                        });
                      } catch (e) {
                        print(e);
                      }

                    },
                  )
                ],
              ),
            ),

            Center(
              child: context.watch<UiProvider>().spin == true? SpinKitCircle(
                color: Color.fromRGBO(135, 112, 255, 0.9),
              ): Container(),
            )
          ],
        ),
      ),
    );
  }
}
