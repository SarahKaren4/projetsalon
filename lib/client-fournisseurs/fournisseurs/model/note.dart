class Fournisseurs {
  int _id;
  String _nomfournisseur;
  String _services;
  String _dateajoutfournisseur;
  Fournisseurs(this._nomfournisseur, this._services, this._dateajoutfournisseur);

  Fournisseurs.map(dynamic obj) {
    this._id = obj['id'];
    this._nomfournisseur = obj['nomfournisseur'];
    this._services = obj['services'];
    this._dateajoutfournisseur = obj['dateajoutfournisseur'];
  }

  int get id => _id;
  String get nomfournisseur => _nomfournisseur;
  String get services => _services;
  String get dateajoutfournisseur => _dateajoutfournisseur;
  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    if (_id != null) {
      map['id'] = _id;
    }
    map['nomfournisseur'] = _nomfournisseur;
    map['services'] = _services;
    map['dateajoutfournisseur'] = _dateajoutfournisseur;
    return map;
  }

  Fournisseurs.fromMap(Map<String, dynamic> map) {
    this._id = map['id'];
    this._nomfournisseur = map['nomfournisseur'];
    this._services = map['services'];
    this._dateajoutfournisseur = map['dateajoutfournisseur'];
  }
}
