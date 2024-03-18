import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:modulo04/pages/inicio.dart';
import 'package:modulo04/widgets/toast.dart';

class Biometria {
  static final LocalAuthentication auth = LocalAuthentication();

  static logar(context) async {
    try {
      final bool compativel = await auth.canCheckBiometrics;
      if (compativel) {
        final List biometrias = await auth.getAvailableBiometrics();
        if (biometrias.isNotEmpty) {
          final bool didAuthenticate = await auth.authenticate(
            localizedReason: 'Entre utilizando biometria',
          );
          if (didAuthenticate) {
            Navigator.pushNamed(
              context,
              Inicio.routeName,
              arguments: ScreenArguments(
                'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy5taWNyb3NvZnQuY29tL3dzLzIwMDgvMDYvaWRlbnRpdHkvY2xhaW1zL3JvbGUiOiJDb211bSIsImlkVXN1YXJpbyI6IjIyIiwiZHIiOiJTUCIsImZvdG9QZXJmaWwiOiJodHRwczovL3JhbmRvbXVzZXIubWUvYXBpL3BvcnRyYWl0cy9tZW4vNzUuanBnIiwiZW1haWwiOiJ0ZXN0ZUBnbWFpbC5jb20iLCJuYW1lIjoidGVzdGUiLCJleHAiOjE3MDQ1NjU3MTksImlzcyI6InByb2pldG8ud2ViQVBJIiwiYXVkIjoicHJvamV0by53ZWJBUEkifQ.kZOVRl4bLYboz838DRS9v6cFeyAiyeWhK_XQI___-oA',
              ),
            );
          } else {
            MyToast.gerarToast('Biometria inválida');
          }
        } else {
          MyToast.gerarToast('Sem biometria cadastrada');
        }
      } else {
        MyToast.gerarToast('Dispositivo não compatível com biometria');
      }
    } catch (e) {
      MyToast.gerarToast('Erro ao logar com biometria');
    }
  }
}
