import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final List<Color> _themeColors = [
    Colors.deepPurple,
    Colors.blue,
    Colors.green,
    Colors.red,
    Colors.orange,
    Colors.pink
  ];
  int _currentThemeIndex = 0;

  ThemeData _theme = ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
    useMaterial3: true,
  );

  void changeTheme() {
    setState(() {
      _currentThemeIndex = (_currentThemeIndex + 1) % _themeColors.length;
      _theme = ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: _themeColors[_currentThemeIndex],
        ),
        useMaterial3: true,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: _theme,
      home: MyHomePage(
        title: 'Flutter Demo Home Page',
        onChangeTheme: changeTheme,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
    required this.title,
    required this.onChangeTheme,
  });

  final String title;
  final VoidCallback onChangeTheme;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  double _mana = 0.0;
  final TextEditingController _controller = TextEditingController();

  void _incrementCounter(String input) {
    setState(() {
      if (input == "Avada Kedavra") {
        _counter = 0;
        _mana = 0.0;
      } else {
        final number = int.tryParse(input);
        if (number != null) {
          _counter += number;
          _mana += number * 0.01;

          if (_mana >= 1.0) {
            widget.onChangeTheme();
            _mana = _mana % 1.0;
          }
        } else {
          _showInvalidInputWarning(); // Показуємо попередження
        }
      }
    });
  }

  void _showInvalidInputWarning() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Please enter a valid number."),
        backgroundColor: Colors.red,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('You have pushed the button this many times:'),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: _controller,
                decoration: const InputDecoration(
                  labelText: "Enter a number or 'Avada Kedavra'",
                ),
                keyboardType: TextInputType.text,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                _incrementCounter(_controller.text);
              },
              child: const Text('Submit'),
            ),
            const SizedBox(height: 20),
            Text('Mana level: ${(_mana * 100).toStringAsFixed(1)}%'),
            LinearProgressIndicator(
              value: _mana,
              minHeight: 20,
              backgroundColor: Colors.grey[300],
              valueColor: AlwaysStoppedAnimation<Color>(
                _mana < 1.0 ? Colors.blue : Colors.red,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _incrementCounter(_controller.text),
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
