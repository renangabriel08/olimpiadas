import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:modulo03/controllers/login.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map<String, dynamic> user = {};

  @override
  void initState() {
    user = JwtDecoder.decode(LoginController.token);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    print(user);

    return Scaffold(
      body: Container(
        width: width,
        height: height,
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: ClipRRect(
                    child: Image.network(user['fotoPerfil']),
                    borderRadius: BorderRadius.circular(999),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
