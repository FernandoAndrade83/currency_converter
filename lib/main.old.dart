import "package:flutter/material.dart";
import 'package:http/http.dart' as http;
import "dart:async";
import "dart:convert";

const request = "https://api.hgbrasil.com/finance?format=json&key=a5e1d28e";

void main() async {
  runApp(
    MaterialApp(
      home: Home(),
      theme: ThemeData(
          hintColor: Colors.yellow[600],
          primaryColor: Colors.white,
          inputDecorationTheme: InputDecorationTheme(
            enabledBorder:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
            focusedBorder:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.amber)),
            hintStyle: TextStyle(color: Colors.yellow[600]),
          )),
      debugShowCheckedModeBanner: false,
    ),
  );
}

Future<Map> getData() async {
  http.Response response = await http.get(request);
  return json.decode(response.body);
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

double dolar;
double real;
double euro;
final realController = TextEditingController();
final euroController = TextEditingController();
final dolarController = TextEditingController();

void _realController(String text) {
  double real = double.parse(text);
  dolarController.text = (real * dolar).toStringAsFixed(2);
  euroController.text = (real * euro).toStringAsFixed(2);
}

void _dolarController(String text) {
  double dolar = double.parse(text);
  realController.text = (dolar * real).toStringAsPrecision(2);
  euroController.text = (dolar * euro).toStringAsFixed(2);
}

void _euroController(String text) {
  double euro = double.parse(text);
  dolarController.text = (euro * dolar).toStringAsFixed(2);
  realController.text = (euro * real).toStringAsFixed(2);
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        title:
            Text("Conversor de Moedas", style: TextStyle(color: Colors.black)),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              realController.text = "";
              dolarController.text = "";
              euroController.text = "";
            },
            color: Colors.black,
          ),
        ],
      ),
      body: FutureBuilder<Map>(
          future: getData(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
                return Center(child: CircularProgressIndicator());
              default:
                if (snapshot.hasError) {
                  return Center(
                    child: Text("Erro ao carregar dados",
                        style: TextStyle(color: Colors.red, fontSize: 25),
                        textAlign: TextAlign.center),
                  );
                } else {
                  dolar = snapshot.data["results"]["currencies"]["USD"]["buy"];
                  euro = snapshot.data["results"]["currencies"]["EUR"]["buy"];
                  return SingleChildScrollView(
                    padding: EdgeInsets.only(top: 20, left: 15, right: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.monetization_on,
                            color: Colors.yellow, size: 200),
                        generateTextField(
                            "Reais", "R\$", realController, _realController),
                        Divider(),
                        generateTextField(
                            "Dolar", "US\$", dolarController, _dolarController),
                        Divider(),
                        generateTextField(
                            "Euro", "€", euroController, _euroController),
                      ],
                    ),
                  );
                }
            }
          }),
    );
  }
}

generateTextField(
  String label,
  String prefix,
  TextEditingController controller,
  Function f,
) {
  return TextField(
    onChanged: f,
    keyboardType: TextInputType.number,
    style: TextStyle(
      color: Colors.yellow[600],
      fontSize: 25,
    ),
    controller: controller,
    decoration: InputDecoration(
      labelText: label,
      prefixText: prefix,
      prefixStyle: TextStyle(
        color: Colors.yellow[600],
        fontSize: 25,
      ),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
      labelStyle: TextStyle(
        color: Colors.yellow,
        fontSize: 25,
      ),
    ),
  );
}
