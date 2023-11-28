// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'note_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$NoteController on _NoteController, Store {
  late final _$stringsAtom =
      Atom(name: '_NoteController.strings', context: context);

  @override
  ObservableList<String> get strings {
    _$stringsAtom.reportRead();
    return super.strings;
  }

  @override
  set strings(ObservableList<String> value) {
    _$stringsAtom.reportWrite(value, super.strings, () {
      super.strings = value;
    });
  }

  late final _$saveStringAsyncAction =
      AsyncAction('_NoteController.saveString', context: context);

  @override
  Future<void> saveString(String value) {
    return _$saveStringAsyncAction.run(() => super.saveString(value));
  }

  late final _$loadStringsAsyncAction =
      AsyncAction('_NoteController.loadStrings', context: context);

  @override
  Future<void> loadStrings() {
    return _$loadStringsAsyncAction.run(() => super.loadStrings());
  }

  late final _$removeStringAsyncAction =
      AsyncAction('_NoteController.removeString', context: context);

  @override
  Future<void> removeString(String value) {
    return _$removeStringAsyncAction.run(() => super.removeString(value));
  }

  late final _$editStringAsyncAction =
      AsyncAction('_NoteController.editString', context: context);

  @override
  Future<void> editString(int index, String newValue) {
    return _$editStringAsyncAction.run(() => super.editString(index, newValue));
  }

  @override
  String toString() {
    return '''
strings: ${strings}
    ''';
  }
}
