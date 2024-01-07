class OfferListModel {
  int? id;
  int? idCreateur;
  String? titre;
  String? dateCreation;
  String? dateDebut;
  String? dateFin;
  String? description;
  String? adresse;
  int? montant;
  bool? status;
  String? photo;

  OfferListModel(
      {this.id,
      this.idCreateur,
      this.titre,
      this.dateCreation,
      this.dateDebut,
      this.dateFin,
      this.description,
      this.adresse,
      this.montant,
      this.status,
      this.photo});

  OfferListModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idCreateur = json['id_createur'];
    titre = json['titre'];
    dateCreation = json['dateCreation'];
    dateDebut = json['dateDebut'];
    dateFin = json['dateFin'];
    description = json['description'];
    adresse = json['adresse'];
    montant = json['montant'];
    status = json['status'];
    photo = json['photo'];
  }

  Map<String, dynamic> toJson() {
  final Map<String, dynamic> data = <String, dynamic>{};
  data['id'] = id;
  data['id_createur'] = idCreateur;
  data['titre'] = titre;
  data['dateCreation'] = dateCreation; // Convert DateTime to string
  data['dateDebut'] = dateDebut; // Convert DateTime to string
  data['dateFin'] = dateFin; // Convert DateTime to string
  data['description'] = description;
  data['adresse'] = adresse;
  data['montant'] = montant;
  data['status'] = status;
  data['photo'] = photo;
  return data;
}


  
}
