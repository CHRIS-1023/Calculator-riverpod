import 'package:flutter_riverpod/flutter_riverpod.dart';

final calculatorProvider =
    StateNotifierProvider<CalculatorNotifier, CalculatorState>((ref) {
  return CalculatorNotifier();
});

class CalculatorState {
  List<int> num1;
  List<int> num2;
  int result;
  String symbol;

  CalculatorState({
    this.num1 = const [],
    this.num2 = const [],
    this.result = 0,
    this.symbol = '',
  });

  CalculatorState copyWith({
    List<int>? num1,
    List<int>? num2,
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

  void setNum1(int digit) {
    state = state.copyWith(num1: [...state.num1, digit]);
  }

  void setNum2(int digit) {
    state = state.copyWith(num2: [...state.num2, digit]);
  }

  void setResult(int result) {
    state = state.copyWith(result: result);
  }

  void clear() {
    state = CalculatorState();
  }
}
