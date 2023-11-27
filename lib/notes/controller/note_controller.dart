import 'package:mobx/mobx.dart';

import 'package:teladelogin/notes/services/note_services.dart';

part 'note_controller.g.dart';

class NoteController = _NoteController with _$NoteController;

abstract class _NoteController with Store {

  final NoteServices _noteServices = NoteServices();

  @observable
  ObservableList<String> strings = ObservableList<String>();

  @action
  Future<void> saveString(String value) async {
    _noteServices.saveString(value);

    loadStrings(); // Atualiza a lista após salvar uma nova string
  }

  @action
  Future<void> loadStrings() async {
    List<String> allStrings = await _noteServices.getAllStrings();
    strings = ObservableList.of(allStrings);
  }

  @action
  Future<void> removeString(String value) async {
    _noteServices.removeString(value);
    loadStrings();
  }

  @action
  Future<void> editString(int index, String newValue) async {
    if (index >= 0 && index < strings.length) {
      bool keyExists = await _noteServices.editString(index, newValue);

      if(keyExists){
        loadStrings();
      }
    }
    
  }
}
