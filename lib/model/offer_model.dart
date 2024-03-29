class OfferModel {
  String? id;
  String? idCreateur;
  String? titre;
  String? dateStart;
  String? description;
  String? from;
  String? to;
  String? montant;
  String? photo;
  String? carName;
  String? vitesseMax;

  OfferModel(
      {this.id,
      this.idCreateur,
      this.titre,
      this.dateStart,
      this.description,
      this.from,
      this.to,
      this.montant,
      this.photo,
      this.carName,
      this.vitesseMax});

  OfferModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idCreateur = json['idCreateur'];
    titre = json['title'];
    dateStart = json['date'];
    description = json['description'];
    from = json['from'];
    to = json['to'];
    montant = json['montant'];
    photo = json['photo'];
    carName = json['carName'];
    vitesseMax = json['vitesseMax'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['idCreateur'] = idCreateur;
    data['title'] = titre;
    data['date'] = dateStart;
    data['description'] = description;
    data['from'] = from;
    data['to'] = to;
    data['montant'] = montant;
    data['photo'] = photo;
    data['carName'] = carName;
    data['vitesseMax'] = vitesseMax;
    return data;
  }
}
