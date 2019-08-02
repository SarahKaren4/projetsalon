class Prestation {
  int _id;
  String _nomprestation;
  String _nomclient;
  String _cout;
  String _numclient;
    String _avance;
  String _reste;

  String _dateprestation;

  String _statut;

  Prestation(this._nomprestation, this._nomclient, this._cout, this._numclient,this._avance,this._reste,this._dateprestation,this._statut);

 Prestation.map(dynamic obj) {
    this._id = obj['id'];
    this._nomprestation = obj['nomprestation'];
    this._nomclient = obj['nomclient'];
    this._cout = obj['cout'];
    this._dateprestation = obj['dateprestation'];
    this._numclient = obj['numclient'];
    this._reste = obj['reste'];
    this._avance = obj['avance'];
    this._statut = obj['statut'];


 }

  int get id => _id;
  String get nomprestation => _nomprestation;
  String get nomclient => _nomclient;
  String get cout => _cout;
    String get dateprestation => _dateprestation;
    String get numclient => _numclient;
 String get avance => _avance;
    String get reste => _reste;
  String get statut => _statut;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    if (_id != null) {
      map['id'] = _id;
    }
    map['nomprestation'] = _nomprestation;
    map['nomclient'] = _nomclient;
    map['cout'] = _cout;
    map['dateprestation'] = _dateprestation;
    map['numclient'] = _numclient;
map['avance'] = _avance;
    map['reste'] = _reste;
    map['statut'] = _statut;

    return map;
  }

 Prestation.fromMap(Map<String, dynamic> map) {
    this._id = map['id'];
    this._nomprestation = map['nomprestation'];
    this._nomclient = map['nomclient'];
    this._cout = map['cout'];
    this._dateprestation = map['dateprestation'];
    this._numclient = map['numclient'];

    this._avance = map['avance'];
    this._reste = map['reste'];
    this._statut = map['statut'];

  }
}
