import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// import 'configs/hive_config.dart';
import 'water_intake.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // await HiveConfig.start();

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
  final int defaultIntakeValue = 200;

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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 10),
            child: FloatingActionButton.small(
              onPressed: () {
                final waterIntake = context.read<WaterIntake>();
                waterIntake.decrease(ammount: defaultIntakeValue);
              },
              tooltip: 'Remover $defaultIntakeValue ml',
              child: Icon(Icons.remove),
              backgroundColor: Colors.red,
            ),
          ),
          Container(
            child: FloatingActionButton(
              onPressed: () {
                final waterIntake = context.read<WaterIntake>();
                waterIntake.increment(ammount: defaultIntakeValue);
              },
              tooltip: 'Adicionar $defaultIntakeValue ml',
              child: Icon(Icons.add),
            ),
          ),
        ],
      ),
    );
  }
}
