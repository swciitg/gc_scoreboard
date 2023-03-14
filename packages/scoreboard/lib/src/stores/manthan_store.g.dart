// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'manthan_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ManthanStore on _ManthanStore, Store {
  late final _$selectedModuleAtom =
      Atom(name: '_ManthanStore.selectedModule', context: context);

  @override
  String get selectedModule {
    _$selectedModuleAtom.reportRead();
    return super.selectedModule;
  }

  @override
  set selectedModule(String value) {
    _$selectedModuleAtom.reportWrite(value, super.selectedModule, () {
      super.selectedModule = value;
    });
  }

  late final _$selectedEventAtom =
      Atom(name: '_ManthanStore.selectedEvent', context: context);

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

  late final _$_ManthanStoreActionController =
      ActionController(name: '_ManthanStore', context: context);

  @override
  void setFiltersToDefault() {
    final _$actionInfo = _$_ManthanStoreActionController.startAction(
        name: '_ManthanStore.setFiltersToDefault');
    try {
      return super.setFiltersToDefault();
    } finally {
      _$_ManthanStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeSelectedEvent(String e) {
    final _$actionInfo = _$_ManthanStoreActionController.startAction(
        name: '_ManthanStore.changeSelectedEvent');
    try {
      return super.changeSelectedEvent(e);
    } finally {
      _$_ManthanStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void changeSelectedModule(String c) {
    final _$actionInfo = _$_ManthanStoreActionController.startAction(
        name: '_ManthanStore.changeSelectedModule');
    try {
      return super.changeSelectedModule(c);
    } finally {
      _$_ManthanStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
selectedModule: ${selectedModule},
selectedEvent: ${selectedEvent}
    ''';
  }
}
