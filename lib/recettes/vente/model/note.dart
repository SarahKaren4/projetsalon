class Vente {
  int _id;
  String _nom;
  String _qte;
  String _prixvente;
  String _couttotal;
  String _dateachat;
  String _statut;
  Vente(this._nom, this._qte,  this._prixvente, this._couttotal, this._dateachat,this._statut);
  Vente.map(dynamic obj) {
    this._id = obj['id'];
    this._nom = obj['nom'];
    this._qte = obj['qte'];
    this._prixvente = obj['prixvente'];
    this._couttotal = obj['couttotal'];
    this._dateachat = obj['dateachat'];
    this._statut = obj['statut'];
  }

  int get id => _id;
  String get nom => _nom;
  String get qte => _qte;
  String get prixvente => _prixvente;
  String get couttotal => _couttotal;
  String get dateachat => _dateachat;
  String get statut => _statut;


  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    if (_id != null) {
      map['id'] = _id;
    }
    map['nom'] = _nom;
    map['qte'] = _qte;
    map['prixvente'] = _prixvente;
    map['couttotal'] = _couttotal;
    map['dateachat'] = _dateachat;
    map['statut'] = _statut;

    return map;
  }

  Vente.fromMap(Map<String, dynamic> map) {
    this._id = map['id'];
    this._nom = map['nom'];
    this._qte = map['qte'];
    this._prixvente = map['prixvente'];
    this._couttotal = map['couttotal'];
    this._dateachat = map['dateachat'];
    this._statut = map['statut'];

  }
}
