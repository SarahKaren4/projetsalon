class Depense {
  int _id;
  String _usage;
  String _cout;
  String _dateajout;
  Depense(this._usage, this._cout, this._dateajout);

  Depense.map(dynamic obj) {
    this._id = obj['id'];
    this._usage = obj['usage'];
    this._cout = obj['cout'];
    this._dateajout = obj['dateajout'];

  }

  int get id => _id;
  String get usage => _usage;
  String get cout => _cout;
  String get dateajout => _dateajout;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    if (_id != null) {
      map['id'] = _id;
    }
    map['usage'] = _usage;
    map['cout'] = _cout;
    map['dateajout'] = _dateajout;

    return map;
  }

  Depense.fromMap(Map<String, dynamic> map) {
    this._id = map['id'];
    this._usage = map['usage'];
    this._cout = map['cout'];
    this._dateajout = map['dateajout'];

  }
}
