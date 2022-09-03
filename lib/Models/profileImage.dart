import 'package:flutter/cupertino.dart';

class ImageResponse {
  ImageResponse({
    required this.message,
    required this.url,
  });
  late final String message;
  late final String url;

  ImageResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['message'] = message;
    _data['url'] = url;
    return _data;
  }
}
