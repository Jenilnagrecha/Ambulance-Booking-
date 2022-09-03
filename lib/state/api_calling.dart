import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'package:logger/logger.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:siren24/Models/addons_list.dart';
import 'package:siren24/Models/amblist.dart';
import 'package:siren24/Models/cancel_booking.dart';
import 'package:siren24/Models/fare_summary.dart';
import 'package:siren24/Models/history_model.dart';
import 'package:siren24/Models/otp.dart';
import 'package:siren24/Models/profileImage.dart';
import 'package:siren24/Models/user_details.dart';
import 'package:siren24/Models/verification.dart';
import 'package:siren24/Sheets/amb_list.dart';
import 'package:siren24/profile/history.dart';
import '../my-globals.dart' as globals;
import 'package:url_launcher/url_launcher.dart';
import 'package:dio/dio.dart' as dio;
import 'package:http/http.dart' as http;

@override
String authToken = " ";
String userid = " ";

String otpToken = "";
String tknnn = "";

class ApiCaller {
  late int otp;
  Future<void> sendOtpToPhone(int phone) async {
    final SharedPreferences SharedPrefrences =
        await SharedPreferences.getInstance();
    String? tkn = SharedPrefrences.getString('authtoken');
    if (tkn != null) {
      authToken = tkn;
    }

    var res = await post(
      Uri.parse('http://api.siren24.xyz/api/otp/sendotp'),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
      },
      body: jsonEncode({"phone": phone}),
    );
    handleError(res);

    Logger().d(res.body);
    var response = RequestOtp.fromJson(jsonDecode(res.body));
    otpToken = response.token!;
  }

  Future<void> verifyOtp(int otp) async {
    final SharedPreferences SharedPrefrences =
        await SharedPreferences.getInstance();

    String? tkn = SharedPrefrences.getString('authtoken');
    if (tkn != null) {
      authToken = tkn;
    }
    var res = await post(
      Uri.parse('http://api.siren24.xyz/api/otp/verifyotp'),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        "authtoken": otpToken,
      },
      body: jsonEncode({"otp": otp}),
    );

    if (res.statusCode >= 300) {
      throw Exception(jsonDecode(res.body)['message'] ?? "Unexpected error");
    } else {
      Logger().d(res.body);
      var response = Verify.fromJson(jsonDecode(res.body));
      final SharedPreferences SharedPrefrences =
          await SharedPreferences.getInstance();
      SharedPrefrences.setString("authtoken", response.authtoken);
      authToken = response.authtoken;
      SharedPrefrences.setString("userid", response.userid);
    }
  }

  Future<void> UserLocationUpdate(double lat, double lng) async {
    final SharedPreferences SharedPrefrences =
        await SharedPreferences.getInstance();

    String? tkn = SharedPrefrences.getString('authtoken');
    if (tkn != null) {
      authToken = tkn;
    }
    var res = await post(
      Uri.parse('http://api.siren24.xyz/api/location/update'),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        "authtoken": authToken,
      },
      body: jsonEncode({"lat": lat, "lng": lng}),
    );
    handleError(res);

    Logger().d(res.body);
  }

  Future<void> UserProfile(
      String name, String email, String birthdate, String gender) async {
    final SharedPreferences SharedPrefrences =
        await SharedPreferences.getInstance();

    String? tkn = SharedPrefrences.getString('authtoken');
    if (tkn != null) {
      authToken = tkn;
    }
    var res = await post(
      Uri.parse('http://api.siren24.xyz/api/profile/edit'),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        "authtoken": authToken,
      },
      body: jsonEncode(
          {"name": name, "address": email, "dob": birthdate, "gender": gender}),
    );
    handleError(res);

    Logger().d(res.body);
  }

  Future<GetProfileDetails> ProfileDetails() async {
    final SharedPreferences SharedPrefrences =
        await SharedPreferences.getInstance();

    String? tkn = SharedPrefrences.getString('authtoken');
    if (tkn != null) {
      authToken = tkn;
    }
    var response = await get(
      Uri.parse(
        'http://api.siren24.xyz/api/profile/view',
      ),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        "authtoken": authToken,
      },
    );
    if (response.statusCode >= 300) {
      throw Exception(
          jsonDecode(response.body)['message'] ?? "Unexpected error");
    }
    return GetProfileDetails.fromJson(jsonDecode(response.body));
  }

  Future<void> Logout() async {
    final SharedPreferences SharedPrefrences =
        await SharedPreferences.getInstance();

    String? tkn = SharedPrefrences.getString('authtoken');
    if (tkn != null) {
      authToken = tkn;
    }
    var response = await post(
      Uri.parse(
        'http://api.siren24.xyz/api/otp/logout',
      ),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        "authtoken": authToken,
      },
    );
    Logger().d(response.body);
    if (response.statusCode >= 300) {
      throw Exception(
          jsonDecode(response.body)['message'] ?? "Unexpected error");
    }
  }

  Future<void> launchPhoneDialer(String contactNumber) async {
    final SharedPreferences SharedPrefrences =
        await SharedPreferences.getInstance();

    String? tkn = SharedPrefrences.getString('authtoken');
    if (tkn != null) {
      authToken = tkn;
    }
    final Uri _phoneUri = Uri(scheme: "tel", path: contactNumber);
    try {
      if (await canLaunch(_phoneUri.toString()))
        await launch(_phoneUri.toString());
    } catch (error) {
      throw (error);
    }
  }

  launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url, forceWebView: true);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<List<AmbulancekiList>> FetchAmb(String als) async {
    final SharedPreferences SharedPrefrences =
        await SharedPreferences.getInstance();

    String? tkn = SharedPrefrences.getString('authtoken');
    if (tkn != null) {
      authToken = tkn;
    }
    tknnn = authToken;
    final response = await post(
      Uri.parse('http://api.siren24.xyz/api/ambulance/getambulancebytype'),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        "authtoken": authToken,
      },
      body: jsonEncode(
        {
          "type": als,
        },
      ),
    );

    if (response.statusCode == 200) {
      List temp = jsonDecode(response.body);
      return temp.map((e) => AmbulancekiList.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load jobs from API');
    }
  }

  Future<List<AddonDetails>> Getaddons(String ambid) async {
    final SharedPreferences SharedPrefrences =
        await SharedPreferences.getInstance();

    String? tkn = SharedPrefrences.getString('authtoken');
    if (tkn != null) {
      authToken = tkn;
    }
    print(authToken);
    final resposne = await post(
      Uri.parse('http://api.siren24.xyz/api/ambulance/getambulancebyid'),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        "authtoken": authToken,
      },
      body: jsonEncode({
        "ambulanceid": "61e2cc07628253c308ccbb14",
      }),
    );

    if (resposne.statusCode == 200) {
      var temp = jsonDecode(resposne.body);

      var addonnames =
          (temp["addons"]["addons"] as Map<String, dynamic>).keys.toList();
      var addlist = <AddonDetails>[];
      for (var i in addonnames) {
        addlist.add(AddonDetails(
          name: i,
          price: temp["addons"]["addons"][i]["price"],
          required: temp["addons"]["addons"][i]["required"],
        ));
      }
      return addlist;
    } else {
      throw Exception(resposne.statusCode);
    }
  }

  handleError(Response response) {
    if (response.statusCode >= 300) {
      throw Exception(
          jsonDecode(response.body)['message'] ?? "Unexpected error occurred");
    }
  }

  Future<FareKiSummary> GetFareSummary() async {
    final SharedPreferences SharedPrefrences =
        await SharedPreferences.getInstance();

    String? tkn = SharedPrefrences.getString('authtoken');
    if (tkn != null) {
      authToken = tkn;
    }
    final response = await post(
      Uri.parse('http://api.siren24.xyz/api/order/order/checkout'),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        "authtoken": authToken,
      },
      body: jsonEncode({
        "driverid": globals.driverid,
        "ambulanceid": globals.ambulanceid,
        "destination": {"lat": globals.currlat, "lng": globals.currentlng},
        "source": {"lat": globals.destilat, "lng": globals.destilng},
        "order_type": "later",
        "order_distance": globals.totaldistance,
        "order_date": 1644007252346,
        "addons": globals.addons,
      }),
    );
    if (response.statusCode == 200) {
      return FareKiSummary.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(response.statusCode);
    }
  }

  Future<List<HistoryModel>> GetHistory() async {
    final SharedPreferences SharedPrefrences =
        await SharedPreferences.getInstance();

    String? tkn = SharedPrefrences.getString('authtoken');
    if (tkn != null) {
      authToken = tkn;
    }

    final response = await post(
      Uri.parse('http://api.siren24.xyz/api/order/user/get'),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        "authtoken": authToken,
      },
      body: jsonEncode({"page": 1}),
    );
    if (response.statusCode == 200) {
      List temp = jsonDecode(response.body);
      return temp.map((e) => HistoryModel.fromJson(e)).toList();
    } else {
      throw Exception(response.statusCode);
    }
  }

  Future<void> ReviewSystem(String feedback, int rating) async {
    final SharedPreferences SharedPrefrences =
        await SharedPreferences.getInstance();

    String? tkn = SharedPrefrences.getString('authtoken');
    if (tkn != null) {
      authToken = tkn;
    }
    final response = await post(
      Uri.parse('http://api.siren24.xyz/api/feedback/add'),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        "authtoken": authToken,
      },
      body: jsonEncode({
        "feedback": feedback,
        "rating": rating,
      }),
    );
    if (response.statusCode == 200) {
      print(response);
    } else {
      throw Exception(response.statusCode);
    }
  }

  Future<CancelBooking> CancelOrder() async {
    final SharedPreferences SharedPrefrences =
        await SharedPreferences.getInstance();

    String? tkn = SharedPrefrences.getString('authtoken');
    if (tkn != null) {
      authToken = tkn;
    }
    final res = await post(
        Uri.parse('http://api.siren24.xyz/api/order/user/cencelbooking'),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          "authtoken": authToken,
        },
        body: jsonEncode({"orderid": "61fcba1effd2d17d49333038"}));

    if (res.statusCode == 200) {
      return CancelBooking.fromJson(jsonDecode(res.body));
    } else {
      throw Exception(res.statusCode);
    }
  }

/*   Future<ImageResponse> FileUpload(String filepath) async {
    final SharedPreferences SharedPrefrences =
        await SharedPreferences.getInstance();

    String? tkn = SharedPrefrences.getString('authtoken');
    if (tkn != null) {
      authToken = tkn;
    }
    var formData = dio.FormData.fromMap({
      'file': await dio.MultipartFile.fromFile(filepath),
      'Metadata': {"extension": ".jpg", "mimetype": "image/jpg"},
    });
    var res = await dio.Dio().postUri(
      Uri.parse(
          'https://8h43nvvxfd.execute-api.ap-south-1.amazonaws.com/Prod/api/upload_file'),
      data: formData,
      options: dio.Options(
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          "folder-name": "profileImages",
          "filename": "profile"
        },
        
      ),
    );

    // final res = await post(
    //     Uri.parse('http://api.siren24.xyz/api/order/user/cencelbooking'),
    //     headers: {
    //       HttpHeaders.contentTypeHeader: 'application/json',
    //       "authtoken": authToken,
    //     },
    //     body: jsonEncode({"orderid": "61fcba1effd2d17d49333038"}));

    if (res.statusCode == 200) {
      return ImageResponse.fromJson(jsonDecode(res.data));
    } else {
      throw Exception(res.statusCode);
    }
  } */
  /*  Future<ImageResponse> FileUpload(String file) async {
    var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            'https://8h43nvvxfd.execute-api.ap-south-1.amazonaws.com/Prod/api/upload_file'));

    request.files.add(await http.MultipartFile.fromPath("file", file));
    request.headers.addAll({
      HttpHeaders.contentTypeHeader: 'application/json',
      "folder-name": "profileImages",
      "filename": "profile"
    });
    var response = await request.send();
    var responseString = await response.stream.bytesToString();

    if (response.statusCode >= 300) {
      throw (response.statusCode);
    }

    return ImageResponse.fromJson(jsonDecode(responseString));
  } */

  Future<Map> fileUploader(String filename, File file, String extension) async {
    var res = await http.MultipartRequest(
        'POST',
        Uri.parse(
            'https://8h43nvvxfd.execute-api.ap-south-1.amazonaws.com/Prod/api/upload_file'));
    Map<String, String> headers = {
      'folder-name': 'FileUpload',
      'filename': filename.split(".").first
    };
    res.headers.addAll(headers);
    Map<String, String> metadata = {
      'extension': '.' + extension,
      'mimetype': 'image/' + extension
    };
    res.fields['Metadata'] = jsonEncode(metadata);
    res.files.add(await http.MultipartFile.fromPath(
      'file',
      file.path,
    ));
    print(res.fields['Metadata']);
    // res.files.add( await
    //     http.MultipartFile.fromBytes(
    //         'file',
    //         file,
    //         filename: filename
    //     )
    // );

    var response = await res.send();
    var answer = await http.Response.fromStream(response);
    Logger().d(answer.body);
    var finalresponse = jsonDecode(answer.body);
    return finalresponse;
  }

  Future<List<AddonDetails>> FetchAddons() async {
    final SharedPreferences SharedPrefrences =
        await SharedPreferences.getInstance();

    String? tkn = SharedPrefrences.getString('authtoken');
    if (tkn != null) {
      authToken = tkn;
    }
    final response = await post(
        Uri.parse('http://api.siren24.xyz/api/ambulance/getambulancebyid'),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          "authtoken": authToken,
        },
        body: jsonEncode(
          {"ambulanceid": globals.ambulanceid},
        ));
    if (response.statusCode == 200) {
      var temp = jsonDecode(response.body);

      var addonnames =
          (temp["addons"]["addons"] as Map<String, dynamic>).keys.toList();
      var addlist = <AddonDetails>[];
      for (var i in addonnames) {
        addlist.add(AddonDetails(
          name: i,
          price: temp["addons"]["addons"][i]["price"],
          required: temp["addons"]["addons"][i]["required"],
        ));
      }
      return addlist;
    } else {
      throw Exception(response.statusCode);
    }
  }

  Future<void> RatingSystem(String feedback, int rating) async {
    final SharedPreferences SharedPrefrences =
        await SharedPreferences.getInstance();

    String? tkn = SharedPrefrences.getString('authtoken');
    if (tkn != null) {
      authToken = tkn;
    }
    final response = await post(
      Uri.parse('http://api.siren24.xyz/api/feedback/add'),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        "authtoken": authToken,
      },
      body: jsonEncode({
        "feedback": feedback,
        "rating": rating,
      }),
    );
    if (response.statusCode == 200) {
    } else {
      throw Exception(response.statusCode);
    }
  }

  Future<void> BookNow() async {
    final SharedPreferences SharedPrefrences =
        await SharedPreferences.getInstance();

    String? tkn = SharedPrefrences.getString('authtoken');
    if (tkn != null) {
      authToken = tkn;
    }
    final response = await post(
      Uri.parse('http://api.siren24.xyz/api/order/create'),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        "authtoken": authToken,
      },
      body: jsonEncode({
        "driverid": globals.driverid,
        "ambulanceid": globals.ambulanceid,
        "destination": {"lat": globals.destilat, "lng": globals.destilng},
        "source": {"lat": globals.currentlng, "lng": 72.0000101},
        "order_type": "instant",
        "order_distance": globals.totaldistance,
        "order_date": 1644007252346
      }),
    );
    if (response.statusCode == 200) {
    } else {
      throw Exception(response.statusCode);
    }
  }

  Future<void> BookLater() async {
    final SharedPreferences SharedPrefrences =
        await SharedPreferences.getInstance();

    String? tkn = SharedPrefrences.getString('authtoken');
    if (tkn != null) {
      authToken = tkn;
    }
    final response = await post(
      Uri.parse('http://api.siren24.xyz/api/order/create'),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        "authtoken": authToken,
      },
      body: jsonEncode({
        "driverid": globals.driverid,
        "ambulanceid": globals.ambulanceid,
        "destination": {"lat": globals.destilat, "lng": globals.destilng},
        "source": {"lat": globals.currlat, "lng": globals.currentlng},
        "order_type": "later",
        "order_distance": globals.totaldistance,
        "order_date": 1644007252346
      }),
    );
    if (response.statusCode == 200) {
    } else {
      throw Exception(response.statusCode);
    }
  }
}
