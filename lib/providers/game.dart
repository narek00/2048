import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'dart:math';

int getRandomIndex() {
  Random random = Random();
  return random.nextInt(4);
}

List<List<int>> getInitGameState() {
  List<List<int>> result = [
    [0, 0, 0, 0],
    [0, 0, 0, 0],
    [0, 0, 0, 0],
    [0, 0, 0, 0],
  ];
  result[getRandomIndex()][getRandomIndex()] += 2;
  result[getRandomIndex()][getRandomIndex()] += 2;

  return result;
}

List<int> calcLogic(List<int> list) {
  List<int> listWithoutZero = [];

  list.map((e) => {
        if (e != 0) {listWithoutZero.add(e)}
      });

  if (listWithoutZero.isEmpty) {
    return list;
  }

  List<int> calcList = [];

  for (int i = listWithoutZero.length - 1; i > 0; i--) {
    if (listWithoutZero[i] == listWithoutZero[i - 1]) {
      calcList = [listWithoutZero[i] * 2, ...calcList];
      i--;
    }
  }

  List<int> result = calcList;
  while (result.length != 4) {
    result = [0, ...result];
  }

  return result;
}

class GameProvider extends ChangeNotifier {
  List<List<int>> gameState = getInitGameState();

  void move() {
    for (int i = 0; i < 4; i++) {}
  }
}

var gameProvider = ChangeNotifierProvider<GameProvider>((ref) {
  return GameProvider();
});
