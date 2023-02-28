/// response_code : "1"
/// message : "Student Data Get Successfully"
/// status : "success"
/// data : [{"par_address":"Vijay Nagar, Indore, Madhya Pradesh 452010, India","id":"1","username":"Devika","email":"","countrycode":"","mobile":"","password":"","profile_pic":"63e4e74aad53c.jpg","facebook_id":"","type":"","occupation":"Teacher","birth_no":"FHGSAG8787877","add_class":"2","age":"5","relation":"Father","religion":"Hindu","dob":"2023-02-08","roll_no":"","division":"","emergency_no":"","blood":"","isGold":"0","school_id":"2","driver_id":"7","address":"","city":"","country":"","device_token":"","agreecheck":"0","otp":null,"status":"1","sex":"Girl","wallet":"0.00","oauth_provider":null,"oauth_uid":null,"last_login":null,"created_at":"2023-02-09 12:30:02","updated_at":"2023-02-09 12:31:23","refferal_code":"e-GATE492812","friend_code":"","parent_id":"10"},{"par_address":"Vijay Nagar, Indore, Madhya Pradesh 452010, India","id":"2","username":"dev ","email":"","countrycode":"","mobile":"","password":"","profile_pic":"63e4e842ce1f0.jpg","facebook_id":"","type":"","occupation":"Teacher","birth_no":"FHGSAG8787877","add_class":"2","age":"10","relation":"Father","religion":"Hindu","dob":"2023-02-14","roll_no":"","division":"","emergency_no":"","blood":"","isGold":"0","school_id":"2","driver_id":"7","address":"","city":"","country":"","device_token":"","agreecheck":"0","otp":null,"status":"1","sex":"Boy","wallet":"0.00","oauth_provider":null,"oauth_uid":null,"last_login":null,"created_at":"2023-02-09 12:34:10","updated_at":"2023-02-09 12:34:10","refferal_code":"e-GATE739540","friend_code":"","parent_id":"10"},{"par_address":"Vijay Nagar, Indore, Madhya Pradesh 452010, India","id":"8","username":"Raju","email":"","countrycode":"","mobile":"","password":"","profile_pic":"63e6161fe7726.png","facebook_id":"","type":"","occupation":"20","birth_no":"4988789","add_class":"20","age":"10","relation":"20","religion":"20","dob":"2023-02-10","roll_no":"","division":"","emergency_no":"","blood":"","isGold":"0","school_id":"2","driver_id":"7","address":"","city":"","country":"","device_token":"","agreecheck":"0","otp":null,"status":"1","sex":"Boy","wallet":"0.00","oauth_provider":null,"oauth_uid":null,"last_login":null,"created_at":"2023-02-10 10:02:07","updated_at":"2023-02-10 10:02:47","refferal_code":"e-GATE672983","friend_code":"","parent_id":"10"},{"par_address":"Vijay Nagar, Indore, Madhya Pradesh 452010, India","id":"9","username":"Raju","email":"","countrycode":"","mobile":"","password":"","profile_pic":"","facebook_id":"","type":"","occupation":"20","birth_no":" 4988789","add_class":"20","age":"10","relation":"20","religion":"20","dob":" 2023-02-10","roll_no":"","division":"","emergency_no":"","blood":"","isGold":"0","school_id":"2","driver_id":"7","address":"","city":"","country":"","device_token":"","agreecheck":"0","otp":null,"status":"1","sex":"Boy","wallet":"0.00","oauth_provider":null,"oauth_uid":null,"last_login":null,"created_at":"2023-02-10 10:09:16","updated_at":"2023-02-10 10:09:16","refferal_code":"e-GATE905040","friend_code":"","parent_id":"10"},{"par_address":"Vijay Nagar, Indore, Madhya Pradesh 452010, India","id":"11","username":"Raju","email":"","countrycode":"","mobile":"","password":"","profile_pic":"","facebook_id":"","type":"","occupation":"20","birth_no":"4988789","add_class":"20","age":"10","relation":"20","religion":"20","dob":"2023-02-10","roll_no":"","division":"","emergency_no":"","blood":"","isGold":"0","school_id":"2","driver_id":"7","address":"","city":"","country":"","device_token":"","agreecheck":"0","otp":null,"status":"1","sex":"Boy","wallet":"0.00","oauth_provider":null,"oauth_uid":null,"last_login":null,"created_at":"2023-02-10 10:13:36","updated_at":"2023-02-10 10:13:36","refferal_code":"e-GATE726917","friend_code":"","parent_id":"10"},{"par_address":"Vijay Nagar, Indore, Madhya Pradesh 452010, India","id":"12","username":"Raju","email":"","countrycode":"","mobile":"","password":"","profile_pic":"63e619c69a0d9.jpg","facebook_id":"","type":"","occupation":"20","birth_no":" 4988789","add_class":"20","age":"10","relation":"20","religion":"20","dob":" 2023-02-10","roll_no":"","division":"","emergency_no":"","blood":"","isGold":"0","school_id":"2","driver_id":"7","address":"","city":"","country":"","device_token":"","agreecheck":"0","otp":null,"status":"1","sex":"Boy","wallet":"0.00","oauth_provider":null,"oauth_uid":null,"last_login":null,"created_at":"2023-02-10 10:17:42","updated_at":"2023-02-10 10:17:42","refferal_code":"e-GATE923848","friend_code":"","parent_id":"10"},{"par_address":"Vijay Nagar, Indore, Madhya Pradesh 452010, India","id":"15","username":"Raju","email":"","countrycode":"","mobile":"","password":"","profile_pic":"","facebook_id":"","type":"","occupation":"20","birth_no":"4988789","add_class":"20","age":"10","relation":"20","religion":"20","dob":"2023-02-10","roll_no":"","division":"","emergency_no":"","blood":"","isGold":"0","school_id":"2","driver_id":"7","address":"","city":"","country":"","device_token":"","agreecheck":"0","otp":null,"status":"1","sex":"Boy","wallet":"0.00","oauth_provider":null,"oauth_uid":null,"last_login":null,"created_at":"2023-02-15 10:01:31","updated_at":"2023-02-15 10:01:31","refferal_code":"e-GATE467484","friend_code":"","parent_id":"10"}]

class StudentDetailsModel {
  StudentDetailsModel({
      String? responseCode, 
      String? message, 
      String? status, 
      List<Data>? data,}){
    _responseCode = responseCode;
    _message = message;
    _status = status;
    _data = data;
}

  StudentDetailsModel.fromJson(dynamic json) {
    _responseCode = json['response_code'];
    _message = json['message'];
    _status = json['status'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
  }
  String? _responseCode;
  String? _message;
  String? _status;
  List<Data>? _data;
StudentDetailsModel copyWith({  String? responseCode,
  String? message,
  String? status,
  List<Data>? data,
}) => StudentDetailsModel(  responseCode: responseCode ?? _responseCode,
  message: message ?? _message,
  status: status ?? _status,
  data: data ?? _data,
);
  String? get responseCode => _responseCode;
  String? get message => _message;
  String? get status => _status;
  List<Data>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['response_code'] = _responseCode;
    map['message'] = _message;
    map['status'] = _status;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// par_address : "Vijay Nagar, Indore, Madhya Pradesh 452010, India"
/// id : "1"
/// username : "Devika"
/// email : ""
/// countrycode : ""
/// mobile : ""
/// password : ""
/// profile_pic : "63e4e74aad53c.jpg"
/// facebook_id : ""
/// type : ""
/// occupation : "Teacher"
/// birth_no : "FHGSAG8787877"
/// add_class : "2"
/// age : "5"
/// relation : "Father"
/// religion : "Hindu"
/// dob : "2023-02-08"
/// roll_no : ""
/// division : ""
/// emergency_no : ""
/// blood : ""
/// isGold : "0"
/// school_id : "2"
/// driver_id : "7"
/// address : ""
/// city : ""
/// country : ""
/// device_token : ""
/// agreecheck : "0"
/// otp : null
/// status : "1"
/// sex : "Girl"
/// wallet : "0.00"
/// oauth_provider : null
/// oauth_uid : null
/// last_login : null
/// created_at : "2023-02-09 12:30:02"
/// updated_at : "2023-02-09 12:31:23"
/// refferal_code : "e-GATE492812"
/// friend_code : ""
/// parent_id : "10"

class Data {
  Data({
      String? parAddress, 
      String? id, 
      String? username, 
      String? email, 
      String? countrycode, 
      String? mobile, 
      String? password, 
      String? profilePic, 
      String? facebookId, 
      String? type, 
      String? occupation, 
      String? birthNo, 
      String? addClass, 
      String? age, 
      String? relation, 
      String? religion, 
      String? dob, 
      String? rollNo, 
      String? division, 
      String? emergencyNo, 
      String? blood, 
      String? isGold, 
      String? schoolId, 
      String? driverId, 
      String? address, 
      String? city, 
      String? country, 
      String? deviceToken, 
      String? agreecheck, 
      dynamic otp, 
      String? status, 
      String? sex, 
      String? wallet, 
      dynamic oauthProvider, 
      dynamic oauthUid, 
      dynamic lastLogin, 
      String? createdAt, 
      String? updatedAt, 
      String? refferalCode, 
      String? friendCode, 
      String? parentId,}){
    _parAddress = parAddress;
    _id = id;
    _username = username;
    _email = email;
    _countrycode = countrycode;
    _mobile = mobile;
    _password = password;
    _profilePic = profilePic;
    _facebookId = facebookId;
    _type = type;
    _occupation = occupation;
    _birthNo = birthNo;
    _addClass = addClass;
    _age = age;
    _relation = relation;
    _religion = religion;
    _dob = dob;
    _rollNo = rollNo;
    _division = division;
    _emergencyNo = emergencyNo;
    _blood = blood;
    _isGold = isGold;
    _schoolId = schoolId;
    _driverId = driverId;
    _address = address;
    _city = city;
    _country = country;
    _deviceToken = deviceToken;
    _agreecheck = agreecheck;
    _otp = otp;
    _status = status;
    _sex = sex;
    _wallet = wallet;
    _oauthProvider = oauthProvider;
    _oauthUid = oauthUid;
    _lastLogin = lastLogin;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _refferalCode = refferalCode;
    _friendCode = friendCode;
    _parentId = parentId;
}

  Data.fromJson(dynamic json) {
    _parAddress = json['par_address'];
    _id = json['id'];
    _username = json['username'];
    _email = json['email'];
    _countrycode = json['countrycode'];
    _mobile = json['mobile'];
    _password = json['password'];
    _profilePic = json['profile_pic'];
    _facebookId = json['facebook_id'];
    _type = json['type'];
    _occupation = json['occupation'];
    _birthNo = json['birth_no'];
    _addClass = json['add_class'];
    _age = json['age'];
    _relation = json['relation'];
    _religion = json['religion'];
    _dob = json['dob'];
    _rollNo = json['roll_no'];
    _division = json['division'];
    _emergencyNo = json['emergency_no'];
    _blood = json['blood'];
    _isGold = json['isGold'];
    _schoolId = json['school_id'];
    _driverId = json['driver_id'];
    _address = json['address'];
    _city = json['city'];
    _country = json['country'];
    _deviceToken = json['device_token'];
    _agreecheck = json['agreecheck'];
    _otp = json['otp'];
    _status = json['status'];
    _sex = json['sex'];
    _wallet = json['wallet'];
    _oauthProvider = json['oauth_provider'];
    _oauthUid = json['oauth_uid'];
    _lastLogin = json['last_login'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _refferalCode = json['refferal_code'];
    _friendCode = json['friend_code'];
    _parentId = json['parent_id'];
  }
  String? _parAddress;
  String? _id;
  String? _username;
  String? _email;
  String? _countrycode;
  String? _mobile;
  String? _password;
  String? _profilePic;
  String? _facebookId;
  String? _type;
  String? _occupation;
  String? _birthNo;
  String? _addClass;
  String? _age;
  String? _relation;
  String? _religion;
  String? _dob;
  String? _rollNo;
  String? _division;
  String? _emergencyNo;
  String? _blood;
  String? _isGold;
  String? _schoolId;
  String? _driverId;
  String? _address;
  String? _city;
  String? _country;
  String? _deviceToken;
  String? _agreecheck;
  dynamic _otp;
  String? _status;
  String? _sex;
  String? _wallet;
  dynamic _oauthProvider;
  dynamic _oauthUid;
  dynamic _lastLogin;
  String? _createdAt;
  String? _updatedAt;
  String? _refferalCode;
  String? _friendCode;
  String? _parentId;
Data copyWith({  String? parAddress,
  String? id,
  String? username,
  String? email,
  String? countrycode,
  String? mobile,
  String? password,
  String? profilePic,
  String? facebookId,
  String? type,
  String? occupation,
  String? birthNo,
  String? addClass,
  String? age,
  String? relation,
  String? religion,
  String? dob,
  String? rollNo,
  String? division,
  String? emergencyNo,
  String? blood,
  String? isGold,
  String? schoolId,
  String? driverId,
  String? address,
  String? city,
  String? country,
  String? deviceToken,
  String? agreecheck,
  dynamic otp,
  String? status,
  String? sex,
  String? wallet,
  dynamic oauthProvider,
  dynamic oauthUid,
  dynamic lastLogin,
  String? createdAt,
  String? updatedAt,
  String? refferalCode,
  String? friendCode,
  String? parentId,
}) => Data(  parAddress: parAddress ?? _parAddress,
  id: id ?? _id,
  username: username ?? _username,
  email: email ?? _email,
  countrycode: countrycode ?? _countrycode,
  mobile: mobile ?? _mobile,
  password: password ?? _password,
  profilePic: profilePic ?? _profilePic,
  facebookId: facebookId ?? _facebookId,
  type: type ?? _type,
  occupation: occupation ?? _occupation,
  birthNo: birthNo ?? _birthNo,
  addClass: addClass ?? _addClass,
  age: age ?? _age,
  relation: relation ?? _relation,
  religion: religion ?? _religion,
  dob: dob ?? _dob,
  rollNo: rollNo ?? _rollNo,
  division: division ?? _division,
  emergencyNo: emergencyNo ?? _emergencyNo,
  blood: blood ?? _blood,
  isGold: isGold ?? _isGold,
  schoolId: schoolId ?? _schoolId,
  driverId: driverId ?? _driverId,
  address: address ?? _address,
  city: city ?? _city,
  country: country ?? _country,
  deviceToken: deviceToken ?? _deviceToken,
  agreecheck: agreecheck ?? _agreecheck,
  otp: otp ?? _otp,
  status: status ?? _status,
  sex: sex ?? _sex,
  wallet: wallet ?? _wallet,
  oauthProvider: oauthProvider ?? _oauthProvider,
  oauthUid: oauthUid ?? _oauthUid,
  lastLogin: lastLogin ?? _lastLogin,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
  refferalCode: refferalCode ?? _refferalCode,
  friendCode: friendCode ?? _friendCode,
  parentId: parentId ?? _parentId,
);
  String? get parAddress => _parAddress;
  String? get id => _id;
  String? get username => _username;
  String? get email => _email;
  String? get countrycode => _countrycode;
  String? get mobile => _mobile;
  String? get password => _password;
  String? get profilePic => _profilePic;
  String? get facebookId => _facebookId;
  String? get type => _type;
  String? get occupation => _occupation;
  String? get birthNo => _birthNo;
  String? get addClass => _addClass;
  String? get age => _age;
  String? get relation => _relation;
  String? get religion => _religion;
  String? get dob => _dob;
  String? get rollNo => _rollNo;
  String? get division => _division;
  String? get emergencyNo => _emergencyNo;
  String? get blood => _blood;
  String? get isGold => _isGold;
  String? get schoolId => _schoolId;
  String? get driverId => _driverId;
  String? get address => _address;
  String? get city => _city;
  String? get country => _country;
  String? get deviceToken => _deviceToken;
  String? get agreecheck => _agreecheck;
  dynamic get otp => _otp;
  String? get status => _status;
  String? get sex => _sex;
  String? get wallet => _wallet;
  dynamic get oauthProvider => _oauthProvider;
  dynamic get oauthUid => _oauthUid;
  dynamic get lastLogin => _lastLogin;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  String? get refferalCode => _refferalCode;
  String? get friendCode => _friendCode;
  String? get parentId => _parentId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['par_address'] = _parAddress;
    map['id'] = _id;
    map['username'] = _username;
    map['email'] = _email;
    map['countrycode'] = _countrycode;
    map['mobile'] = _mobile;
    map['password'] = _password;
    map['profile_pic'] = _profilePic;
    map['facebook_id'] = _facebookId;
    map['type'] = _type;
    map['occupation'] = _occupation;
    map['birth_no'] = _birthNo;
    map['add_class'] = _addClass;
    map['age'] = _age;
    map['relation'] = _relation;
    map['religion'] = _religion;
    map['dob'] = _dob;
    map['roll_no'] = _rollNo;
    map['division'] = _division;
    map['emergency_no'] = _emergencyNo;
    map['blood'] = _blood;
    map['isGold'] = _isGold;
    map['school_id'] = _schoolId;
    map['driver_id'] = _driverId;
    map['address'] = _address;
    map['city'] = _city;
    map['country'] = _country;
    map['device_token'] = _deviceToken;
    map['agreecheck'] = _agreecheck;
    map['otp'] = _otp;
    map['status'] = _status;
    map['sex'] = _sex;
    map['wallet'] = _wallet;
    map['oauth_provider'] = _oauthProvider;
    map['oauth_uid'] = _oauthUid;
    map['last_login'] = _lastLogin;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['refferal_code'] = _refferalCode;
    map['friend_code'] = _friendCode;
    map['parent_id'] = _parentId;
    return map;
  }

}