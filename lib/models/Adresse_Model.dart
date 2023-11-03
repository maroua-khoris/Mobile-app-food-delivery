class AdresseModel{
  late int? _id;
  late String _adressType;
  late String? _contactPersonName;
  late String? _contactPersonNumber;
  late String _adresse;
  late String _latitude;
  late String _longtitude;

AdresseModel({
    id,
  required adresseType,
  contactPersonName,
  contactPersonNumber,
  adresse,
  latitude,
  longtitude
}){_id=id;
  _adressType=adresseType;
  _contactPersonName=contactPersonName;
  _contactPersonNumber=contactPersonNumber;
  _adresse=adresse;
  _latitude=latitude;
  _longtitude=longtitude;
  }

  String get adresse=>_adresse;
  String get adresseType=>_adressType;
  String? get contactPersonName=>_contactPersonName;
  String? get contactPersonNumber=>_contactPersonNumber;
  String get latitude=>_latitude;
  String get longitude=>_longtitude;

  AdresseModel.fromJson(Map<String, dynamic> json){
    _id=json["id"];
    _adressType=json["address_type"]??"";
    _contactPersonNumber=json["contact_person_number"]??"";
    _contactPersonName=json["contact_person_name"]??"";
    _adresse=json["address"];
    _latitude=json["latitude"];
    _longtitude=json["longitude"];
  }
  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data =Map<String, dynamic>();
    data['id']=this._id;
    data['address_type']=this._adressType;
    data['contact_person_number']=this._contactPersonNumber;
    data['contact_person_name']=this._contactPersonName;
    data['address']=this._adresse;
    data['latitude']=this._latitude;
    data['longitude']=this._longtitude;
    return data;
  }

}