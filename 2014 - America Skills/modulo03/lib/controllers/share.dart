import 'package:social_share/social_share.dart';

class ShareController {
  static compartilhar(String msg) {
    SocialShare.shareOptions(msg);
  }
}
