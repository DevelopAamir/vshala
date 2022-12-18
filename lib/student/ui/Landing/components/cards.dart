import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Cards extends StatelessWidget {
  final VoidCallback ontap;
  final IconData? icon;
  final Color iconColor;
  final Color bgColor;
  final String text;
  final Color color;
  const Cards({
    Key? key,
    required this.icon,
    required this.text,
    required this.color,
    required this.iconColor,
    required this.bgColor,
    required this.ontap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: InkWell(
        onTap: ontap,
        child: Container(
          width: MediaQuery.of(context).size.width * 0.3,
          height: 150,
          decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                    color: Colors.black26,
                    offset: Offset(4, 4),
                    blurRadius: 7,
                    spreadRadius: 0)
              ]),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundColor: bgColor,
                radius: 28,
                child: Icon(
                  icon,
                  size: 30,
                  color: iconColor,
                ),
              ),
              SizedBox(height: 5),
              Text(
                text,
                style: GoogleFonts.alice(
                  fontWeight: FontWeight.w500,
                    fontSize: 12,
                    color: color == Color(0xffffffff)
                        ? Color(0xff303539)
                        : Color(0xffffffff)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
