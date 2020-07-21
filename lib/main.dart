import "package:flutter/material.dart";
import "package:http/http.dart" as http;
import "dart:async";
import "dart:convert";

const request = "https://api.hgbrasil.com/finance?format=json&key=a5e1d28e";

void main() async {
  runApp(
    MaterialApp(
      home: Home(),
      theme: ThemeData(
          hintColor: Colors.amber,
          primaryColor: Colors.white,
          inputDecorationTheme: InputDecorationTheme(
            enabledBorder:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.amber)),
            focusedBorder:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.amber)),
            hintStyle: TextStyle(color: Colors.amber),
          )),
      debugShowCheckedModeBanner: false,
    ),
  );
}

final realController = TextEditingController();
final dolarController = TextEditingController();
final euroController = TextEditingController();

Future<Map> getData() async {
  http.Response response = await http.get(request);
  return json.decode(response.body);
}

class Home extends StatefulWidget {
  _HomeState createState() => _HomeState();
}

double dolar;
double euro;
double real;

void clearAll() {
  realController.text = "";
  dolarController.text = "";
  euroController.text = "";
}

void _realChanged(text) {
  double real = double.parse(text);
  dolarController.text = (real * dolar).toStringAsFixed(2);
  euroController.text = (real / euro).toStringAsFixed(2);
}

void _dolarChanged(text) {
  double inputDolar = double.parse(text);
  realController.text = (dolar * inputDolar).toStringAsFixed(2);
  euroController.text = ((dolar * inputDolar) / euro).toStringAsFixed(2);
}

void _euroChanged(text) {
  double inputEuro = double.parse(text);
  realController.text = (euro * inputEuro).toStringAsFixed(2);
  dolarController.text = ((euro * inputEuro) / dolar).toStringAsFixed(2);
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
          backgroundColor: Colors.amber,
          title: Text(
            "Conversor de Moedas",
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.rotate_left, color: Colors.black),
              onPressed: clearAll,
            ),
          ],
          centerTitle: true),
      body: FutureBuilder<Map>(
        future: getData(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
            default:
              if (snapshot.hasError) {
                return Text("Erro ao carregar dados :(",
                    style: TextStyle(color: Colors.red, fontSize: 25));
              } else {
                dolar = snapshot.data["results"]["currencies"]["USD"]["buy"];
                euro = snapshot.data["results"]["currencies"]["EUR"]["buy"];
                return SingleChildScrollView(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Icon(Icons.monetization_on,
                          color: Colors.amber, size: 200),
                      buildTextField(
                          "Reais", "R\$", realController, _realChanged),
                      Divider(),
                      buildTextField(
                          "Dolar", "US\$", dolarController, _dolarChanged),
                      Divider(),
                      buildTextField(
                          "Euro", "EUR", euroController, _euroChanged),
                      Divider(),
                    ],
                  ),
                );
              }
          }
        },
      ),
    );
  }
}

buildTextField(
    String label, String prefix, TextEditingController c, Function f) {
  return TextField(
    onChanged: (text) {
      if (text.isEmpty) {
        clearAll();
      } else {
        f(text);
      }
    },
    controller: c,
    keyboardType: TextInputType.number,
    style: TextStyle(
      color: Colors.amber,
      fontSize: 25,
    ),
    decoration: InputDecoration(
      border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
      labelText: label,
      prefix: Text(prefix),
      prefixStyle: TextStyle(
        color: Colors.amber,
        fontSize: 25,
      ),
      labelStyle: TextStyle(
        color: Colors.amber,
        fontSize: 25,
      ),
    ),
  );
}
