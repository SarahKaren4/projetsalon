class Note {
  int _id;
  String _nom;
  String _qte;
  String _details;
  String _prixachat;
  String _dateajout;

  Note(this._nom, this._qte, this._details, this._prixachat, this._dateajout);

  Note.map(dynamic obj) {
    this._id = obj['id'];
    this._nom = obj['nom'];
    this._qte = obj['qte'];
    this._details = obj['details'];
     this._prixachat = obj['prixachat'];
    this._dateajout = obj['dateajout'];

  }

  int get id => _id;
  String get nom => _nom;
  String get qte => _qte;
  String get details => _details;
  String get prixachat => _prixachat;
  String get dateajout => _dateajout;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    if (_id != null) {
      map['id'] = _id;
    }
    map['nom'] = _nom;
    map['qte'] = _qte;
    map['details'] = _details;
    map['prixachat'] = _prixachat;
    map['dateajout'] = _dateajout;

    return map;
  }

  Note.fromMap(Map<String, dynamic> map) {
    this._id = map['id'];
    this._nom = map['nom'];
    this._qte = map['qte'];
    this._details = map['details'];
    this._prixachat = map['prixachat'];
    this._dateajout = map['dateajout'];

  }
}
