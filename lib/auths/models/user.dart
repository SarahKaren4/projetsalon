class User {
  String _username;
  String _nomsalon;
  String _localisation;
  String _numero;
  String _password;
  String _lon;
  String _lat;
  String _img;

  int _id;

  User(this._username, this._password, this._nomsalon,this._localisation, this._numero, this._lon, this._lat, this._img);

  User.map(dynamic obj) {
    this._username = obj['username'];
    this._password = obj['password'];
    this._nomsalon = obj['nomsalon'];
    this._localisation = obj['localisation'];
    this._numero = obj['numero'];
    this._lon = obj['lon'];
    this._lat = obj['lat'];
    this._img = obj['img'];
    this._id  = obj['id'];
  }

  String get username => _username;
  String get password => _password;
  String get nomsalon => _nomsalon;
  String get localisation => _localisation;
  String get numero => _numero;
  String get lon => _lon;
  String get lat => _lat;
  String get img => _img;



  int get id => _id;
  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["username"] = _username;
    map["password"] = _password;
    map["nomsalon"] = _nomsalon;
    map["localisation"] = _localisation;
    map["numero"] = _numero;
    map["lon"] = _lon;
    map["lat"] = _lat;
    map["img"] = _img;

    return map;
  }
    User.fromMap(Map<String, dynamic> map) {
  this._username =map['username'];
    this._password =map['password'];
    this._nomsalon =map['nomsalon'];
    this._localisation =map['localisation'];
    this._numero =map['numero'];
    this._lon =map['lon'];
    this._lat =map['lat'];
    this._img =map['img'];
    this._id  =map['id'];
  }
}
