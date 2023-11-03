class Servico {

  final int id;
  final String descricao;
  final double valor;
  final bool eAtivo;

  Servico({this.id, this.descricao, this.valor, this.eAtivo});

  factory Servico.fromJson(Map<String, dynamic> json){

    Servico servico = Servico(
      id: json["id"],
      descricao: json["descricao"],
      valor: json["valor"],
      eAtivo: json["e_ativo"],
    );

    return servico;
  }
}