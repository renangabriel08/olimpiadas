import 'package:flutter/material.dart';
import 'package:modulo03/models/user.dart';
import 'package:modulo03/styles/styles.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    print(User.user);
    print(TimeOfDay.now().period);

    return Scaffold(
      body: Container(
        width: width,
        height: height,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Textos.txt1('Inicio', TextAlign.start, Cores.verde3),
                  IconButton(
                    onPressed: () => Navigator.pushNamed(context, '/login'),
                    icon: Icon(
                      Icons.logout,
                      color: Cores.verde3,
                    ),
                  ),
                ],
              ),
              // ignore: prefer_const_constructors
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [],
              ),
              Row(
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(999),
                      border: Border.all(width: 3, color: Cores.verde3),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(999),
                      child: Image.network(User.user!['fotoPerfil']),
                    ),
                  ),
                  Container(width: width * .03),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      User.user!['http://schemas.microsoft.com/ws/2008/06/identity/claims/role'] !=
                              'Comum'
                          ? const Icon(Icons.crop)
                          : Container(),
                      Textos.txt1(
                        User.user!['name'],
                        TextAlign.start,
                        Cores.verde3,
                      ),
                      Textos.txt1(
                        User.user!['email'],
                        TextAlign.start,
                        Cores.verde3,
                      ),
                      Textos.txt1(
                        User.user!['dr'],
                        TextAlign.start,
                        Cores.verde3,
                      ),
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
