import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_mysql/main.dart';

class EditProduct extends StatefulWidget {
  final List list;
  final int index;

  EditProduct(this.list, this.index);

  @override
  _EditProductState createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  TextEditingController productController;

  TextEditingController descController;

  void editProduc() {
    var  id = widget.list[widget.index]['id'];
    var url = "http://senac.leofabris.com.br/editProduct.php";
    http.post(url, body: {
      "productId": id.toString(),
      "productName": productController.text,
      "productDesc": descController.text
    });
  }

  @override
  void initState() {
    //listando os dados do produto
    productController =
        TextEditingController(text: widget.list[widget.index]['produto']);
    descController =
        TextEditingController(text: widget.list[widget.index]['descricao']);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Editar Produto"),
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
                  child: Text("Editar Produto"),
                  color: Colors.blue,
                  onPressed: () {
                    editProduc();
                    Navigator.of(context).push(
                      MaterialPageRoute(

                          builder: (BuildContext context) => Home()),
                    );
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
