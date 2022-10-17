import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _preco = "0";

  void _recuperarPreco() async {


    String url = "https://blockchain.info/ticker";
    http.Response response = await http.get(Uri.parse(url));
    Map<String, dynamic> retorno = jsonDecode(response.body);

     setState(() {
       _preco = retorno["BRL"]["buy"].toString();
     });

    print("Resultado : " + retorno["BRL"]["buy"].toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              "assets/image/bitcoin.png",
              width: 250,
            ),
            SizedBox(height: 40),
            Text(
              "R\$ " + _preco,
              style: TextStyle(
                fontSize: 30,
              ),
            ),
            SizedBox(height: 35),
            ElevatedButton(
              onPressed: () {
                _recuperarPreco();
              },
              style: ElevatedButton.styleFrom(primary: Colors.orange),
              child: Text(
                "Atualizar",
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
