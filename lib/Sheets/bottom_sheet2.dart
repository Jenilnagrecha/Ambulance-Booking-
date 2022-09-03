import 'package:flutter/material.dart';

class Bottomsheet2 extends StatefulWidget {
  final VoidCallback booknow;
  Bottomsheet2({
    required this.booknow,
    Key? key,
  }) : super(key: key);

  @override
  _Bottomsheet2State createState() => _Bottomsheet2State();
}

class _Bottomsheet2State extends State<Bottomsheet2> {
  int flg1 = 0;
  int flg2 = 0;
  int flg3 = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(50),
          topRight: Radius.circular(50),
        ),
      ),
      child: ListView(
        children: [
          SizedBox(
            height: 50,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Row(
              children: [
                Image.asset('assets/pt1.png'),
                Expanded(child: SizedBox()),
                Image.asset('assets/pt2.png'),
              ],
            ),
          ),
          Row(
            children: const [
              Text(
                'origin',
                style: TextStyle(
                    fontSize: 10,
                    decoration: TextDecoration.none,
                    fontFamily: 'RobotoMono',
                    color: Colors.black,
                    fontWeight: FontWeight.w300),
              ),
              SizedBox(
                width: 153,
              ),
              Text(
                'X kms',
                style: TextStyle(
                    fontSize: 10,
                    decoration: TextDecoration.none,
                    fontFamily: 'RobotoMono',
                    color: Colors.black,
                    fontWeight: FontWeight.w300),
              ),
              SizedBox(
                width: 145,
              ),
              Text(
                'destination',
                style: TextStyle(
                    fontSize: 10,
                    decoration: TextDecoration.none,
                    fontFamily: 'RobotoMono',
                    color: Colors.black,
                    fontWeight: FontWeight.w300),
              )
            ],
          ),
          SizedBox(
            height: 20,
          ),
          const Padding(
            padding: EdgeInsets.all(15.0),
            child: Text(
              'Add on facilities',
              style: TextStyle(
                  fontSize: 20,
                  decoration: TextDecoration.none,
                  fontFamily: 'RobotoMono',
                  color: Colors.black,
                  fontWeight: FontWeight.w400),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(top: 20, left: 10, right: 10, bottom: 10),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      if (flg1 == 0) {
                        flg1 = 1;
                      } else {
                        flg1 = 0;
                      }
                    });
                  },
                  child: Container(
                    color: flg1 == 1 ? Color(0XffEE2417) : Color(0XffD8D8D8),
                    height: 28,
                    width: 28,
                    child: Center(
                      child: flg1 == 1 ? Image.asset('assets/tick.png') : null,
                    ),
                  ),
                ),
                const Padding(
                  padding:
                      EdgeInsets.only(left: 15, top: 8, right: 8, bottom: 8),
                  child: Text(
                    'Doctors on board',
                    style: TextStyle(
                        fontSize: 15,
                        decoration: TextDecoration.none,
                        fontFamily: 'RobotoMono',
                        color: Colors.black,
                        fontWeight: FontWeight.w400),
                  ),
                ),
                SizedBox(
                  width: 150,
                ),
                const Text(
                  '599/-',
                  style: TextStyle(
                      fontSize: 15,
                      decoration: TextDecoration.none,
                      fontFamily: 'RobotoMono',
                      color: Colors.red,
                      fontWeight: FontWeight.w400),
                ),
              ],
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(top: 0, left: 10, right: 10, bottom: 10),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      if (flg2 == 0) {
                        flg2 = 1;
                      } else {
                        flg2 = 0;
                      }
                    });
                  },
                  child: Container(
                    color: flg2 == 1 ? Color(0XffEE2417) : Color(0XffD8D8D8),
                    height: 28,
                    width: 28,
                    child: flg2 == 1 ? Image.asset('assets/tick.png') : null,
                  ),
                ),
                const Padding(
                  padding:
                      EdgeInsets.only(left: 15, top: 8, right: 8, bottom: 8),
                  child: Text(
                    'Doctors on board',
                    style: TextStyle(
                        fontSize: 15,
                        decoration: TextDecoration.none,
                        fontFamily: 'RobotoMono',
                        color: Colors.black,
                        fontWeight: FontWeight.w400),
                  ),
                ),
                SizedBox(
                  width: 150,
                ),
                Text(
                  '599/-',
                  style: TextStyle(
                      fontSize: 15,
                      decoration: TextDecoration.none,
                      fontFamily: 'RobotoMono',
                      color: Colors.red,
                      fontWeight: FontWeight.w400),
                ),
              ],
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(top: 0, left: 10, right: 10, bottom: 10),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      if (flg3 == 0) {
                        flg3 = 1;
                      } else {
                        flg3 = 0;
                      }
                    });
                  },
                  child: Container(
                    color: flg3 == 1 ? Color(0XffEE2417) : Color(0XffD8D8D8),
                    height: 28,
                    width: 28,
                    child: flg3 == 1 ? Image.asset('assets/tick.png') : null,
                  ),
                ),
                const Padding(
                  padding:
                      EdgeInsets.only(left: 15, top: 8, right: 8, bottom: 8),
                  child: Text(
                    'Doctors on board',
                    style: TextStyle(
                        fontSize: 15,
                        decoration: TextDecoration.none,
                        fontFamily: 'RobotoMono',
                        color: Colors.black,
                        fontWeight: FontWeight.w400),
                  ),
                ),
                SizedBox(
                  width: 150,
                ),
                Text(
                  '599/-',
                  style: TextStyle(
                      fontSize: 15,
                      decoration: TextDecoration.none,
                      fontFamily: 'RobotoMono',
                      color: Colors.red,
                      fontWeight: FontWeight.w400),
                ),
              ],
            ),
          ),
          Padding(
              padding: EdgeInsets.only(left: 20, right: 20, top: 30),
              child: GestureDetector(
                onTap: widget.booknow,
                child: Material(
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15.0))),
                  elevation: 5,
                  child: Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      color: Color(0XffEE2417),
                    ),
                    height: 50,
                    child: const Center(
                      child: Text(
                        'Book now',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
