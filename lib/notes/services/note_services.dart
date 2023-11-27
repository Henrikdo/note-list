import 'dart:developer' as dev;
import 'package:shared_preferences/shared_preferences.dart';

class NoteServices {
  static const String _keyPrefix = 'notes';
  static const String _allKeysKey = 'allStringKeys';

  Future<void> saveString(String value) async {
    final prefs = await SharedPreferences.getInstance();
    final uniqueKey = '$_keyPrefix${DateTime.now().millisecondsSinceEpoch}';
    await prefs.setString(uniqueKey, value);
    final allKeys = prefs.getStringList(_allKeysKey) ?? [];
    allKeys.add(uniqueKey);
    await prefs.setStringList(_allKeysKey, allKeys);
  }

  Future<List<String>> getAllStrings() async {
    final prefs = await SharedPreferences.getInstance();
    final allKeys = prefs.getStringList(_allKeysKey) ?? [];
    final allStrings = <String>[];
    for (final key in allKeys) {
      final value = prefs.getString(key);
      if (value != null) {
        allStrings.add(value);
      }
    }
    return allStrings;
  }

  Future<void> removeString(String value) async {
    final prefs = await SharedPreferences.getInstance();
    final allKeys = prefs.getStringList(_allKeysKey) ?? [];

    // Remove a chave correspondente à string
    final keyToRemove = allKeys.firstWhere((key) {
      final storedValue = prefs.getString(key);
      return storedValue == value;
    }, orElse: () => '');

    if (keyToRemove.isNotEmpty) {
      await prefs.remove(keyToRemove);
      allKeys.remove(keyToRemove);
      await prefs.setStringList(_allKeysKey, allKeys);
    }
  }

  Future<bool> editString(int index, String newValue) async {
    final prefs = await SharedPreferences.getInstance();
    final key = prefs.getStringList(_allKeysKey)?[index];

    if (key != null) {
      dev.log('im setting key: $key of index $index a new value of : $newValue');
      await prefs.setString(key, newValue);
      return true;
    }
    return false;
  }
}
