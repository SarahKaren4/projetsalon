class Client {
  int _id;
  String _nom;
  String _numclient;
  String dateajoutclient;

  Client(this._nom, this._numclient,this.dateajoutclient);

  Client.map(dynamic obj) {
    this._id = obj['id'];
    this._nom = obj['nom'];
    this._numclient = obj['numclient'];
    this.dateajoutclient = obj['dateajoutclient'];

  }

  int get id => _id;
  String get nom => _nom;
  String get numclient => _numclient;
  String get dateajoutprod => dateajoutclient;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    if (_id != null) {
      map['id'] = _id;
    }
    map['nom'] = _nom;
    map['numclient'] = _numclient;
    map['dateajoutclient'] = dateajoutclient;

    return map;
  }

  Client.fromMap(Map<String, dynamic> map) {
    this._id = map['id'];
    this._nom = map['nom'];
    this._numclient = map['numclient'];
    this.dateajoutclient = map['dateajoutclient'];

  }
}
