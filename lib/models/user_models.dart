import 'dart:convert';

class Users {
  final String? id;
  final String? nomPrenom;
  final String? email;
  final String? matricule;
  final String? statut;
  Users({
    required this.id,
    this.nomPrenom,
    this.email,
    this.matricule,
    this.statut,
  });

  Users copyWith({
    String? id,
    String? nomPrenom,
    String? email,
    String? matricule,
    String? statut,
  }) {
    return Users(
      id: id ?? this.id,
      nomPrenom: nomPrenom ?? this.nomPrenom,
      email: email ?? this.email,
      matricule: matricule ?? this.matricule,
      statut: statut ?? this.statut,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'nomPrenom': nomPrenom,
      'email': email,
      'matricule': matricule,
      'statut': statut,
    };
  }

  factory Users.fromMap(Map<String, dynamic> map) {
    return Users(
      id: map['id'] != null ? map['id'] as String : null,
      nomPrenom: map['nomPrenom'] != null ? map['nomPrenom'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      matricule: map['matricule'] != null ? map['matricule'] as String : null,
      statut: map['statut'] != null ? map['statut'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Users.fromJson(String source) =>
      Users.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Users(id: $id, nomPrenom: $nomPrenom, email: $email, matricule: $matricule, statut: $statut)';
  }

  @override
  bool operator ==(covariant Users other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.nomPrenom == nomPrenom &&
        other.email == email &&
        other.matricule == matricule &&
        other.statut == statut;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        nomPrenom.hashCode ^
        email.hashCode ^
        matricule.hashCode ^
        statut.hashCode;
  }
}
