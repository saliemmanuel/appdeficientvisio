import 'dart:convert';

class LeconModels {
  final String? id;
  final String? intitule;
  final String? resumer;
  final String? competence;
  final String? contenue;
  final String? idEnseignant;

  LeconModels({
    required this.id,
    this.intitule,
    this.resumer,
    this.competence,
    this.contenue,
    required this.idEnseignant,
  });

  LeconModels copyWith({
    String? id,
    String? intitule,
    String? resumer,
    String? competence,
    String? contenue,
    String? idEnseignant,
  }) {
    return LeconModels(
      id: id ?? this.id,
      intitule: intitule ?? this.intitule,
      resumer: resumer ?? this.resumer,
      competence: competence ?? this.competence,
      contenue: contenue ?? this.contenue,
      idEnseignant: idEnseignant ?? this.idEnseignant,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'intitule': intitule,
      'resumer': resumer,
      'competence': competence,
      'contenue': contenue,
      'idEnseignant': idEnseignant,
    };
  }

  factory LeconModels.fromMap(Map<String, dynamic> map) {
    return LeconModels(
      id: map['id'] != null ? map['id'] as String : null,
      intitule: map['intitule'] != null ? map['intitule'] as String : null,
      resumer: map['resumer'] != null ? map['resumer'] as String : null,
      competence:
          map['competence'] != null ? map['competence'] as String : null,
      contenue: map['contenue'] != null ? map['contenue'] as String : null,
      idEnseignant:
          map['idEnseignant'] != null ? map['idEnseignant'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory LeconModels.fromJson(String source) =>
      LeconModels.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'LeconModels(intitule: $intitule, resumer: $resumer, competence: $competence, contenue: $contenue)';
  }

  @override
  bool operator ==(covariant LeconModels other) {
    if (identical(this, other)) return true;

    return other.intitule == intitule &&
        other.resumer == resumer &&
        other.competence == competence &&
        other.contenue == contenue;
  }

  @override
  int get hashCode {
    return intitule.hashCode ^
        resumer.hashCode ^
        competence.hashCode ^
        contenue.hashCode;
  }
}
