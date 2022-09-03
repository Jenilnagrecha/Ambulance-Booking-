import 'package:flutter/material.dart';
import 'package:siren24/state/api_calling.dart';
import 'package:smooth_star_rating_null_safety/smooth_star_rating_null_safety.dart';

class RatingScreen extends StatefulWidget {
  static String id = 'rating';
  RatingScreen({Key? key}) : super(key: key);

  @override
  State<RatingScreen> createState() => _RatingScreenState();
}

class _RatingScreenState extends State<RatingScreen> {
  final TextEditingController reviewcontroller = TextEditingController();
  var rating = 0.0;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
            height: height,
            width: width,
            color: Color(0xFF4C6EE5),
            child: Center(
              child: Column(
                children: [
                  Expanded(child: SizedBox()),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(
                            Icons.chevron_left,
                            size: 40,
                            color: Colors.white,
                          ),
                        ),
                        Expanded(child: SizedBox()),
                        Padding(
                          padding: const EdgeInsets.only(right: 20),
                          child: Text(
                            'Rating',
                            style: TextStyle(fontSize: 24, color: Colors.white),
                          ),
                        ),
                        Expanded(child: SizedBox()),
                      ],
                    ),
                  ),
                  Expanded(child: SizedBox()),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 35),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(15),
                          ),
                          color: Colors.white),
                      height: height * 0.68,
                      width: width - 35,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 40,
                          ),
                          Text(
                            'How was your trip?',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                            ),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          Text(
                            'Your feedback will help improve\ndriving experience',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          SmoothStarRating(
                            rating: rating,
                            size: 65,
                            allowHalfRating: false,
                            filledIconData: Icons.star,
                            halfFilledIconData: Icons.star_half,
                            defaultIconData: Icons.star_border,
                            starCount: 5,
                            spacing: 2.0,
                            onRatingChanged: (value) {
                              setState(() {
                                rating = value;
                              });
                            },
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          Container(
                            width: width - 70,
                            child: TextFormField(
                              controller: reviewcontroller,
                              minLines: 5,
                              maxLines: 20,
                              keyboardType: TextInputType.multiline,
                              decoration: InputDecoration(
                                hintText: 'Additional comments',
                                hintStyle: TextStyle(color: Colors.grey),
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20.0)),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 15.0),
                            color: Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GestureDetector(
                                onTap: () {
                                  ApiCaller()
                                      .ReviewSystem(
                                          reviewcontroller.text, rating.toInt())
                                      .whenComplete(() {
                                    final snackBar = SnackBar(
                                      content: const Text(
                                          'Thanks for your feedback!'),
                                      action: SnackBarAction(
                                        label: 'Undo',
                                        onPressed: () {
                                          // Some code to undo the change.
                                        },
                                      ),
                                    );

                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar);
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(15),
                                    ),
                                    color: Color(0xFF4252FF),
                                  ),
                                  height: 50,
                                  child: Center(
                                    child: Text(
                                      'Submit review',
                                      style: TextStyle(
                                          fontSize: 19,
                                          color: Colors.white,
                                          fontFamily: 'Roboto',
                                          wordSpacing: 2,
                                          decoration: TextDecoration.none,
                                          fontWeight: FontWeight.w300),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
