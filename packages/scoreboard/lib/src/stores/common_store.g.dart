// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'common_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CommonStore on _CommonStore, Store {
  late final _$competitionAtom =
      Atom(name: '_CommonStore.competition', context: context);

  @override
  Competitions get competition {
    _$competitionAtom.reportRead();
    return super.competition;
  }

  @override
  set competition(Competitions value) {
    _$competitionAtom.reportWrite(value, super.competition, () {
      super.competition = value;
    });
  }

  late final _$pageAtom = Atom(name: '_CommonStore.page', context: context);

  @override
  Pages get page {
    _$pageAtom.reportRead();
    return super.page;
  }

  @override
  set page(Pages value) {
    _$pageAtom.reportWrite(value, super.page, () {
      super.page = value;
    });
  }

  late final _$viewTypeAtom =
      Atom(name: '_CommonStore.viewType', context: context);

  @override
  ViewType get viewType {
    _$viewTypeAtom.reportRead();
    return super.viewType;
  }

  @override
  set viewType(ViewType value) {
    _$viewTypeAtom.reportWrite(value, super.viewType, () {
      super.viewType = value;
    });
  }

  late final _$selectedCategoryAtom =
      Atom(name: '_CommonStore.selectedCategory', context: context);

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

  late final _$selectedHostelAtom =
      Atom(name: '_CommonStore.selectedHostel', context: context);

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

  late final _$selectedDateAtom =
      Atom(name: '_CommonStore.selectedDate', context: context);

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

  late final _$selectedEventAtom =
      Atom(name: '_CommonStore.selectedEvent', context: context);

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

  late final _$_CommonStoreActionController =
      ActionController(name: '_CommonStore', context: context);

  @override
  void setCompetition(Competitions c) {
    final _$actionInfo = _$_CommonStoreActionController.startAction(
        name: '_CommonStore.setCompetition');
    try {
      return super.setCompetition(c);
    } finally {
      _$_CommonStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setPage(Pages p) {
    final _$actionInfo = _$_CommonStoreActionController.startAction(
        name: '_CommonStore.setPage');
    try {
      return super.setPage(p);
    } finally {
      _$_CommonStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setViewType(ViewType v) {
    final _$actionInfo = _$_CommonStoreActionController.startAction(
        name: '_CommonStore.setViewType');
    try {
      return super.setViewType(v);
    } finally {
      _$_CommonStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeSelectedCategory(String c) {
    final _$actionInfo = _$_CommonStoreActionController.startAction(
        name: '_CommonStore.changeSelectedCategory');
    try {
      return super.changeSelectedCategory(c);
    } finally {
      _$_CommonStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeSelectedHostel(String h) {
    final _$actionInfo = _$_CommonStoreActionController.startAction(
        name: '_CommonStore.changeSelectedHostel');
    try {
      return super.changeSelectedHostel(h);
    } finally {
      _$_CommonStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeSelectedDate(String d) {
    final _$actionInfo = _$_CommonStoreActionController.startAction(
        name: '_CommonStore.changeSelectedDate');
    try {
      return super.changeSelectedDate(d);
    } finally {
      _$_CommonStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeSelectedEvent(String e) {
    final _$actionInfo = _$_CommonStoreActionController.startAction(
        name: '_CommonStore.changeSelectedEvent');
    try {
      return super.changeSelectedEvent(e);
    } finally {
      _$_CommonStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
competition: ${competition},
page: ${page},
viewType: ${viewType},
selectedCategory: ${selectedCategory},
selectedHostel: ${selectedHostel},
selectedDate: ${selectedDate},
selectedEvent: ${selectedEvent}
    ''';
  }
}
