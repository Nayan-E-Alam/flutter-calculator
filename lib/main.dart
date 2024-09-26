import 'package:flutter/material.dart';

void main() => runApp(CalculatorApp());

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CalculatorHomePage(),
    );
  }
}

class CalculatorHomePage extends StatefulWidget {
  @override
  _CalculatorHomePageState createState() => _CalculatorHomePageState();
}

class _CalculatorHomePageState extends State<CalculatorHomePage> {
  String display = "0";

  // Buttons List (without DEL and =)
  final List<String> buttons = [
    '1', '2', '3', '/',
    '4', '5', '6', '-',
    '7', '8', '9', 'X',
    '0', '%', '+'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculator'),
      ),
      body: Column(
        children: <Widget>[
          // Display Section
          Expanded(
            flex: 1,
            child: Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.all(20),
              color: Colors.black12,
              child: Text(
                display,
                style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          // Row for DEL and = buttons
          Row(
            children: [
              Expanded(
                child: CalculatorButton(
                  buttonText: 'DEL',
                  buttonColor: Colors.blue,
                  onPressed: () {
                    setState(() {
                      onButtonPressed('DEL');
                    });
                  },
                ),
              ),
              Expanded(
                child: CalculatorButton(
                  buttonText: '=',
                  buttonColor: Colors.blue,
                  onPressed: () {
                    setState(() {
                      onButtonPressed('=');
                    });
                  },
                ),
              ),
            ],
          ),
          // Button Grid section
          Expanded(
            flex: 3,
            child: GridView.builder(
              itemCount: buttons.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4, // 4 buttons per row
              ),
              itemBuilder: (BuildContext context, int index) {
                // Define button color based on the button type
                Color buttonColor;
                if (['/', '-', 'X', '+', '%'].contains(buttons[index])) {
                  buttonColor = Colors.green;
                } else {
                  buttonColor = Colors.orange;
                }
                return CalculatorButton(
                  buttonText: buttons[index],
                  buttonColor: buttonColor,
                  onPressed: () {
                    setState(() {
                      onButtonPressed(buttons[index]);
                    });
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // Logic to handle button presses
  void onButtonPressed(String buttonText) {
    if (buttonText == "DEL") {
      display = display.length > 1 ? display.substring(0, display.length - 1) : "0";
    } else if (buttonText == "=") {
      display = evaluateExpression(display);
    } else {
      if (display == "0") {
        display = buttonText;
      } else {
        display += buttonText;
      }
    }
  }

  String evaluateExpression(String expression) {
    try {
      // You can add logic or math expression parsing here
      return expression; // Temporary
    } catch (e) {
      return "Error";
    }
  }
}

class CalculatorButton extends StatelessWidget {
  final String buttonText;
  final Color buttonColor;
  final Function onPressed;

  CalculatorButton({
    required this.buttonText,
    required this.buttonColor,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onPressed(),
      child: Container(
        margin: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            buttonText,
            style: TextStyle(fontSize: 24, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
