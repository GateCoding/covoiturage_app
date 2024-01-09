class OfferModel {
  String? id;
  int? idCreateur;
  String? titre;
  DateTime? dateCreation;
  String? description;
  String? from;
  String? to;
  int? montant;
  String? photo;

  OfferModel(
      {this.id,
      this.idCreateur,
      this.titre,
      this.dateCreation,
      this.description,
      this.from,
      this.to,
      this.montant,
      this.photo});

  OfferModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idCreateur = json['idCreateur'];
    titre = json['titre'];
    dateCreation = json['dateCreation'];
    description = json['description'];
    from = json['from'];
    to = json['to'];
    montant = json['montant'];
    photo = json['photo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['idCreateur'] = idCreateur;
    data['titre'] = titre;
    data['dateCreation'] =
        dateCreation?.toIso8601String(); // Convert DateTime to string
    data['description'] = description;
    data['from'] = from;
    data['to'] = to;
    data['montant'] = montant;
    data['photo'] = photo;
    return data;
  }
}
