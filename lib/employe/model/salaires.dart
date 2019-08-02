class Salaire {
  int _id;
  String _idSalaire;
  String _moispaye;
  String _salaire;
  String _datepaiement;
  Salaire(this._idSalaire, this._moispaye, this._salaire, this._datepaiement);

  Salaire.map(dynamic obj) {
    this._id = obj['id'];
    this._idSalaire = obj['idSalaire'];
    this._moispaye = obj['moispaye'];
    this._salaire = obj['salaire'];
    this._datepaiement = obj['datepaiement'];

  }

  int get id => _id;
  String get idSalaire => _idSalaire;
  String get moispaye => _moispaye;
  String get datepaiement => _datepaiement;
  String get salaire => _salaire;
  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    if (_id != null) {
      map['id'] = _id;
    }
    map['idSalaire'] = _idSalaire;
    map['moispaye'] = _moispaye;
    map['datepaiement'] = _datepaiement;
    map['salaire'] = _salaire;

    return map;
  }

  Salaire.fromMap(Map<String, dynamic> map) {
    this._id = map['id'];
    this._idSalaire = map['idSalaire'];
    this._moispaye = map['moispaye'];
    this._salaire = map['salaire'];
    this._datepaiement = map['datepaiement'];

  }
}
