class HomeController {
  final options = [
    "AC",
    "+/-",
    "%",
    "÷",
    "7",
    "8",
    "9",
    "×",
    "4",
    "5",
    "6",
    "-",
    "1",
    "2",
    "3",
    "+",
    "0",
    ".",
    "=",
  ];

  bool isOperator(int index) {
    switch (index) {
      case 0:
      case 1:
      case 2:
      case 3:
      case 7:
      case 11:
      case 15:
      case 18:
        return true;
      default:
        return false;
    }
  }

  String displayValue = '0';
  String logDisplayValue = '';
  String firstOperand = '';
  bool waitingForSecondOperand = false;
  String calcOperator = '';
  String error = '';
  String displayHistory = '';
  bool showEqual = false;

  void tapButton(int index) {
    switch (index) {
      case 4:
        this.inputDigit('7');
        break;
      case 5:
        this.inputDigit('8');
        break;
      case 6:
        this.inputDigit('9');
        break;
      case 8:
        this.inputDigit('4');
        break;
      case 9:
        this.inputDigit('5');
        break;
      case 10:
        this.inputDigit('6');
        break;
      case 12:
        this.inputDigit('1');
        break;
      case 13:
        this.inputDigit('2');
        break;
      case 14:
        this.inputDigit('3');
        break;
      case 16:
        this.inputDigit('0');
        break;
      case 17:
        this.inputDecimal('.');
        break;
      case 0:
        this.resetCalculator();
        break;
      case 1:
        this.handleOperator("+/-");
        break;
      case 2:
        this.handleOperator("%");
        break;
      case 3:
        this.handleOperator("÷");
        break;
      case 7:
        this.handleOperator("×");
        break;
      case 11:
        this.handleOperator("-");
        break;
      case 15:
        this.handleOperator("+");
        break;
      case 18:
        this.equalPressed();
        break;

      default:
        this.error = 'Error';
    }
  }

  // inputDigit() - when any digit is clicked
  // handleOperator() - when any operator is clicked
  // equalPressed() - when the equal sign is clicked
  // inputDecimal() - to handle the decimal point (.)
  // resetCalculator() - to clear the calculator ('AC')

  equalPressed() {
    displayValue = this.displayValue;
    firstOperand = this.firstOperand;
    calcOperator = this.calcOperator;
    showEqual = this.showEqual;

    try {
      displayValue = this.calculate(firstOperand, displayValue, calcOperator);
      showEqual = true;
      calcOperator = '';
    } catch (e) {
      error = e.toString();
    }
  }

  inputDigit(digit) {
    displayValue = this.displayValue;
    waitingForSecondOperand = this.waitingForSecondOperand;
    displayHistory = this.displayHistory;

    if (waitingForSecondOperand == true) {
      displayValue = digit;
      displayHistory = displayHistory + displayValue;
      waitingForSecondOperand = false;
    } else {
      displayValue = displayValue == '0' ? digit : displayValue + '' + digit;
      displayHistory = displayHistory + digit;
    }
  }

  inputDecimal(dot) {
    displayValue = this.displayValue;
    waitingForSecondOperand = this.waitingForSecondOperand;
    if (waitingForSecondOperand == true) {
      displayValue = '0.';
      waitingForSecondOperand = false;

      displayHistory = displayValue;
      return;
    }

    if (double.parse(displayValue) % 1 == 0 && !displayValue.contains(dot)) {
      displayValue += dot;

      displayHistory = displayHistory + dot;
    }
  }

  handleOperator(nextOperator) {
    displayValue = this.displayValue;
    firstOperand = this.firstOperand;
    calcOperator = this.calcOperator;
    waitingForSecondOperand = this.waitingForSecondOperand;

    String inputValue = displayValue;

    if (calcOperator.isNotEmpty && waitingForSecondOperand) {
      calcOperator = nextOperator;
      return;
    }

    if (firstOperand == '' && inputValue.isNotEmpty) {
      firstOperand = inputValue;
    } else if (calcOperator.isEmpty) {
      String currentValue = firstOperand;
      String result = this.calculate(currentValue, inputValue, calcOperator);
      displayValue = result;
      firstOperand = result;
    }

    waitingForSecondOperand = true;
    calcOperator = nextOperator;
    displayValue = displayValue + ' ' + calcOperator + ' ';

    displayHistory = displayHistory + ' ' + calcOperator + ' ';
  }

  calculate(firstOperand, secondOperand, calcOperator) {
    firstOperand = double.parse(firstOperand);
    secondOperand = double.parse(secondOperand);
    double result;

    if (calcOperator == '+') {
      result = firstOperand + secondOperand;
      return result.toString();
    } else if (calcOperator == '-') {
      result = firstOperand - secondOperand;
      return result.toString();
    } else if (calcOperator == '×') {
      result = firstOperand * secondOperand;
      return result.toString();
    } else if (calcOperator == '%') {
      result = firstOperand / 100;
      waitingForSecondOperand = false;
      return result.toString();
    } else if (calcOperator == '÷') {
      if (secondOperand == 0) {
        this.error = 'ERROR: Cannot divide by 0';
      } else {
        result = firstOperand / secondOperand;
        return result.toString();
      }
    }
    return secondOperand.toString();
  }

  resetCalculator() {
    this.displayValue = '0';
    this.firstOperand = '';
    this.waitingForSecondOperand = false;
    this.calcOperator = '';
    this.displayHistory = '';
    this.showEqual = false;
  }
}
