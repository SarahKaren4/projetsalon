class Employee {
  int _id;
  String _nomemploye;
  String _fonction;
  String _salaire;
  String _dateajout;
  String _statut;
  Employee(this._nomemploye, this._fonction, this._salaire, this._dateajout, this._statut);

  Employee.map(dynamic obj) {
    this._id = obj['id'];
    this._nomemploye = obj['nomemploye'];
    this._fonction = obj['fonction'];
    this._salaire = obj['salaire'];
    this._dateajout = obj['dateajout'];
    this._statut = obj['statut'];

  }

  int get id => _id;
  String get nomemploye => _nomemploye;
  String get fonction => _fonction;
  String get salaire => _salaire;
  String get dateajout => _dateajout;
  String get statut => _statut;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    if (_id != null) {
      map['id'] = _id;
    }
    map['nomemploye'] = _nomemploye;
    map['fonction'] = _fonction;
    map['salaire'] = _salaire;
    map['dateajout'] = _dateajout;
    map['statut'] = _statut;


    return map;
  }

  Employee.fromMap(Map<String, dynamic> map) {
    this._id = map['id'];
    this._nomemploye = map['nomemploye'];
    this._fonction = map['fonction'];
    this._salaire = map['salaire'];
    this._dateajout = map['dateajout'];
    this._statut = map['statut'];


  }
}
