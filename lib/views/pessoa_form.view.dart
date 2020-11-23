
import 'package:app_web_papi/controllers/pessoa.controller.dart';
import 'package:app_web_papi/models/pessoa.model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PessoaFormView extends StatefulWidget {

  final Pessoa pessoa;

  PessoaFormView({this.pessoa});

  @override
  _PessoaFormViewState createState() => _PessoaFormViewState();
}

class _PessoaFormViewState extends State<PessoaFormView> {

  final _tId = TextEditingController();
  final _tNome = TextEditingController();
  final _tCep = TextEditingController();
  final _tcpf = TextEditingController();
  final _tdatanasci = TextEditingController();
  final _tdivida = TextEditingController();

  var _formKey = GlobalKey<FormState>();

  bool _isEdited = false;
  Pessoa _pessoa;

  @override
  void initState() {
    super.initState();

    if (widget.pessoa == null) {
      _pessoa = Pessoa();
      _isEdited = false;
    } else {
      _pessoa = widget.pessoa;
      _isEdited = true;
      _tId.text = _pessoa.id.toString();
      _tNome.text = _pessoa.nome;
      _tCep.text = _pessoa.cep;
      _tcpf.text = _pessoa.cpf;
      _tdatanasci.text = _pessoa.data_nasc;
      _tdivida.text = _pessoa.divida;
    }
  }

  // PROCEDIMENTO PARA VALIDAR OS CAMPOS
  _validate(String text, String field) {
    if (text.isEmpty) {
      return "Digite $field";
    }
    return null;
  }

  // Widget EditText
  _editText(String field, TextEditingController controller, TextInputType type) {
    return TextFormField(
      controller: controller,
      validator: (s) => _validate(s, field),
      keyboardType: type,
      decoration: InputDecoration(
        labelText: field,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    final _controller = Provider.of<PessoaController>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Pessoa"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
          padding: EdgeInsets.all(30.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                _editText("Nome", _tNome,TextInputType.text),
                _editText("CPF", _tcpf,TextInputType.number),
                _editText("CEP", _tCep,TextInputType.number),
                _editText("Data de Nascimento", _tdatanasci,TextInputType.datetime),
                _editText("Dívida", _tdivida,TextInputType.number),
                Container(
                  margin: EdgeInsets.only(top: 10.0, bottom: 20),
                  height: 45,
                  child: RaisedButton(
                    color: Colors.blue,
                    child: Text(
                      "Salvar",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                      ),
                    ),
                    onPressed: () {
                      if (_formKey.currentState.validate()) {

                        _pessoa.nome = _tNome.text;
                        _pessoa.cep = _tCep.text;
                        _pessoa.cpf = _tcpf.text;
                        _pessoa.data_nasc = _tdatanasci.text;
                        _pessoa.divida = _tdivida.text;

                        if(_isEdited){
                          _controller.edit(_pessoa);
                        }else{
                          _pessoa.id = 0;
                          _controller.create(_pessoa);
                        }
                        Navigator.pop(context);
                      }
                    },
                  ),
                ),
                if(_isEdited)
                  Container(
                    margin: EdgeInsets.only(top: 5.0, bottom: 5),
                    height: 45,
                    child: RaisedButton(
                      color: Colors.red,
                      child: Text(
                        "Remover",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                        ),
                      ),
                      onPressed: () {
                        if (_formKey.currentState.validate()){

                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              // return object of type Dialog
                              return AlertDialog(
                                title: new Text("Exclusão de Registro"),
                                content: new Text("Tem certeza que deseja excluir este registro?"),
                                actions: <Widget>[
                                  // usually buttons at the bottom of the dialog
                                  FlatButton(
                                    child: new Text("Cancelar"),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  FlatButton(
                                    child: new Text("Excluir"),
                                    onPressed: () {
                                      _controller.delete(_pessoa.id);
                                      Navigator.of(context).pop();
                                      Navigator.pop(context);
                                    },
                                  ),
                                ],
                              );
                            },
                          );

                        }
                      },
                    ),
                  ),
              ],
            ),
          )),
    );
  }
}