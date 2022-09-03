import 'package:bottom_sheet/bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:siren24/Models/addons_list.dart';
import '../my-globals.dart' as globals;
import 'package:siren24/state/api_calling.dart';

class AddOnList extends StatefulWidget {
  final FlexibleDraggableScrollableSheetScrollController addoncontroller;
  final VoidCallback addnext;
  final String ambid;
  AddOnList(
      {required this.addoncontroller,
      required this.addnext,
      required this.ambid,
      Key? key})
      : super(key: key);

  @override
  State<AddOnList> createState() => _AddOnListState();
}

class _AddOnListState extends State<AddOnList> {
  List<Color> addcolor = [];
  List<String> addonname = [];
  Color clr = Colors.white;
  int sel = 0;
  bool _value = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          ),
          color: Colors.white),
      child: ListView(
        children: [
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Select add on facilities',
              style: TextStyle(
                  fontSize: 15,
                  fontFamily: 'Roboto',
                  decoration: TextDecoration.none,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
          ),
          FutureBuilder<List<AddonDetails>>(
            future: ApiCaller().FetchAddons(),
            builder: (
              BuildContext context,
              snapshot,
            ) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return const Text('Error');
                } else if (snapshot.hasData) {
                  for (var i = 1; i <= snapshot.data!.length; i++) {
                    addcolor.add(Colors.white);
                  }
                 
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    itemCount: snapshot.data!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        children: [
                          Container(
                            height: 66,
                            color: Colors.white,
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 10, right: 10),
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    if (addcolor[index] == Colors.white) {
                                      addcolor[index] =
                                          Color(0xff4C6EE5).withOpacity(0.5);
                                      addonname
                                          .add(snapshot.data![index].name!);
                                      globals.addons = addonname;
                                      
                                    } else {
                                      addcolor[index] = Colors.white;
                                      addonname
                                          .remove(snapshot.data![index].name!);
                                    }
                                  });
                                },
                                child: Container(
                                  color: addcolor[index],
                                  child: Row(
                                    children: [
                                      Text(
                                        snapshot.data![index].name!,
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontFamily: 'Roboto',
                                            decoration: TextDecoration.none,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w400),
                                      ),
                                      Expanded(child: SizedBox()),
                                      Text(
                                          snapshot.data![index].price!
                                              .toString(),
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontFamily: 'Roboto',
                                              decoration: TextDecoration.none,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 10.0, right: 10.0),
                            child: Divider(
                              height: 2,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      );
                    },
                  );
                } else {
                  return const Text('Empty data');
                }
              } else {
                return Text('State: ${snapshot.connectionState}');
              }
            },
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Expanded(
                child: SizedBox(),
              ),
              Text(
                addonname.length.toString(),
                style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'Roboto',
                    decoration: TextDecoration.none,
                    color: Colors.black,
                    fontWeight: FontWeight.w400),
              ),
              Text(
                '  items selected',
                style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'Roboto',
                    decoration: TextDecoration.none,
                    color: Colors.black,
                    fontWeight: FontWeight.w400),
              ),
              GestureDetector(
                onTap: widget.addnext,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    width: 164,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                      color: Color(0XFF4C6EE5),
                    ),
                    child: Center(
                      child: Text(
                        'Next',
                        style: TextStyle(
                            fontSize: 18,
                            fontFamily: 'Roboto',
                            decoration: TextDecoration.none,
                            color: Colors.white,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
