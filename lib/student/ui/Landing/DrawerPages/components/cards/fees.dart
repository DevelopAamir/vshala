import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vshala/student/ui/components/uiProvider.dart';
import 'package:provider/provider.dart';

class FeesCard extends StatelessWidget {
  const FeesCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(
          Icons.payment,
          color: context.watch<UiProvider>().theme == 'light'
              ? Color(0xff0DB6D1)
              : Color(0xff00BBD3),
        ),
        title: Text('Payed', style: GoogleFonts.alice(color: Colors.black)),
        subtitle: Text('20,000', style: GoogleFonts.alice(color: Colors.black54)),
        trailing: Icon(
          Icons.done_rounded,
          color: Colors.black,
        ),
      ),
    );
  }
}
