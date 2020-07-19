import "package:flutter/material.dart";

void main() {
  runApp(
    MaterialApp(
      home: Home(),
      debugShowCheckedModeBanner: false,
    ),
  );
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
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
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(top: 20, left: 15, right: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.monetization_on, color: Colors.yellow, size: 200),
            Container(
              margin: EdgeInsets.only(top: 10),
              child: TextField(
                keyboardType: TextInputType.number,
                style: TextStyle(
                  color: Colors.yellow[600],
                  fontSize: 25,
                ),
                decoration: InputDecoration(
                  labelText: "Reais",
                  prefixText: "RS",
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
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              child: TextField(
                keyboardType: TextInputType.number,
                style: TextStyle(
                  color: Colors.yellow[600],
                  fontSize: 25,
                ),
                decoration: InputDecoration(
                  labelText: "Dolar",
                  prefixText: "US",
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
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              child: TextField(
                keyboardType: TextInputType.number,
                style: TextStyle(
                  color: Colors.yellow[600],
                  fontSize: 25,
                ),
                decoration: InputDecoration(
                  labelText: "Euro",
                  prefixText: "EU",
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
