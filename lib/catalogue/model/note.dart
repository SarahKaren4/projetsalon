class CatalogueOff {
  int _id;
  String _nomprestation;
  String _categorie;
  String _image;

  CatalogueOff(this._nomprestation, this._categorie, this._image);

  CatalogueOff.map(dynamic obj) {
    this._id = obj['id'];
    this._nomprestation = obj['nomprestation'];
    this._categorie = obj['categorie'];
    this._image = obj['image'];
  }

  int get id => _id;
  String get nomprestation => _nomprestation;
  String get categorie => _categorie;
  String get image => _image;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    if (_id != null) {
      map['id'] = _id;
    }
    map['nomprestation'] = _nomprestation;
    map['categorie'] = _categorie;
    map['image'] = _image;

    return map;
  }

  CatalogueOff.fromMap(Map<String, dynamic> map) {
    this._id = map['id'];
    this._nomprestation = map['nomprestation'];
    this._categorie = map['categorie'];
    this._image = map['image'];

  }
}