class Note {
  int _id;
  String _nom;
  String _qte;
  String _details;
  String _prixachat;
  String _dateajoutmateriel;
  String _nomfournisseur;
  String _statut;
  Note(this._nom, this._qte, this._details, this._prixachat,this._dateajoutmateriel,this._statut,this._nomfournisseur);

  Note.map(dynamic obj) {
    this._id = obj['id'];
    this._nom = obj['nom'];
    this._qte = obj['qte'];
    this._details = obj['details'];
     this._prixachat = obj['prixachat'];
    this._dateajoutmateriel = obj['dateajoutmateriel'];
    this._statut = obj['statut'];
    this._nomfournisseur = obj['nomfournisseur'];

  }

  int get id => _id;
  String get nom => _nom;
  String get qte => _qte;
  String get details => _details;
  String get prixachat => _prixachat;
  String get dateajoutmateriel => _dateajoutmateriel;
  String get statut => _statut;
  String get nomfournisseur => _nomfournisseur;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    if (_id != null) {
      map['id'] = _id;
    }
    map['nom'] = _nom;
    map['qte'] = _qte;
    map['details'] = _details;
    map['prixachat'] = _prixachat;
    map['dateajoutmateriel'] = _dateajoutmateriel;
    map['statut'] = _statut;
    map['nomfournisseur'] = _nomfournisseur;

    return map;
  }

  Note.fromMap(Map<String, dynamic> map) {
    this._id = map['id'];
    this._nom = map['nom'];
    this._qte = map['qte'];
    this._details = map['details'];
    this._prixachat = map['prixachat'];
    this._dateajoutmateriel = map['dateajoutmateriel'];
    this._statut = map['statut'];
    this._nomfournisseur = map['nomfournisseur'];

  }
  }
