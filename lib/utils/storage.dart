import 'package:get_storage/get_storage.dart';

class GameStorage {
  GetStorage storage = GetStorage("game");
  int get highscore {
    int value = storage.read("highscore");
    if (value == null) {
      setHighscore(0);
      return 0;
    } else {
      return value;
    }
  }

  void setHighscore(int value) async => await storage.write("highscore", value);
}

class SettingStorage {
  GetStorage storage = GetStorage("setting");
  bool get isDark => storage.read("isDark") ?? false;

  void setIsDark(bool value) => storage.write("isDark", value);
}
