import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'dart:math';

int getRandomIndex() {
  Random random = Random();
  return random.nextInt(4);
}

List<List<int>> getInitGameState() {
  List<List<int>> result = [
    [0, 0, 0, 0], //0
    [0, 0, 0, 0], //1
    [0, 0, 0, 0], //2
    [0, 0, 0, 0], //3
  ];
  result[getRandomIndex()][getRandomIndex()] += 2;
  result[getRandomIndex()][getRandomIndex()] += 2;

  return result;
}

List<int> calculateList(List<int> list) {
  List<int> listWithoutZero = [];

  for (int i = 0; i < list.length; i++) {
    if (list[i] != 0) {
      print("CALL");
      listWithoutZero = [...listWithoutZero, list[i]];
    }
  }

  if (listWithoutZero.isEmpty) {
    return list;
  }

  List<int> result = [];

  if (listWithoutZero.length == 1) {
    result = listWithoutZero;
  } else {
    List<int> calcList = [];
    for (int i = listWithoutZero.length - 1; i > 0; i--) {
      if (listWithoutZero[i] == listWithoutZero[i - 1]) {
        calcList = [listWithoutZero[i] * 2, ...calcList];
        i--;
      } else {
        calcList = [listWithoutZero[i], ...calcList];
      }
    }
    result = calcList;
    print("CAlCL CLIST = $calcList");
  }

  while (result.length < 4) {
    result = [0, ...result];
  }

  print("RESULT LENGTH = ${result.length}");

  return result;
}

class GameProvider extends ChangeNotifier {
  List<List<int>> gameState = getInitGameState();

  void moveDown() {
    for (int j = 0; j < 4; j++) {
      List<int> currentList = [];

      for (int i = 0; i < 4; i++) {
        currentList.add(gameState[i][j]);
      }

      List<int> newList = calculateList(currentList);

      for (int i = 0; i < 4; i++) {
        print("Length ${newList.length}");
        gameState[i][j] = newList[i];
      }
    }
    print(gameState);
    notifyListeners();
  }
}

var gameProvider = ChangeNotifierProvider<GameProvider>((ref) {
  return GameProvider();
});
