import 'package:flutter/material.dart';
import 'package:modulo05/styles/styles.dart';

class ContainerHome {
  static gerar(width, palavras, fonteTitulo, icone, numPalavra, corSecundaria,
      corDeFundo) {
    return Container(
      width: width * .45,
      height: width * .45,
      decoration: BoxDecoration(
        color: corDeFundo,
        border: Border.all(color: corSecundaria),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: corSecundaria,
            blurRadius: 1,
            offset: const Offset(1, 1),
          )
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icone, size: 50, color: corSecundaria),
          Text(
            palavras[0][numPalavra],
            style: TextStyle(
                fontFamily: Fontes.fonte,
                fontSize: fonteTitulo,
                color: corSecundaria),
          ),
        ],
      ),
    );
  }
}
