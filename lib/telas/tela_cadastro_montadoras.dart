import 'package:flutter/material.dart';
import '../componentes/drawer_personalisado.dart';
import '../componentes/montadora_item_lista.dart';
import '../models/montadora.dart';

import '../providers/montadoras.dart';
import '../utils/rotas.dart';
import 'package:provider/provider.dart';

class TelaCadastroMontadora extends StatefulWidget {
  @override
  _TelaCadastroMontadoraState createState() => _TelaCadastroMontadoraState();
}

class _TelaCadastroMontadoraState extends State<TelaCadastroMontadora> {
  bool _isLoading = false;
  Future<void> _atualizarLista(BuildContext context) {
    return Provider.of<MontadorasProvider>(context, listen: false)
        .buscaMontadoras();
  }

  @override
  void initState() {
    super.initState();
    Provider.of<MontadorasProvider>(context, listen: false)
        .buscaMontadoras()
        .then((_) {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final montadoras = Provider.of<MontadorasProvider>(context).getMontadoras;
    return Scaffold(
      appBar: AppBar(
        title: Text("Cadastro de Montadoras"),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(Rotas.FORM_MONTADORAS);
            },
          )
        ],
      ),
      drawer: DrawerPersonalisado(),
      //ENVOLVI O PADDING COM O REFRESHINDICATOR
      //ESTE WIDEGT ATUALIZARÁ NOSSA LISTA QUANDO "PUXAR PARA BAIXO"
      //CRIEI A FUNÇÃO PARA RETORNAR ISSO
      body: RefreshIndicator(
        onRefresh: () => _atualizarLista(context),
        child: Padding(
          padding: EdgeInsets.all(15),
          child: ListView.builder(
            itemCount: montadoras.length,
            itemBuilder: (ctx, i) => Column(
              children: [
                ItemListaMontadora(montadoras[i]),
                Divider(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
