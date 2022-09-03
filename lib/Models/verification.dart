class Verify {
  late String authtoken;
  late String userid;

  Verify({required this.authtoken, required this.userid});

  Verify.fromJson(Map<String, dynamic> json) {
    authtoken = json['authtoken'];
    userid = json['userid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['authtoken'] = this.authtoken;
    data['userid'] = this.userid;
    return data;
  }
}
