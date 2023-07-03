import 'package:calculator/scr/domain/providers.dart';
import 'package:calculator/scr/presentation/buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CalcScreen extends ConsumerStatefulWidget {
  const CalcScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CalcScreenState();
}

class _CalcScreenState extends ConsumerState<CalcScreen> {
  List<String> specialCharacters = [
    '+',
    '-',
    '*',
    '/',
    '=',
    'C',
  ];

  List<int> digits = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              decoration: const BoxDecoration(color: Colors.grey),
              alignment: Alignment.bottomRight,
              padding: const EdgeInsets.all(16.0),
              child: Consumer(
                builder: (context, ref, child) {
                  final calculatorState = ref.watch(calculatorProvider);

                  return Text(
                    '${calculatorState.num1.join('')} ${calculatorState.symbol} ${calculatorState.num2.join('')} = ${calculatorState.result}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                },
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: GridView.count(
              crossAxisCount: 4,
              crossAxisSpacing: 4,
              mainAxisSpacing: 4,
              children: [
                ...specialCharacters.map(
                  (char) => CalculatorButton(
                    buttonText: char,
                    color: Colors.amber,
                    onPressed: () {
                      charCalc(char);
                    },
                  ),
                ),
                ...digits.map(
                  (digit) => CalculatorButton(
                    buttonText: digit.toString(),
                    onPressed: () {
                      digitsCalc(digit);
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void calculateResult(CalculatorState calculatorState) {
    final int num1 = int.parse(calculatorState.num1.join(''));
    final int num2 = int.parse(calculatorState.num2.join(''));
    final String symbol = calculatorState.symbol;
    int result = 0;

    switch (symbol) {
      case '+':
        result = num1 + num2;
        break;
      case '-':
        result = num1 - num2;
        break;
      case '*':
        result = num1 * num2;
        break;
      case '/':
        result = num1 ~/ num2; // Integer division
        break;
    }

    ref.read(calculatorProvider.notifier).setResult(result);
  }

  void clearCalculator(CalculatorState calculatorState) {
    ref.read(calculatorProvider.notifier).clear();
  }

  void digitsCalc(digit) {
    final calculatorState = ref.read(calculatorProvider);
    if (calculatorState.symbol.isEmpty) {
      ref.read(calculatorProvider.notifier).setNum1(digit);
    } else {
      ref.read(calculatorProvider.notifier).setNum2(digit);
    }
  }

  void charCalc(char) {
    if (char == '=') {
      calculateResult(ref.read(calculatorProvider));
    } else if (char == 'C') {
      clearCalculator(ref.read(calculatorProvider));
    } else {
      ref.read(calculatorProvider.notifier).setSymbol(char);
    }
  }
}
