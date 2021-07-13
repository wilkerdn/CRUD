import 'package:flutter/material.dart';
import '../componentes/drawer_personalisado.dart';
import '../componentes/montadora_item_lista.dart';
import '../mockdata/montadoras.dart';
import '../providers/montadoras.dart';
import '../utils/rotas.dart';
import 'package:provider/provider.dart';

class TelaCadastroMontadora extends StatelessWidget {
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
      body: Padding(
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
    );
  }
}
