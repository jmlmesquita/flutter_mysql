import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddProduct extends StatefulWidget {
  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {

  TextEditingController productController =  TextEditingController();
  TextEditingController descController = TextEditingController();

  void addProduc(){
    var url= "http://senac.leofabris.com.br/addProduct.php";

    http.post(url,body:{
      "productName": productController.text,
      "productDesc": descController.text,
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Adicionar Produto"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                TextField(
                  controller: productController,
                  decoration: InputDecoration(
                    hintText: "Digite o nome do Produto",
                    labelText: "Nome do Produto",
                  ),
                ),
                TextField(
                  controller: descController,
                  decoration: InputDecoration(
                    hintText: "Digite a Descrição do Produto",
                    labelText: "Descrição do Produto",
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                ),
                RaisedButton(
                  child: Text("Adicionar Produto"),
                  color: Colors.blue,
                  onPressed:() {
                    addProduc();
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
