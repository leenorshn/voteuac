class Electeur {
  String matricule;
  String password;

  Electeur({this.matricule, this.password});

  Electeur.fromJson(Map<String, dynamic> json) {
    matricule = json['matricule'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['matricule'] = this.matricule;
    data['password'] = this.password;
    return data;
  }
}
