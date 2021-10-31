import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'water_intake.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => WaterIntake(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  final String title = 'Drink Water';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: title,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: title),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Quantidade de água ingerida hoje',
            ),
            Consumer<WaterIntake>(
              builder: (context, waterIntake, child) => Text(
                '${waterIntake.current} ml',
                style: Theme.of(context).textTheme.headline4,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Wrap(
        direction: Axis.vertical,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 10, left: 3),
            child: FloatingActionButton.small(
              onPressed: () {
                final waterIntake = context.read<WaterIntake>();
                waterIntake.decrease();
              },
              tooltip: 'Remover 100 ml',
              child: Icon(Icons.remove),
              backgroundColor: Colors.red,
            ),
          ),
          Container(
            child: FloatingActionButton(
              onPressed: () {
                final waterIntake = context.read<WaterIntake>();
                waterIntake.increment();
              },
              tooltip: 'Adicionar 100 ml',
              child: Icon(Icons.add),
            ),
          ),
        ],
      ),
    );
  }
}
