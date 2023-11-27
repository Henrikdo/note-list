import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'note_controller.g.dart';

class NoteController = _NoteController with _$NoteController;

abstract class _NoteController with Store {
  static const String _keyPrefix = 'notes';
  static const String _allKeysKey = 'allStringKeys';
    

  @observable
  ObservableList<String> strings = ObservableList<String>();

  @action
  Future<void> saveString(String value) async {
    final prefs = await SharedPreferences.getInstance();
    final uniqueKey = '$_keyPrefix${DateTime.now().millisecondsSinceEpoch}';
    await prefs.setString(uniqueKey, value);
    final allKeys = prefs.getStringList(_allKeysKey) ?? [];
    allKeys.add(uniqueKey);
    await prefs.setStringList(_allKeysKey, allKeys);

    loadStrings(); // Atualiza a lista após salvar uma nova string
  }

  @action
  Future<void> loadStrings() async {
    final prefs = await SharedPreferences.getInstance();
    final allKeys = prefs.getStringList(_allKeysKey) ?? [];
    final allStrings = <String>[];
    for (final key in allKeys) {
      final value = prefs.getString(key);
      if (value != null) {
        allStrings.add(value);
      }
    }
    strings = ObservableList.of(allStrings);
  }

  @action
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
      loadStrings(); // Atualiza a lista após remover uma string
    }
  }

  @action
  Future<void> editString(int index, String newValue) async {

    if (index >= 0 && index < strings.length) {
      final prefs = await SharedPreferences.getInstance();
      final key = prefs.getStringList(_allKeysKey)?[index];
      
      if (key != null) {
        
        await prefs.setString(key, newValue);
        loadStrings(); // Atualiza a lista após editar uma string
      }
    }
  }
}
