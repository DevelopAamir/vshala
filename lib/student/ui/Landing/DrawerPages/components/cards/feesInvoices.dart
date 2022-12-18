import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vshala/student/ui/components/uiProvider.dart';
import 'package:provider/provider.dart';

class FessInvoices extends StatelessWidget {
  const FessInvoices({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: ListTile(
        onTap: () {
          showDialog(
            context: context,
            builder: (context) {
              return Dialog(
                child: Container(width: 500, height: 500, color: Colors.white),
              );
            },
          );
        },
        leading: Icon(
          Icons.class_,
          size: 30,
          color: context.watch<UiProvider>().theme == 'light'
              ? Color(0xff0DB6D1)
              : Color(0xff00BBD3),
        ),
        title: Text(
          'January',
          style: GoogleFonts.alice(color: Colors.white),
        ),
        subtitle: Text(
          '7000',
          style: GoogleFonts.alice(color: Colors.white54),
        ),
        trailing: OutlinedButton(
          onPressed: () {},
          child: Text(
            'pay Now',
            style: GoogleFonts.alice(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
