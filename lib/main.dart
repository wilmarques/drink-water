import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Drink Water',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Drink Water'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<SharedPreferences> _preferences = SharedPreferences.getInstance();
  late Future<int> _counter;

  Future<int> _getLastEditDay() async {
    final preferences = await _preferences;
    return preferences.getInt('last_edit_day') ?? 0;
  }

  Future<bool> _saveLastEditDate() async {
    final todayDay = DateTime.now().day;
    final preferences = await _preferences;
    return preferences.setInt('last_edit_day', todayDay);
  }

  Future<int> _getWaterIntakeValue() async {
    final preferences = await _preferences;
    return preferences.getInt('intake') ?? 0;
  }

  Future<bool> _storeWaterIntakeValue(int value) async {
    final preferences = await _preferences;
    return preferences.setInt('intake', value);
  }

  Future<void> _incrementCounter() async {
    final int currentCounter = await _getWaterIntakeValue();
    final int incrementedCounter = currentCounter + 100;
    _saveLastEditDate();

    setState(() {
      _counter = _storeWaterIntakeValue(incrementedCounter).then((success) {
        return incrementedCounter;
      });
    });
  }

  Future<void> _decrementCounter() async {
    final int currentCounter = await _getWaterIntakeValue();

    if (currentCounter == 0) {
      return;
    }

    final int decrementedCounter = currentCounter - 100;
    _saveLastEditDate();

    setState(() {
      _counter = _storeWaterIntakeValue(decrementedCounter).then((success) {
        return decrementedCounter;
      });
    });
  }

  @override
  void initState() {
    super.initState();

    _counter = _getLastEditDay().then((lastEditDay) {
      if (lastEditDay == DateTime.now().day) {
        return _getWaterIntakeValue();
      } else {
        _storeWaterIntakeValue(0);
        return 0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Quantidade de água ingerida hoje',
            ),
            FutureBuilder<int>(
              future: _counter,
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return const CircularProgressIndicator();
                  default:
                    if (snapshot.hasError) {
                      return Text('Falha: ${snapshot.error}');
                    }
                    return Text(
                      '${snapshot.data} ml',
                      style: Theme.of(context).textTheme.headline4,
                    );
                }
              },
            )
          ],
        ),
      ),
      floatingActionButton: Wrap(
        direction: Axis.vertical,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 10, left: 3),
            child: FloatingActionButton.small(
              onPressed: _decrementCounter,
              tooltip: 'Remover 100 ml',
              child: Icon(Icons.remove),
              backgroundColor: Colors.red,
            ),
          ),
          Container(
            child: FloatingActionButton(
              onPressed: _incrementCounter,
              tooltip: 'Adicionar 100 ml',
              child: Icon(Icons.add),
            ),
          ),
        ],
      ),
    );
  }
}
