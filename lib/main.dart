import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Калькулятор площади',
      theme: ThemeData(
        primaryColor: Colors.blue,
        appBarTheme: AppBarTheme(
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      home: CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  TextEditingController widthController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  String resultText = 'Задайте параметры';
  bool widthError = false;
  bool heightError = false;

  void _calculateArea() {
    setState(() {
      widthError = widthController.text.isEmpty;
      heightError = heightController.text.isEmpty;
    });

    if (widthError || heightError) {
      return;
    }

    double width = double.tryParse(widthController.text) ?? 0;
    double height = double.tryParse(heightController.text) ?? 0;

    double area = width * height;

    setState(() {
      resultText = 'S = $width * $height = $area';
      widthError = false;
      heightError = false;
    });

    _showSuccessSnackBar();
  }

  void _showSuccessSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Площадь успешно вычислена!',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Калькулятор площади'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                children: [
                  Text('Ширина (мм):'),
                  SizedBox(width: 8.0),
                  Expanded(
                    child: TextFormField(
                      controller: widthController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        errorText: widthError ? 'Задайте ширину' : null,
                        errorStyle:
                            TextStyle(color: Colors.red, fontSize: 12.0),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                children: [
                  Text('Высота (мм):'),
                  SizedBox(width: 8.0),
                  Expanded(
                    child: TextFormField(
                      controller: heightController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        errorText: heightError ? 'Задайте высоту' : null,
                        errorStyle:
                            TextStyle(color: Colors.red, fontSize: 12.0),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _calculateArea,
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
              ),
              child: Text('Вычислить'),
            ),
            SizedBox(height: 16.0),
            Text(
              resultText,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
