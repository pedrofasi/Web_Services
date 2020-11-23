class Pessoa {
  int id;
  String nome;
  String cep;
  String cpf;
  String data_nasc;
  String divida;

  Pessoa( {this.id, this.nome, this.cep, this.cpf,
           this.data_nasc, this.divida});

  Pessoa.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nome = json['nome'];
    cep = json['cep'];
    cpf = json['cpf'];
    data_nasc = json['data_nasc'];
    divida = json['divida'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nome'] = this.nome;
    data['cep'] = this.cep;
    data['cpf'] = this.cpf;
    data['data_nasc'] = this.data_nasc;
    data['divida'] = this.divida;
    return data;
  }
}