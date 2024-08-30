import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String frase = "Hello World!";

  Future<void> chamando(String linguagem) async {
    const channel = MethodChannel(
        'abe3/hamster/kotlin'); //Criação do canal para comunicação entre os lados

    try {
      final action = await channel
          .invokeMethod(linguagem); //entrando em contato com o outro lado
      setState(() {
        frase = action.toString();
      });
    } on PlatformException {
      setState(() {
        frase = "Erro ao acessar";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              frase,
              style: TextStyle(fontSize: 30),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  width: 100,
                  color: Colors.blue,
                  child: TextButton(
                      onPressed: () => chamando("kotlin"),
                      child: Text(
                        "Kotlin",
                        style: TextStyle(color: Colors.white),
                      )),
                ),
                Container(
                  width: 100,
                  color: Colors.blue,
                  child: TextButton(
                      onPressed: () => chamando("java"),
                      child: Text(
                        "Java",
                        style: TextStyle(color: Colors.white),
                      )),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
