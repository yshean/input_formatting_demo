import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:input_formatting_demo/formatters/credit_card_formatter.dart';
import 'package:input_formatting_demo/formatters/telephone_number_formatter.dart';
import 'package:input_formatting_demo/formatters/thousands_formatter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              tabs: [
                Tab(
                  text: 'Types',
                ),
                Tab(
                  text: 'Examples',
                ),
              ],
            ),
            title: Text('Input Formatters'),
          ),
          body: TabBarView(children: [
            Padding(
              padding: const EdgeInsets.all(32.0),
              child: ListView(
                children: [
                  Text(
                    'FilteringTextInputFormatter.allow',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  TextField(
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                          RegExp(r'[a-zA-Z]+|\s')),
                      FilteringTextInputFormatter
                          .digitsOnly, // the intersection of both
                    ],
                  ),
                  SizedBox(height: 32),
                  Text(
                    'FilteringTextInputFormatter.deny',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  TextField(
                    inputFormatters: [
                      FilteringTextInputFormatter.deny(RegExp(r'\s')),
                      FilteringTextInputFormatter.singleLineFormatter,
                    ],
                  ),
                  SizedBox(height: 32),
                  Text(
                    'LengthLimitingTextInputFormatter',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  TextField(
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(8),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(32.0),
              child: ListView(
                children: [
                  Text(
                    'Credit card number',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  TextField(
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      // You can't put this here to "compose"
                      // because spaces will not be allowed to show then
                      // FilteringTextInputFormatter.digitsOnly,
                      CreditCardFormatter(),
                      LengthLimitingTextInputFormatter(
                          19), // 16 digits + 3 separators
                    ],
                  ),
                  SizedBox(
                    height: 32,
                  ),
                  Text(
                    'Telephone number',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  TextField(
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      TelephoneNumberFormatter(),
                      LengthLimitingTextInputFormatter(
                          12), // 10 digits + 2 separators
                    ],
                  ),
                  SizedBox(
                    height: 32,
                  ),
                  Text(
                    'Thousands grouping',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  TextField(
                    inputFormatters: [ThousandsFormatter()],
                  ),
                  SizedBox(
                    height: 32,
                  ),
                  Text(
                    'Decimal number',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  TextField(
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
                    inputFormatters: [ThousandsFormatter(allowFraction: true)],
                  ),
                  SizedBox(
                    height: 32,
                  ),
                  Text(
                    'Number with negative',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  TextField(
                    keyboardType: TextInputType.numberWithOptions(signed: true),
                    inputFormatters: [
                      ThousandsFormatter(
                        allowNegative: true,
                        allowFraction: true,
                      )
                    ],
                  ),
                  SizedBox(
                    height: 32,
                  ),
                  Text(
                    'Date format',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  TextField(
                    keyboardType: TextInputType.number,
                    inputFormatters: [],
                  ),
                  SizedBox(
                    height: 32,
                  ),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
