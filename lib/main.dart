import 'package:flutter/material.dart';
import 'dart:math';

void main() => runApp(App());

class App extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Probability and Performance Measurement App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Home(title: 'Perfomance et Probabilité'),
    );
  }
}

class Home extends StatefulWidget {
  Home({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // customers
  var n;
  //customers input rate
  var y;
  //customers output rate
  var m;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(widget.title),
          actions: <Widget>[
            IconButton(
              onPressed: () => showAboutDialog(
                  context: context,
                  applicationName: 'PP Calculator',
                  applicationVersion: '0.0.1',
                  children: [
                    Text(
                        'Calculateur de Perfomance et Probabilité sur les systèmes M|M|1'),
                    Text(''),
                    Text('Par Lusavuvu Situatala'),
                  ]),
              icon: Icon(Icons.help),
            ),
          ],
          centerTitle: true),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 50.0, horizontal: 30.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Center(
                  child: Text(
                    'Proceder aux calculs',
                    style: TextStyle(
                      fontSize: 22,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Nombre de clients (n)',
                    border: OutlineInputBorder(),
                  ),
                  validator: (val) =>
                      null == val ? 'Veuillez remplir ce champ' : null,
                  onChanged: (val) => n = val,
                ),
                SizedBox(
                  height: 10.0,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Taux d\'entré de clients (y)',
                    border: OutlineInputBorder(),
                  ),
                  validator: (val) =>
                      null == val ? 'Veuillez remplir ce champ' : null,
                  onChanged: (val) => y = val,
                ),
                SizedBox(
                  height: 10.0,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Taux de sorti de clients (M)',
                    border: OutlineInputBorder(),
                  ),
                  validator: (val) =>
                      null == val ? 'Veuillez remplir ce champ' : null,
                  onChanged: (val) => m = val,
                ),
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(2.0)),
                    ),
                    side: BorderSide(
                      width: 1,
                      color: Colors.black,
                    ),
                  ),
                  onPressed: () {
                    if(_formKey.currentState!.validate()) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Result(n: n, y: y, m: m)));
                    }
                  },
                  child: Text(
                    'Calculer',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Result extends StatefulWidget {
  Result({Key? key, required this.n, required this.y, required this.m})
      : super(key: key);

  final n, y, m;

  @override
  _ResultState createState() => _ResultState();
}

class _ResultState extends State<Result> {
  @override
  void initState() {
    int n = int.parse(widget.n);
    double y = double.parse(widget.y);
    double m = double.parse(widget.m);

    f = y / m;
    f = f.toStringAsFixed(3);
    f = num.parse(f);

    if (f < 1) {
      s = 'Equilibre';
    } else {
      s = 'Explosion';
    }

    if (n >= 1) {
      p = pow(f, n) * (1 - f);
      p = p.toStringAsFixed(3);
      p = num.parse(p);
    } else if (n == 0) {
      p = 1 - f;
      p = p.toStringAsFixed(3);
      p = num.parse(p);
    } else {
      p = 'Nombre de clients non valide!';
    }

    ns = f / (1 - f);
    ns = ns.toStringAsFixed(3);
    ns = num.parse(ns);

    nf = (f * f) / (1 - f);
    nf = nf.toStringAsFixed(3);
    nf = num.parse(nf);

    nss = ns - nf;
    nss = nss.toStringAsFixed(3);
    nss = num.parse(nss);

    super.initState();
  }

  var f, p, ns, nf, nss, s;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Les resultats'),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Text(
              'f vaut: $f',
              style: TextStyle(
                fontSize: 25,
              ),
            ),
            Text(
              'P vaut: $p',
              style: TextStyle(
                fontSize: 25,
              ),
            ),
            Text(
              'NS vaut: $ns',
              style: TextStyle(
                fontSize: 25,
              ),
            ),
            Text(
              'Nf vaut: $nf',
              style: TextStyle(
                fontSize: 25,
              ),
            ),
            Text(
              'Ns vaut: $nss',
              style: TextStyle(
                fontSize: 25,
              ),
            ),
            Text(
              '',
              style: TextStyle(
                fontSize: 25,
              ),
            ),
            Center(
              child: Text(
                'Le système est en $s',
                style: TextStyle(
                  fontSize: 25,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
