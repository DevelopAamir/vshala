import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';

class Background extends StatelessWidget {
  const Background({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
              alignment: Alignment.topLeft,
              child: SvgPicture.asset('assets/top.svg')),
          Container(
            child: SvgPicture.asset(
              'assets/bottom.svg',
              fit: BoxFit.fitWidth,
            ),
          )
        ],
      ),
    );
  }
}
