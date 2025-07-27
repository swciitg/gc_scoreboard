// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sahyog_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$SahyogStore on _SahyogStore, Store {
  late final _$selectedClubAtom = Atom(
    name: '_SahyogStore.selectedClub',
    context: context,
  );

  @override
  SahyogClub get selectedClub {
    _$selectedClubAtom.reportRead();
    return super.selectedClub;
  }

  @override
  set selectedClub(SahyogClub value) {
    _$selectedClubAtom.reportWrite(value, super.selectedClub, () {
      super.selectedClub = value;
    });
  }

  late final _$selectedEventAtom = Atom(
    name: '_SahyogStore.selectedEvent',
    context: context,
  );

  @override
  String get selectedEvent {
    _$selectedEventAtom.reportRead();
    return super.selectedEvent;
  }

  @override
  set selectedEvent(String value) {
    _$selectedEventAtom.reportWrite(value, super.selectedEvent, () {
      super.selectedEvent = value;
    });
  }

  late final _$difficultyAtom = Atom(
    name: '_SahyogStore.difficulty',
    context: context,
  );

  @override
  String get difficulty {
    _$difficultyAtom.reportRead();
    return super.difficulty;
  }

  @override
  set difficulty(String value) {
    _$difficultyAtom.reportWrite(value, super.difficulty, () {
      super.difficulty = value;
    });
  }

  late final _$_SahyogStoreActionController = ActionController(
    name: '_SahyogStore',
    context: context,
  );

  @override
  void setFiltersToDefault() {
    final _$actionInfo = _$_SahyogStoreActionController.startAction(
      name: '_SahyogStore.setFiltersToDefault',
    );
    try {
      return super.setFiltersToDefault();
    } finally {
      _$_SahyogStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeSelectedEvent(String e) {
    final _$actionInfo = _$_SahyogStoreActionController.startAction(
      name: '_SahyogStore.changeSelectedEvent',
    );
    try {
      return super.changeSelectedEvent(e);
    } finally {
      _$_SahyogStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeDifficulty(String e) {
    final _$actionInfo = _$_SahyogStoreActionController.startAction(
      name: '_SahyogStore.changeDifficulty',
    );
    try {
      return super.changeDifficulty(e);
    } finally {
      _$_SahyogStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeSelectedClub(String c) {
    final _$actionInfo = _$_SahyogStoreActionController.startAction(
      name: '_SahyogStore.changeSelectedClub',
    );
    try {
      return super.changeSelectedClub(c);
    } finally {
      _$_SahyogStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
selectedClub: ${selectedClub},
selectedEvent: ${selectedEvent},
difficulty: ${difficulty}
    ''';
  }
}
