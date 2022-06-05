import 'package:_2048/models/directions.dart';
import 'package:_2048/providers/game.dart';
import 'package:_2048/screens/main/widgets/game_box.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class GameMap extends HookConsumerWidget {
  const GameMap({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const double space = 10;

    final double screenWidth = MediaQuery.of(context).size.width;
    final double mapSize = screenWidth - 50;

    final double boxSize = (mapSize - 5 * space) / 4;

    final _gameProvider = ref.watch(gameProvider);

    final _gameState = _gameProvider.gameState;

    Direction direction = Direction.down;

    return GestureDetector(
      onPanUpdate: (details) {
        if (details.delta.dx.abs() > details.delta.dy.abs()) {
          direction = details.delta.dx > 0 ? Direction.right : Direction.left;
        } else {
          direction = details.delta.dy > 0 ? Direction.down : Direction.up;
        }
      },
      onPanEnd: (_) {
        _gameProvider.move(direction);
      },
      child: Container(
        width: mapSize,
        height: mapSize,
        margin: const EdgeInsets.symmetric(horizontal: 25),
        padding: const EdgeInsets.only(top: space, left: space),
        decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: const Color.fromARGB(255, 111, 118, 247),
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(15),
          ),
        ),
        child: Column(
          children: [
            for (int i = 0; i < 4; i++)
              Padding(
                padding: EdgeInsets.only(
                  bottom: i != 3 ? space : 0,
                ),
                child: Row(
                  children: [
                    for (int j = 0; j < 4; j++)
                      Padding(
                        padding: EdgeInsets.only(
                          right: j != 3 ? space : 0,
                        ),
                        child: GameBox(
                          size: boxSize,
                          value: _gameState[i][j],
                        ),
                      )
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
