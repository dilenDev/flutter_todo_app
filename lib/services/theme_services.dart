import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ThemeServices {
  final _box = GetStorage();
  final _key = 'isDarkMode'; //? initially this key has no value
  _saveThemeToBox(bool isDarkMode) => _box.write(_key, isDarkMode);

  //? if there is a value it return the value, if there isnt any value it keep the default value
  bool _loadThemeFromBox() => _box.read(_key) ?? false;

  //? get value
  ThemeMode get theme => _loadThemeFromBox() ? ThemeMode.dark : ThemeMode.light;

  void switchTheme() {
    Get.changeThemeMode(_loadThemeFromBox() ? ThemeMode.light : ThemeMode.dark);
    _saveThemeToBox(!_loadThemeFromBox());
  }
}
