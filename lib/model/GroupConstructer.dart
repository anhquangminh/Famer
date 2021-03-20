class Grourp{
  final String idgroup;
  final String namegroup;
  Grourp(this.idgroup, this.namegroup);
  Grourp.fromJson(Map json)
      : idgroup = json['id_group'],
        namegroup = json['name_group'];
  Map toJson() {
    return {
      'id_group': idgroup,
      'name_group': namegroup,
    };
  }
}