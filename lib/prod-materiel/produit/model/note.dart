class Produit {
  int _id;
  String _nom;
  String _qte;
  String _details;
  String _prixachat;
  String _prixvente;
  String _dateajoutprod;
  String _nomfournisseur;
  String _statut;
  Produit(this._nom, this._qte, this._details, this._prixachat, this._prixvente, this._dateajoutprod,this._statut,this._nomfournisseur);

  Produit.map(dynamic obj) {
    this._id = obj['id'];
    this._nom = obj['nom'];
    this._qte = obj['qte'];
    this._details = obj['details'];
     this._prixachat = obj['prixachat'];
    this._prixvente = obj['prixvente'];
    this._dateajoutprod = obj['dateajoutprod'];
    this._statut = obj['statut'];
    this._nomfournisseur = obj['nomfournisseur'];

  }

  int get id => _id;
  String get nom => _nom;
  String get qte => _qte;
  String get details => _details;
  String get prixachat => _prixachat;
  String get prixvente => _prixvente;
  String get dateajoutprod => _dateajoutprod;
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
    map['prixvente'] = _prixvente;
    map['dateajoutprod'] = _dateajoutprod;
    map['statut'] = _statut;
    map['nomfournisseur'] = _nomfournisseur;

    return map;
  }

  Produit.fromMap(Map<String, dynamic> map) {
    this._id = map['id'];
    this._nom = map['nom'];
    this._qte = map['qte'];
    this._details = map['details'];
    this._prixachat = map['prixachat'];
    this._prixvente = map['prixvente'];
    this._dateajoutprod = map['dateajoutprod'];
    this._statut = map['statut'];
    this._nomfournisseur = map['nomfournisseur'];


  }
}
