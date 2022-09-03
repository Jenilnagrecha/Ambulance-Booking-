import 'package:flutter/material.dart';
import 'package:siren24/Models/history_model.dart';
import 'package:siren24/state/api_calling.dart';
import 'package:location_geocoder/location_geocoder.dart';

class History extends StatefulWidget {
  const History({Key? key}) : super(key: key);
  static String id = 'history';
  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    Future<String?> Getaddress(double lat, double lng) async {
      const _apiKey = "AIzaSyASODipwXRfzJNuFRN8lCaQeMnxLXSOvgQ";
      final LocatitonGeocoder geocoder = LocatitonGeocoder(_apiKey);
      final address =
          await geocoder.findAddressesFromCoordinates(Coordinates(lat, lng));
      print(address.first.addressLine);
      String? str = address.first.addressLine;
      String? finalstr = str!.substring(8, str.length);
      return finalstr;
    }

    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                height: 250,
                width: width,
                color: Color(0Xff4C6EE5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 40,
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.chevron_left,
                        color: Colors.white,
                        size: 40,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'History',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Container(
            color: Colors.transparent,
            margin: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: Column(
              children: [
                SizedBox(
                  height: 155,
                ),
                Expanded(
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0),
                    ),
                    child: FutureBuilder<List<HistoryModel>>(
                      future: ApiCaller().GetHistory(),
                      builder: (
                        BuildContext context,
                        AsyncSnapshot<List<HistoryModel>> snapshot,
                      ) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        } else if (snapshot.connectionState ==
                            ConnectionState.done) {
                          if (snapshot.hasError) {
                            return const Text('Error');
                          } else if (snapshot.hasData) {
                            List<HistoryModel>? data = snapshot.data;

                            return ListView.builder(
                              itemCount: data!.length,
                              itemBuilder: (context, index) => Card(
                                margin: const EdgeInsets.symmetric(
                                  vertical: 10,
                                ),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10.0, vertical: 15.0),
                                      child: Row(
                                        children: [
                                          Column(
                                            children: [
                                              Icon(
                                                Icons.radio_button_checked,
                                                color: Color(0Xff4C6EE5),
                                              ),
                                              Image.asset(
                                                'assets/verticle.png',
                                                height: 25,
                                                color: Colors.black,
                                              ),
                                              Image.asset(
                                                  'assets/destination.png'),
                                            ],
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              FutureBuilder(
                                                future: Getaddress(
                                                    data[index].source!.lat
                                                        as double,
                                                    data[index].source!.lng
                                                        as double),
                                                builder: (context,
                                                    AsyncSnapshot<String?>
                                                        snapshot) {
                                                  if (snapshot.hasError)
                                                    return Text(
                                                        '${snapshot.error}');
                                                  if (snapshot.hasData)
                                                    return Text(
                                                      snapshot.data.toString(),
                                                      style: TextStyle(
                                                          fontSize: 15.0),
                                                    );

                                                  return const CircularProgressIndicator();
                                                },
                                              ),
                                              SizedBox(
                                                height: 30,
                                              ),
                                              FutureBuilder(
                                                future: Getaddress(
                                                    data[index].destination!.lat
                                                        as double,
                                                    data[index].destination!.lng
                                                        as double),
                                                builder: (context,
                                                    AsyncSnapshot<String?>
                                                        snapshot) {
                                                  if (snapshot.hasError)
                                                    return Text(
                                                        '${snapshot.error}');
                                                  if (snapshot.hasData)
                                                    return Text(
                                                      snapshot.data.toString(),
                                                      style: TextStyle(
                                                          fontSize: 15.0),
                                                    );

                                                  return const CircularProgressIndicator();
                                                },
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    Divider(),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10.0, vertical: 10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Image.asset('assets/money-1.png'),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                data[index]
                                                    .orderAmount
                                                    .toString(),
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 17.0,
                                                ),
                                              ),
                                            ],
                                          ),
                                          InkWell(
                                            onTap: () {},
                                            child: Row(
                                              children: [
                                                Text(
                                                  data[index]
                                                      .orderStatus
                                                      .toString(),
                                                  style: TextStyle(
                                                      fontSize: 16.0,
                                                      color: Color(0xFF4252FF),
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          } else {
                            return const Text('Empty data');
                          }
                        } else {
                          return Text('State: ${snapshot.connectionState}');
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
