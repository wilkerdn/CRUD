import 'package:flutter/material.dart';
import '../models/montadora.dart';
import '../models/veiculos.dart';
import '../providers/montadoras.dart';
import '../utils/rotas.dart';
import 'package:provider/provider.dart';

class ItemListaVeiculo extends StatelessWidget {
  final Veiculos veiculo;

  ItemListaVeiculo(this.veiculo);

  void deleteVeiculo(context, Montadora montadora) {
    Provider.of<MontadorasProvider>(context, listen: false)
        .deleteMontadoras(montadora);
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.all(15),
      title: Container(
        child: Text(
          veiculo.modelo,
          style: TextStyle(color: Colors.black),
        ),
      ),
      trailing: Container(
        width: 100,
        child: Row(
          children: [
            Expanded(
              child: IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {
                  //AO CHAMAR O FORM PELO EDITAR ENVIO OS ARGUMENTOS
                  Navigator.of(context).pushNamed(
                    Rotas.FORM_VEICULOS,
                    arguments: veiculo,
                  );
                },
                color: Colors.grey,
              ),
            ),
            Expanded(
              child: IconButton(
                iconSize: 20,
                icon: Icon(Icons.delete),
                onPressed: () {
                  //VOU CRIAR UM AVISO PARA O USUÁRIO NÃO APAGAR SEM CONFIRMAR
                  showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      title: Text("ATENÇÃO"),
                      content: Text("Está certo disso?"),
                      actions: [
                        TextButton(
                            child: Text("Não"),
                            onPressed: () {
                              Navigator.of(context).pop();
                            }),
                        TextButton(
                            child: Text("Sim"),
                            onPressed: () {
                              //deleteVeiculo(context, veiculo);
                              Navigator.of(context).pop();
                            })
                      ],
                    ),
                  );
                },
                color: Colors.purple,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
