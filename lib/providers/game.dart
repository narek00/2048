import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class GameProvider extends ChangeNotifier {
  List<List<int?>> gameState = [
    [null, null, null, 2],
    [null, 32, null, 2],
    [null, null, null, 2],
    [null, null, null, 2],
  ];
}

var gameProvider = ChangeNotifierProvider<GameProvider>((ref) {
  return GameProvider();
});
