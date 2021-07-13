import 'package:flutter/material.dart';
import '../componentes/drawer_personalisado.dart';
import '../componentes/montadora_item_lista.dart';
import '../componentes/veiculo_item_lista.dart';
import '../models/montadora.dart';
import '../models/veiculos.dart';

import '../providers/montadoras.dart';
import '../providers/veiculos.dart';
import '../utils/rotas.dart';
import 'package:provider/provider.dart';

class TelaCadastroVeiculo extends StatefulWidget {
  @override
  _TelaCadastroVeiculoState createState() => _TelaCadastroVeiculoState();
}

class _TelaCadastroVeiculoState extends State<TelaCadastroVeiculo> {
  bool _isLoading = false;
  Future<void> _atualizarLista(BuildContext context, Montadora montadora) {
    return Provider.of<MontadorasProvider>(context, listen: false)
        .buscaMontadoras();
  }

/*   @override
  void initState() {
     super.initState();
     Provider.of<VeiculosProvider>(context, listen: false)
         .buscaVeiculos(montadora)
         .then((_) {
       setState(() {
         _isLoading = false;
       });
     });
   } */

  @override
  Widget build(BuildContext context) {
    final montadora = ModalRoute.of(context).settings.arguments as Montadora;
    final veiculos = Provider.of<VeiculosProvider>(context).getMontadoras;
    Provider.of<VeiculosProvider>(context).buscaVeiculos(montadora);
    print(veiculos);
    return Scaffold(
      appBar: AppBar(
        title: Text("Veículos - ${montadora.nome}"),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(
                Rotas.FORM_VEICULOS,
                arguments: montadora,
              );
            },
          )
        ],
      ),
      drawer: DrawerPersonalisado(),
      //ENVOLVI O PADDING COM O REFRESHINDICATOR
      //ESTE WIDEGT ATUALIZARÁ NOSSA LISTA QUANDO "PUXAR PARA BAIXO"
      //CRIEI A FUNÇÃO PARA RETORNAR ISSO
      body: RefreshIndicator(
        onRefresh: () => _atualizarLista(context, montadora),
        child: Padding(
          padding: EdgeInsets.all(15),
          child: ListView.builder(
            itemCount: veiculos.length,
            itemBuilder: (ctx, i) => Column(
              children: [
                ItemListaVeiculo(veiculos[i]),
                Divider(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
