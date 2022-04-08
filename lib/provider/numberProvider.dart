import 'dart:math';

import 'package:flutter/material.dart';

class NumberProvider extends ChangeNotifier {
  List<int> randomNumbers = [];
  List<int> sorted = [];
  List<bool> seen = List.generate(9, (index) => false);
  bool show = true;
  bool won = false;
  NumberProvider() {
    refresh();
    showRandoms();
    check();
  }

  numbers() {
    debugPrint(randomNumbers.toString());
  }

  refresh() {
    randomNumbers = List.generate(9, (index) => Random().nextInt(100));
    sorted = List.generate(9, ((index) => randomNumbers[index]));
    print(sorted);
    seen = List.generate(9, ((index) => false));
    notifyListeners();
  }

  removed(int index) {
    List<int>  indexedLIst =
        List.generate(randomNumbers.length, (index) => index);

    sorted.sort();
    notifyListeners();

    if (randomNumbers[index] == sorted.first) {
      sorted.removeAt(0);
      notifyListeners();
      seen[index] = true;
      notifyListeners();
    }
  }

  check() {
    for (var i = 0; i < seen.length; i++) {
      if (seen[i] == true) {
        won = true;
      }
    }
    notifyListeners();
  }

  showRandoms() {
    show = true;
    Future.delayed(const Duration(seconds: 5), () {
      show = false;
      notifyListeners();
    });
    notifyListeners();
  }
}
