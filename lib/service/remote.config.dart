import 'package:firebase_remote_config/firebase_remote_config.dart';

class RemoteConfigRepo {
  static Future<FirebaseRemoteConfig> setupRemoteConfig() async {
    final FirebaseRemoteConfig remoteConfig = FirebaseRemoteConfig.instance;
    await remoteConfig.fetchAndActivate();
    RemoteConfigValue(null, ValueSource.valueStatic);
    await remoteConfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: const Duration(seconds: 1),
      minimumFetchInterval: const Duration(seconds: 1),
    ));
    return remoteConfig;
  }
}
