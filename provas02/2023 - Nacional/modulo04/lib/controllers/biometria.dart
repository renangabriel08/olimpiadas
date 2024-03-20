import 'package:local_auth/local_auth.dart';
import 'package:modulo04/main.dart';

class Biometria {
  static logar() async {
    final LocalAuthentication auth = LocalAuthentication();
    final bool canAuthenticate = await auth.isDeviceSupported();

    if (canAuthenticate) {
      final List<BiometricType> biometrias =
          await auth.getAvailableBiometrics();

      if (biometrias.isNotEmpty) {
        try {
          final bool didAuthenticate = await auth.authenticate(
            localizedReason: 'Autentique-se para entrar no sistema',
          );

          if (didAuthenticate) {
            navKey.currentState!.pushNamed('/inicio');
          }
        } catch (e) {}
      }
    }
  }
}
