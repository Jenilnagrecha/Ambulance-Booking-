class RequestOtp {
/*
{
  "token": "2q3tQ9eNkE8Hgc2zkSGmHoE2ZxMxKpKGMhanUD9HTo19",
  "otp": 613449
} 
*/

  late String? token;
  late int otp;

  RequestOtp({
    required this.token,
    required this.otp,
  });
  RequestOtp.fromJson(Map<String, dynamic> json) {
    token = json['token']?.toString();
    otp = json['otp'].toInt();
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['token'] = token;
    data['otp'] = otp;
    return data;
  }
}
