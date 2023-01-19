// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kriti_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$KritiStore on _KritiStore, Store {
  late final _$selectedCupAtom =
      Atom(name: '_KritiStore.selectedCup', context: context);

  @override
  Cup get selectedCup {
    _$selectedCupAtom.reportRead();
    return super.selectedCup;
  }

  @override
  set selectedCup(Cup value) {
    _$selectedCupAtom.reportWrite(value, super.selectedCup, () {
      super.selectedCup = value;
    });
  }

  late final _$selectedClubAtom =
      Atom(name: '_KritiStore.selectedClub', context: context);

  @override
  Club get selectedClub {
    _$selectedClubAtom.reportRead();
    return super.selectedClub;
  }

  @override
  set selectedClub(Club value) {
    _$selectedClubAtom.reportWrite(value, super.selectedClub, () {
      super.selectedClub = value;
    });
  }

  late final _$_KritiStoreActionController =
      ActionController(name: '_KritiStore', context: context);

  @override
  void setFiltersToDefault() {
    final _$actionInfo = _$_KritiStoreActionController.startAction(
        name: '_KritiStore.setFiltersToDefault');
    try {
      return super.setFiltersToDefault();
    } finally {
      _$_KritiStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeSelectedCup(String c) {
    final _$actionInfo = _$_KritiStoreActionController.startAction(
        name: '_KritiStore.changeSelectedCup');
    try {
      return super.changeSelectedCup(c);
    } finally {
      _$_KritiStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeSelectedClub(String c) {
    final _$actionInfo = _$_KritiStoreActionController.startAction(
        name: '_KritiStore.changeSelectedClub');
    try {
      return super.changeSelectedClub(c);
    } finally {
      _$_KritiStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
selectedCup: ${selectedCup},
selectedClub: ${selectedClub}
    ''';
  }
}
