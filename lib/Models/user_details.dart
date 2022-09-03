class GetProfileDetails {
  final String? profileImg;
  final String? aadharCard;
  final String? voterId;
  final String? panCard;
  final String? drivingLicence;
  final int? rating;
  final String? id;
  final int? phoneno;
  final String? createdat;
  final int? islocked;
  final int? isactive;
  final dynamic otp;
  final dynamic temptoken;
  final int? usertype;
  final int? v;
  final String? authtoken;
  final double? lat;
  final double? lng;
  final int? coin;
  final int? age;
  final String? gender;
  final String? address;
  final String? name;
  final String? dob;
  final String? referralCode;

  GetProfileDetails({
    this.profileImg,
    this.aadharCard,
    this.voterId,
    this.panCard,
    this.drivingLicence,
    this.rating,
    this.id,
    this.phoneno,
    this.createdat,
    this.islocked,
    this.isactive,
    this.otp,
    this.temptoken,
    this.usertype,
    this.v,
    this.authtoken,
    this.lat,
    this.lng,
    this.coin,
    this.age,
    this.gender,
    this.address,
    this.name,
    this.dob,
    this.referralCode,
  });

  GetProfileDetails.fromJson(Map<String, dynamic> json)
    : profileImg = json['profile_img'] as String?,
      aadharCard = json['aadhar_card'] as String?,
      voterId = json['voter_id'] as String?,
      panCard = json['pan_card'] as String?,
      drivingLicence = json['driving_licence'] as String?,
      rating = json['rating'] as int?,
      id = json['_id'] as String?,
      phoneno = json['phoneno'] as int?,
      createdat = json['createdat'] as String?,
      islocked = json['islocked'] as int?,
      isactive = json['isactive'] as int?,
      otp = json['otp'],
      temptoken = json['temptoken'],
      usertype = json['usertype'] as int?,
      v = json['__v'] as int?,
      authtoken = json['authtoken'] as String?,
      lat = json['lat'] as double?,
      lng = json['lng'] as double?,
      coin = json['coin'] as int?,
      age = json['age'] as int?,
      gender = json['gender'] as String?,
      address = json['address'] as String?,
      name = json['name'] as String?,
      dob = json['dob'] as String?,
      referralCode = json['referral_code'] as String?;

  Map<String, dynamic> toJson() => {
    'profile_img' : profileImg,
    'aadhar_card' : aadharCard,
    'voter_id' : voterId,
    'pan_card' : panCard,
    'driving_licence' : drivingLicence,
    'rating' : rating,
    '_id' : id,
    'phoneno' : phoneno,
    'createdat' : createdat,
    'islocked' : islocked,
    'isactive' : isactive,
    'otp' : otp,
    'temptoken' : temptoken,
    'usertype' : usertype,
    '__v' : v,
    'authtoken' : authtoken,
    'lat' : lat,
    'lng' : lng,
    'coin' : coin,
    'age' : age,
    'gender' : gender,
    'address' : address,
    'name' : name,
    'dob' : dob,
    'referral_code' : referralCode
  };
}