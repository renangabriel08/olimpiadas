import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:modulo04/pages/inicio.dart';

class ApiController {
  static logar(String email, String senha, context) async {
    try {
      final url = Uri.parse(
        'https://apieuvounatrip.azurewebsites.net/api/Usuarios/Login?email=$email&senha=$senha',
      );

      final req = await http.post(url);

      if (req.statusCode == 200) {
        final res = jsonDecode(utf8.decode(req.bodyBytes));
        Navigator.pushNamed(
          context,
          Inicio.routeName,
          arguments: ScreenArguments(
            res['token'],
          ),
        );
      }
    } catch (e) {}
  }

  static Future<Map<String, dynamic>> getUser(String token) async {
    Map<String, dynamic> decodedToken = JwtDecoder.decode(token);

    return decodedToken;
  }
}
