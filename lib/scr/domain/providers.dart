import 'package:flutter_riverpod/flutter_riverpod.dart';

final calculatorProvider =
    StateNotifierProvider<CalculatorNotifier, CalculatorState>((ref) {
  return CalculatorNotifier();
});

class CalculatorState {
  int num1;
  int num2;
  int result;
  String symbol;

  CalculatorState({
    this.num1 = 0,
    this.num2 = 0,
    this.result = 0,
    this.symbol = '',
  });

  CalculatorState copyWith({
    int? num1,
    int? num2,
    int? result,
    String? symbol,
  }) {
    return CalculatorState(
      num1: num1 ?? this.num1,
      num2: num2 ?? this.num2,
      result: result ?? this.result,
      symbol: symbol ?? this.symbol,
    );
  }
}

class CalculatorNotifier extends StateNotifier<CalculatorState> {
  CalculatorNotifier() : super(CalculatorState());

  void setSymbol(String symbol) {
    state = state.copyWith(symbol: symbol);
  }

  void setNum1(int num1) {
    state = state.copyWith(num1: num1);
  }

  void setNum2(int num2) {
    state = state.copyWith(num2: num2);
  }

  void setResult(int result) {
    state = state.copyWith(result: result);
  }

  void clear() {
    state = CalculatorState();
  }
}
