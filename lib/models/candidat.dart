class Candidat {
  String name;
  int numero;
  String matricule;
  String sloga;
  String id;
  String avatar;
  List<String> votes;

  Candidat(
      {this.name,
      this.numero,
      this.matricule,
      this.sloga,
      this.id,
      this.avatar,
      this.votes});

  Candidat.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    numero = json['numero'];
    matricule = json['matricule'];
    sloga = json['sloga'];
    id = json['id'];
    avatar = json['avatar'];
    votes = json['votes'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['numero'] = this.numero;
    data['matricule'] = this.matricule;
    data['sloga'] = this.sloga;
    data['id'] = this.id;
    data['avatar'] = this.avatar;
    data['votes'] = this.votes;
    return data;
  }
}
