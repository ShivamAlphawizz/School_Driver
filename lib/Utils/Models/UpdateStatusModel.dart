/// status : 1
/// msg : "Update Status Sucessfully"

class UpdateStatusModel {
  UpdateStatusModel({
      num? status, 
      String? msg,}){
    _status = status;
    _msg = msg;
}

  UpdateStatusModel.fromJson(dynamic json) {
    _status = json['status'];
    _msg = json['msg'];
  }
  num? _status;
  String? _msg;
UpdateStatusModel copyWith({  num? status,
  String? msg,
}) => UpdateStatusModel(  status: status ?? _status,
  msg: msg ?? _msg,
);
  num? get status => _status;
  String? get msg => _msg;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['msg'] = _msg;
    return map;
  }

}