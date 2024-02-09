import 'package:flutter/material.dart';
import 'package:modulo04/styles/styles.dart';

class ForcaSenha {
  static returnForte(width) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: width * .19,
          height: 7,
          decoration: BoxDecoration(
            color: Cores.vermelho,
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(10),
              topLeft: Radius.circular(10),
            ),
          ),
        ),
        Container(
          width: width * .19,
          height: 7,
          color: Cores.amarelo,
        ),
        Container(
          width: width * .19,
          height: 7,
          color: Cores.azul,
        ),
        Container(
          width: width * .19,
          height: 7,
          decoration: BoxDecoration(
            color: Cores.verde,
            borderRadius: const BorderRadius.only(
              bottomRight: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          ),
        )
      ],
    );
  }

  static returnFraca(width) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: width * .19,
          height: 7,
          decoration: BoxDecoration(
            color: Cores.vermelho,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ],
    );
  }

  static returnMedia(width) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: width * .19,
          height: 7,
          decoration: BoxDecoration(
            color: Cores.vermelho,
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(10),
              topLeft: Radius.circular(10),
            ),
          ),
        ),
        Container(
          width: width * .19,
          height: 7,
          decoration: BoxDecoration(
            color: Cores.amarelo,
            borderRadius: const BorderRadius.only(
              bottomRight: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          ),
        )
      ],
    );
  }

  static returnBoa(width) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: width * .19,
          height: 7,
          decoration: BoxDecoration(
            color: Cores.vermelho,
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(10),
              topLeft: Radius.circular(10),
            ),
          ),
        ),
        Container(
          width: width * .19,
          height: 7,
          color: Cores.amarelo,
        ),
        Container(
          width: width * .19,
          height: 7,
          decoration: BoxDecoration(
            color: Cores.azul,
            borderRadius: const BorderRadius.only(
              bottomRight: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          ),
        )
      ],
    );
  }
}
