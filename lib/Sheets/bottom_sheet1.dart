import 'package:flutter/material.dart';
import 'dart:math';

class BottomSheetWidget1 extends StatefulWidget {
  final String end;
  final VoidCallback proceed;
  // final ScrollController scrollController;
  //final double bottomSheetOffset;
  BottomSheetWidget1({
    required this.end,
    required this.proceed,
    // required this.scrollController,
    //  required this.bottomSheetOffset,
    Key? key,
  }) : super(key: key);

  @override
  _BottomSheetWidget1State createState() => _BottomSheetWidget1State();
}

class _BottomSheetWidget1State extends State<BottomSheetWidget1> {
  Color color1 = Color(0XffEAEAEA);
  Color color2 = Color(0XffEAEAEA);
  Color color3 = Color(0XffEAEAEA);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: widget.proceed,
      child: Container(
        height: height / 2,
        color: Color(0Xff4C6EE5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 40,
            ),
            Text(
              'Apply',
              style: TextStyle(
                  fontSize: 15,
                  decoration: TextDecoration.none,
                  fontFamily: 'Roboto',
                  color: Colors.white,
                  fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}
