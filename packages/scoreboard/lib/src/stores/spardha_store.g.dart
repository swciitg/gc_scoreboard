// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'spardha_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$SpardhaStore on _SpardhaStore, Store {
  late final _$selectedCategoryAtom = Atom(
    name: '_SpardhaStore.selectedCategory',
    context: context,
  );

  @override
  Category get selectedCategory {
    _$selectedCategoryAtom.reportRead();
    return super.selectedCategory;
  }

  @override
  set selectedCategory(Category value) {
    _$selectedCategoryAtom.reportWrite(value, super.selectedCategory, () {
      super.selectedCategory = value;
    });
  }

  late final _$selectedHostelAtom = Atom(
    name: '_SpardhaStore.selectedHostel',
    context: context,
  );

  @override
  Hostel get selectedHostel {
    _$selectedHostelAtom.reportRead();
    return super.selectedHostel;
  }

  @override
  set selectedHostel(Hostel value) {
    _$selectedHostelAtom.reportWrite(value, super.selectedHostel, () {
      super.selectedHostel = value;
    });
  }

  late final _$selectedDateAtom = Atom(
    name: '_SpardhaStore.selectedDate',
    context: context,
  );

  @override
  String get selectedDate {
    _$selectedDateAtom.reportRead();
    return super.selectedDate;
  }

  @override
  set selectedDate(String value) {
    _$selectedDateAtom.reportWrite(value, super.selectedDate, () {
      super.selectedDate = value;
    });
  }

  late final _$selectedEventAtom = Atom(
    name: '_SpardhaStore.selectedEvent',
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

  late final _$_SpardhaStoreActionController = ActionController(
    name: '_SpardhaStore',
    context: context,
  );

  @override
  void setFiltersToDefault() {
    final _$actionInfo = _$_SpardhaStoreActionController.startAction(
      name: '_SpardhaStore.setFiltersToDefault',
    );
    try {
      return super.setFiltersToDefault();
    } finally {
      _$_SpardhaStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeSelectedCategory(String c) {
    final _$actionInfo = _$_SpardhaStoreActionController.startAction(
      name: '_SpardhaStore.changeSelectedCategory',
    );
    try {
      return super.changeSelectedCategory(c);
    } finally {
      _$_SpardhaStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeSelectedHostel(String h) {
    final _$actionInfo = _$_SpardhaStoreActionController.startAction(
      name: '_SpardhaStore.changeSelectedHostel',
    );
    try {
      return super.changeSelectedHostel(h);
    } finally {
      _$_SpardhaStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeSelectedDate(String d) {
    final _$actionInfo = _$_SpardhaStoreActionController.startAction(
      name: '_SpardhaStore.changeSelectedDate',
    );
    try {
      return super.changeSelectedDate(d);
    } finally {
      _$_SpardhaStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void makeSelectedDateEmpty() {
    final _$actionInfo = _$_SpardhaStoreActionController.startAction(
      name: '_SpardhaStore.makeSelectedDateEmpty',
    );
    try {
      return super.makeSelectedDateEmpty();
    } finally {
      _$_SpardhaStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeSelectedEvent(String e) {
    final _$actionInfo = _$_SpardhaStoreActionController.startAction(
      name: '_SpardhaStore.changeSelectedEvent',
    );
    try {
      return super.changeSelectedEvent(e);
    } finally {
      _$_SpardhaStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
selectedCategory: ${selectedCategory},
selectedHostel: ${selectedHostel},
selectedDate: ${selectedDate},
selectedEvent: ${selectedEvent}
    ''';
  }
}
