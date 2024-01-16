import 'package:flutter/material.dart';
import 'package:modulo05/styles/styles.dart';

class ContainerHome {
  static gerar(
    width,
    palavras,
    fonteTitulo,
    icone,
    numPalavra,
    corSecundaria,
    corDeFundo,
  ) {
    corDeFundo ??= Colors.white;
    corSecundaria ??= Cores.cinza;
    return Container(
      width: width * .49,
      height: width * .49,
      decoration: BoxDecoration(
        color: corDeFundo,
        border: Border.all(color: Colors.black),
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
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: Fontes.fonte,
              fontSize: fonteTitulo,
              color: corSecundaria,
            ),
          ),
        ],
      ),
    );
  }
}
