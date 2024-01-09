import 'package:social_share/social_share.dart';

class Share {
  static compartilhar(porcentagem, bool personalizada, tipoPartida) {
    try {
      String perso = 'personalizada';
      personalizada ? perso = 'personalizada' : 'padrão';

      SocialShare.shareOptions(
        "Acertei $porcentagem% em uma partida $perso ${tipoPartida.toString().toLowerCase()} no Stroop! Vem jogar também!",
      );
    } catch (e) {
      print(e);
    }
  }
}
