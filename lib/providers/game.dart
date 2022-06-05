import 'package:_2048/models/directions.dart';
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

    for (int i = listWithoutZero.length - 1; i >= 0; i--) {
      if (i != 0) {
        if (listWithoutZero[i] == listWithoutZero[i - 1]) {
          calcList = [listWithoutZero[i] * 2, ...calcList];
          listWithoutZero[i - 1] = 0;
          i--;
        } else {
          calcList = [listWithoutZero[i], ...calcList];
        }
      } else {
        calcList = [listWithoutZero[i], ...calcList];
      }
    }

    result = calcList;
  }

  while (result.length < 4) {
    result = [0, ...result];
  }

  return result;
}

List<List<int>> addRandomNumber(List<List<int>> gameState) {
  int emptyBoxes = 0;
  for (var l in gameState) {
    for (int n in l) {
      if (n == 0) {
        emptyBoxes++;
      }
    }
  }
  if (emptyBoxes == 0) {
    return gameState;
  }

  Random random = Random();
  int pos = random.nextInt(emptyBoxes);

  for (int i = 0; i < gameState.length; i++) {
    for (int j = 0; j < gameState[i].length; j++) {
      if (gameState[i][j] == 0) {
        if (pos == 0) {
          gameState[i][j] = (1 + Random().nextInt(2)) * 2;
          return gameState;
        } else {
          pos--;
        }
      }
    }
  }

  return gameState;
}

List<List<int>> rotateRigth(lli) {
  List<List<int>> res = [
    [0, 0, 0, 0],
    [0, 0, 0, 0],
    [0, 0, 0, 0],
    [0, 0, 0, 0],
  ];
  for (int i = 0; i < 4; i++) {
    List<int> colmn = [0, 0, 0, 0];
    for (int j = 0; j < 4; j++) {
      colmn[j] = lli[j][i];
    }
    res[i] = [...colmn.reversed];
  }
  return res;
}

//=========================================================================
class GameProvider extends ChangeNotifier {
  List<List<int>> gameState = getInitGameState();

  void _calc() {
    for (int i = 0; i < gameState.length; i++) {
      gameState[i] = calculateList(gameState[i]);
    }
  }

  void move(Direction dir) {
    switch (dir) {
      case Direction.down:
        gameState = rotateRigth(gameState);
        gameState = rotateRigth(gameState);
        gameState = rotateRigth(gameState);
        _calc();
        gameState = rotateRigth(gameState);
        break;
      case Direction.up:
        gameState = rotateRigth(gameState);
        _calc();
        gameState = rotateRigth(gameState);
        gameState = rotateRigth(gameState);
        gameState = rotateRigth(gameState);
        break;
      case Direction.left:
        gameState = rotateRigth(gameState);
        gameState = rotateRigth(gameState);
        _calc();
        gameState = rotateRigth(gameState);
        gameState = rotateRigth(gameState);
        break;
      default:
        _calc();
    }

    gameState = addRandomNumber(gameState);

    notifyListeners();
  }
}

var gameProvider = ChangeNotifierProvider<GameProvider>((ref) {
  return GameProvider();
});
