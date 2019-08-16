import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_mysql/productdesc.dart';
import 'package:flutter_mysql/addproduct.dart';

void main() {
  runApp(MaterialApp(
    title: "Catalogo",
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future<List> getData() async {
    final response =
        await http.get("http://senac.leofabris.com.br/getData.php");
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Catalogo"),
      ),floatingActionButton: FloatingActionButton(
      child: Icon(Icons.add),
      onPressed: ()=>Navigator.of(context).push(
        MaterialPageRoute(builder: (BuildContext context)=>AddProduct())
      ),  ),
      body: FutureBuilder<List>(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          return snapshot.hasData
              ? ListItemProducts(
                  listProducts: snapshot.data,
                )
              : Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

class ListItemProducts extends StatelessWidget {
  final List listProducts;

  ListItemProducts({this.listProducts});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: listProducts == null ? 0 : listProducts.length,
        itemBuilder: (context, i) {
          return Container(
            padding: const EdgeInsets.all(10),
            child: GestureDetector(
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) =>
                      ProductDesc(list: listProducts, index: i))),
              child: Card(
                child: ListTile(
                  title: Text(listProducts[i]['produto']),
                  leading: Icon(Icons.check),
                  subtitle: Text("Descricao ${listProducts[i]['descricao']}"),
                ),
              ),
            ),
          );
        },
    );
  }
}
