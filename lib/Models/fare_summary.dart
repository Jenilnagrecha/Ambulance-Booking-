class FareKiSummary {
  final String? driverName;
  final int? driverPhoneno;
  final int? driverRating;
  final String? driverImg;
  final int? totalPrice;
  final int? addons;
  final int? price;
  final String? driverid;
  final String? carNo;
  final String? type;

  FareKiSummary({
    this.driverName,
    this.driverPhoneno,
    this.driverRating,
    this.driverImg,
    this.totalPrice,
    this.addons,
    this.price,
    this.driverid,
    this.carNo,
    this.type,
  });

  FareKiSummary.fromJson(Map<String, dynamic> json)
    : driverName = json['driver_name'] as String?,
      driverPhoneno = json['driver_phoneno'] as int?,
      driverRating = json['driver_rating'] as int?,
      driverImg = json['driver_img'] as String?,
      totalPrice = json['total_price'] as int?,
      addons = json['addons'] as int?,
      price = json['price'] as int?,
      driverid = json['driverid'] as String?,
      carNo = json['car_no'] as String?,
      type = json['type'] as String?;

  Map<String, dynamic> toJson() => {
    'driver_name' : driverName,
    'driver_phoneno' : driverPhoneno,
    'driver_rating' : driverRating,
    'driver_img' : driverImg,
    'total_price' : totalPrice,
    'addons' : addons,
    'price' : price,
    'driverid' : driverid,
    'car_no' : carNo,
    'type' : type
  };
}