class AmbulancekiList {
  String? sId;
  String? carNo;
  String? driverid;
  String? ownerid;
  int? isactive;
  String? type;
  String? brand;
  late String model;
  List<String>? addons;
  int? iV;
  bool? inservice;
  double? lat;
  double? lng;

  AmbulancekiList(
      {this.sId,
      this.carNo,
      this.driverid,
      this.ownerid,
      this.isactive,
      this.type,
      this.brand,
      required this.model,
      this.addons,
      this.iV,
      this.inservice,
      this.lat,
      this.lng});

  AmbulancekiList.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    carNo = json['car_no'];
    driverid = json['driverid'];
    ownerid = json['ownerid'];
    isactive = json['isactive'];
    type = json['type'];
    brand = json['brand'];
    model = json['model'];
    addons = json['addons'].cast<String>();
    iV = json['__v'];
    inservice = json['inservice'];
    lat = json['lat'];
    lng = json['lng'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['car_no'] = this.carNo;
    data['driverid'] = this.driverid;
    data['ownerid'] = this.ownerid;
    data['isactive'] = this.isactive;
    data['type'] = this.type;
    data['brand'] = this.brand;
    data['model'] = this.model;
    data['addons'] = this.addons;
    data['__v'] = this.iV;
    data['inservice'] = this.inservice;
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    return data;
  }
}
