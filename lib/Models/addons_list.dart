/* class AddedItems {
  AddedItems({
    required this.ambulance,
    required this.addons,
  });
  late final Ambulance ambulance;
  late final Addons addons;
  
  AddedItems.fromJson(Map<String, dynamic> json){
    ambulance = Ambulance.fromJson(json['ambulance']);
    addons = Addons.fromJson(json['addons']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['ambulance'] = ambulance.toJson();
    _data['addons'] = addons.toJson();
    return _data;
  }
}

class Ambulance {
  Ambulance({
    required this._id,
    required this.carNo,
    required this.driverid,
    required this.ownerid,
    required this.isactive,
    required this.type,
    required this.brand,
    required this.model,
    required this.addons,
    required this._V,
    required this.inservice,
    required this.lat,
    required this.lng,
  });
  late final String _id;
  late final String carNo;
  late final String driverid;
  late final String ownerid;
  late final int isactive;
  late final String type;
  late final String brand;
  late final String model;
  late final List<String> addons;
  late final int _V;
  late final bool inservice;
  late final double lat;
  late final double lng;
  
  Ambulance.fromJson(Map<String, dynamic> json){
    _id = json['_id'];
    carNo = json['car_no'];
    driverid = json['driverid'];
    ownerid = json['ownerid'];
    isactive = json['isactive'];
    type = json['type'];
    brand = json['brand'];
    model = json['model'];
    addons = List.castFrom<dynamic, String>(json['addons']);
    _V = json['__v'];
    inservice = json['inservice'];
    lat = json['lat'];
    lng = json['lng'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['_id'] = _id;
    _data['car_no'] = carNo;
    _data['driverid'] = driverid;
    _data['ownerid'] = ownerid;
    _data['isactive'] = isactive;
    _data['type'] = type;
    _data['brand'] = brand;
    _data['model'] = model;
    _data['addons'] = addons;
    _data['__v'] = _V;
    _data['inservice'] = inservice;
    _data['lat'] = lat;
    _data['lng'] = lng;
    return _data;
  }
}

class Addons {
  Addons({
    required this._id,
    required this.addons,
  });
  late final String _id;
  late final Addons addons;
  
  Addons.fromJson(Map<String, dynamic> json){
    _id = json['_id'];
    addons = Addons.fromJson(json['addons']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['_id'] = _id;
    _data['addons'] = addons.toJson();
    return _data;
  }
} */

class AddedItems {
  final Ambulance? ambulance;
  final Addons? addons;

  AddedItems({
    this.ambulance,
    this.addons,
  });

  AddedItems.fromJson(Map<String, dynamic> json)
    : ambulance = (json['ambulance'] as Map<String,dynamic>?) != null ? Ambulance.fromJson(json['ambulance'] as Map<String,dynamic>) : null,
      addons = (json['addons'] as Map<String,dynamic>?) != null ? Addons.fromJson(json['addons'] as Map<String,dynamic>) : null;

  Map<String, dynamic> toJson() => {
    'ambulance' : ambulance?.toJson(),
    'addons' : addons?.toJson()
  };
}

class Ambulance {
  final String? id;
  final String? carNo;
  final String? driverid;
  final String? ownerid;
  final int? isactive;
  final String? type;
  final String? brand;
  final String? model;
  final List<String>? addons;
  final int? v;
  final bool? inservice;
  final double? lat;
  final double? lng;

  Ambulance({
    this.id,
    this.carNo,
    this.driverid,
    this.ownerid,
    this.isactive,
    this.type,
    this.brand,
    this.model,
    this.addons,
    this.v,
    this.inservice,
    this.lat,
    this.lng,
  });

  Ambulance.fromJson(Map<String, dynamic> json)
    : id = json['_id'] as String?,
      carNo = json['car_no'] as String?,
      driverid = json['driverid'] as String?,
      ownerid = json['ownerid'] as String?,
      isactive = json['isactive'] as int?,
      type = json['type'] as String?,
      brand = json['brand'] as String?,
      model = json['model'] as String?,
      addons = (json['addons'] as List?)?.map((dynamic e) => e as String).toList(),
      v = json['__v'] as int?,
      inservice = json['inservice'] as bool?,
      lat = json['lat'] as double?,
      lng = json['lng'] as double?;

  Map<String, dynamic> toJson() => {
    '_id' : id,
    'car_no' : carNo,
    'driverid' : driverid,
    'ownerid' : ownerid,
    'isactive' : isactive,
    'type' : type,
    'brand' : brand,
    'model' : model,
    'addons' : addons,
    '__v' : v,
    'inservice' : inservice,
    'lat' : lat,
    'lng' : lng
  };
}

class Addons {
  final String? id;
  final Addonsfinal? addons;

  Addons({
    this.id,
    this.addons,
  });

  Addons.fromJson(Map<String, dynamic> json)
    : id = json['_id'] as String?,
      addons = (json['addons'] as Map<String,dynamic>?) != null ? Addonsfinal.fromJson(json['addons'] as Map<String,dynamic>) : null;

  Map<String, dynamic> toJson() => {
    '_id' : id,
    'addons' : addons?.toJson()
  };
}

class Addonsfinal {
  final Oxygen? oxygen;
  final ICU? iCU;

  Addonsfinal({
    this.oxygen,
    this.iCU,
  });

  Addonsfinal.fromJson(Map<String, dynamic> json)
    : oxygen = (json['oxygen'] as Map<String,dynamic>?) != null ? Oxygen.fromJson(json['oxygen'] as Map<String,dynamic>) : null,
      iCU = (json['ICU'] as Map<String,dynamic>?) != null ? ICU.fromJson(json['ICU'] as Map<String,dynamic>) : null;

  Map<String, dynamic> toJson() => {
    'oxygen' : oxygen?.toJson(),
    'ICU' : iCU?.toJson()
  };
}

class Oxygen {
  final bool? required;
  final int? price;

  Oxygen({
    this.required,
    this.price,
  });

  Oxygen.fromJson(Map<String, dynamic> json)
    : required = json['required'] as bool?,
      price = json['price'] as int?;

  Map<String, dynamic> toJson() => {
    'required' : required,
    'price' : price
  };
}

class ICU {
  final bool? required;
  final int? price;

  ICU({
    this.required,
    this.price,
  });

  ICU.fromJson(Map<String, dynamic> json)
    : required = json['required'] as bool?,
      price = json['price'] as int?;

  Map<String, dynamic> toJson() => {
    'required' : required,
    'price' : price
  };
}

class AddonDetails {
  final String? name;
  final bool? required;
  final int? price;

  AddonDetails({
    this.name,
    this.required,
    this.price,
  });

  AddonDetails.fromJson(Map<String, dynamic> json)
    : name = json['name'] as String?,
      required = json['required'] as bool?,
      price = json['price'] as int?;

  Map<String, dynamic> toJson() => {
    'name' : name,
    'required' : required,
    'price' : price
  };
}