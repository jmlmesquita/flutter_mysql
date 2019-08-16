import 'package:flutter/material.dart';
import 'package:flutter_mysql/editproduct.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_mysql/main.dart';

class ProductDesc extends StatefulWidget {
  final List list;
  final int index;

  ProductDesc({this.list, this.index});

  @override
  _ProductDescState createState() => _ProductDescState();
}

class _ProductDescState extends State<ProductDesc> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("${widget.list[widget.index]['produto']}")),
      body: Container(
        padding: const EdgeInsets.all(18),
        child: Center(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 25),
              ),
              Text(
                widget.list[widget.index]['produto'],
                style: TextStyle(fontSize: 18),
              ),
              Text(
                "Descricao ${widget.list[widget.index]['descricao']}",
                style: TextStyle(fontSize: 18),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 25),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  RaisedButton(
                    child: Text("Editar"),
                    color: Colors.blue,
                    onPressed: () =>
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) =>
                              EditProduct(widget.list, widget.index),
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 25),
                  ),
                  RaisedButton(
                    child: Text("Excluir"),
                    color: Colors.red,
                    onPressed: () => confirmDeleteProduct(),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void deleteProduct(){
    var url="http://senac.leofabris.com.br/deleteProduct.php";
    http.post(url,body:{
      'id': widget.list[widget.index]['id']
    });
  }

  void confirmDeleteProduct(){
    AlertDialog alertDialog = new AlertDialog(
      content: Text("Tem certeza que deseja deletar '${widget.list[widget.index]['produto']}"),
      actions: <Widget>[
        RaisedButton(
          child: Text("Sim",style: TextStyle(color: Colors.black),),
          color:Colors.red,
          onPressed: (){
            deleteProduct();
            Navigator.of(context).push(
                MaterialPageRoute(builder: (BuildContext context) =>Home(),)
            );
          },
        ),
        RaisedButton(
          child: Text("Não",style: TextStyle(color: Colors.black),),
          color:Colors.blue,
          onPressed: () => Navigator.pop(context),
        ),
      ],
    );

    showDialog(context: context,child: alertDialog);
  }
}
