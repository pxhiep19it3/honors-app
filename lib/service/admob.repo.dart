import 'dart:io';

class AdMobRepo {
  static String? get adUnitIdLogined {
    if (Platform.isAndroid) {
      return 'ca-app-pub-9109656601962491/8086270708';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-9109656601962491/5711937543';
    }
    return null;
  }

  static String? get adUnitIdJoin {
    if (Platform.isAndroid) {
      return 'ca-app-pub-9109656601962491/7519843238';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-9109656601962491/7088883803';
    }
    return null;
  }

  static String? get adUnitIdCreateWorkspace {
    if (Platform.isAndroid) {
      return 'ca-app-pub-9109656601962491/2387221468';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-9109656601962491/3700303130';
    }
    return null;
  }

   static String? get adUnitIdRewaredAd {
    if (Platform.isAndroid) {
      return 'ca-app-pub-9109656601962491/4977725788';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-9109656601962491/7136985260';
    }
    return null;
  }
}
