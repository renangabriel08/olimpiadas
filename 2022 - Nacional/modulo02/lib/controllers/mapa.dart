import 'package:geolocator/geolocator.dart';
import 'package:modulo02/widgets/toast.dart';

class MapaController {
  static double latitude = 0.0;
  static double longitude = 0.0;

  static Future<Position> posicaoAtal() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      MyToast.gerar('Serviços de localização desativados');
      return Future.error('Serviços de localização desativados.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        MyToast.gerar('As permissões de localização foram negadas');
        return Future.error('As permissões de localização foram negadas');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      MyToast.gerar(
        'As permissões de localização foram negadas permanentemente, não podemos solicitar permissões',
      );
      return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.',
      );
    }

    return await Geolocator.getCurrentPosition();
  }
}
