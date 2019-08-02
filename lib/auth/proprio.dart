class Proprio {
  int id_boutique;
  String _nom ;
  String _prenom;
  String _nomsalon;
  String _localisation;
  String _numero;
  String _mdp;
  String _lon;
  String _lat;
  String _dateajout;
  String _img;
  Proprio( this._nom, this._prenom, this._nomsalon, this._localisation, this._numero, this._mdp, this._lon, this._lat, this._dateajout, this._img);
    Proprio.map(dynamic obj){
      this._nom = obj['nom'];
      this._prenom = obj['prenom'];
      this._nomsalon = obj['nomsalon'];
      this._localisation = obj['localisation'];
      this._numero = obj['numero'];
      this._mdp = obj['mdp'];
      this._lon = obj['lon'];
      this._lat = obj['lat'];
      this._dateajout = obj['dateajout'];
      this._img = obj['img'];
      this.id_boutique  = obj['id_boutique'];

    }
  String get nom => _nom;
  String get prenom => _prenom;
  String get nomsalon => _nomsalon;
  String get localisation => _localisation;
  String get numero => _numero;
  String get mdp => _mdp;
  String get lon => _lon;
  String get lat => _lat;
  String get dateajout => _dateajout;
  String get img => _img;

  Map<String, dynamic> toMap()
  {
    var map = Map<String, dynamic>();
    map['nom'] = _nom;
    map['prenom'] = _prenom;
    map['nomsalon'] = _nomsalon;
    map['localisation'] = _localisation;
    map['numero'] = _numero;
    map['mdp'] = _mdp;
    map['lon'] = _lon;
    map['lat'] = _lat;
    map['dateajout'] = _dateajout;
    map['img'] = _img;
    return map;
  }
  void setProprioId(int id_boutique) {
    this.id_boutique = id_boutique;
  }
}



