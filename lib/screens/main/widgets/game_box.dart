import 'package:flutter/material.dart';

class GameBox extends StatelessWidget {
  final double size;
  final int? value;
  const GameBox({
    required this.size,
    required this.value,
    Key? key,
  }) : super(key: key);

  Color? getColor() {
    Color? result = const Color.fromRGBO(255, 255, 255, 0.5);
    switch (value) {
      case 2:
        result = Colors.green[200];
        break;
      case 4:
        result = Colors.green[400];
        break;
      case 8:
        result = Colors.amber[200];
        break;
      case 16:
        result = Colors.amber[500];
        break;
      case 32:
        result = Colors.purple[400];
        break;
      case 64:
        result = Colors.purple[900];
        break;
      case 128:
        result = Colors.black;
        break;
      case 256:
        result = Colors.black;
        break;
      case 512:
        result = Colors.black;
        break;
      case 1024:
        result = Colors.black;
        break;
      case 2048:
        result = Colors.black;
        break;
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: getColor(),
        borderRadius: const BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      child: value != null
          ? Center(
              child: Text(
                value.toString(),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: size / 3,
                ),
              ),
            )
          : null,
    );
  }
}
