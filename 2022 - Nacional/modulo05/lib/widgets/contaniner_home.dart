import 'package:flutter/material.dart';
import 'package:modulo05/styles/styles.dart';

class ContainerHome {
  static gerar(width, palavras, fonteTitulo, IconData icone, numPalavra) {
    return Container(
      width: width * .45,
      height: width * .45,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Cores.cinza),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Cores.cinza,
            blurRadius: 1,
            offset: const Offset(1, 1),
          )
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icone, size: 50),
          Text(
            palavras[0][numPalavra],
            style: TextStyle(
              fontFamily: Fontes.fonte,
              fontSize: fonteTitulo,
            ),
          ),
        ],
      ),
    );
  }
}
