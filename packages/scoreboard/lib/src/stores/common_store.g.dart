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

  late final _$isSpardhaAdminAtom =
      Atom(name: '_CommonStore.isSpardhaAdmin', context: context);

  @override
  bool get isSpardhaAdmin {
    _$isSpardhaAdminAtom.reportRead();
    return super.isSpardhaAdmin;
  }

  @override
  set isSpardhaAdmin(bool value) {
    _$isSpardhaAdminAtom.reportWrite(value, super.isSpardhaAdmin, () {
      super.isSpardhaAdmin = value;
    });
  }

  late final _$isKritiAdminAtom =
      Atom(name: '_CommonStore.isKritiAdmin', context: context);

  @override
  bool get isKritiAdmin {
    _$isKritiAdminAtom.reportRead();
    return super.isKritiAdmin;
  }

  @override
  set isKritiAdmin(bool value) {
    _$isKritiAdminAtom.reportWrite(value, super.isKritiAdmin, () {
      super.isKritiAdmin = value;
    });
  }

  late final _$isManthanAdminAtom =
      Atom(name: '_CommonStore.isManthanAdmin', context: context);

  @override
  bool get isManthanAdmin {
    _$isManthanAdminAtom.reportRead();
    return super.isManthanAdmin;
  }

  @override
  set isManthanAdmin(bool value) {
    _$isManthanAdminAtom.reportWrite(value, super.isManthanAdmin, () {
      super.isManthanAdmin = value;
    });
  }

  late final _$_CommonStoreActionController =
      ActionController(name: '_CommonStore', context: context);

  @override
  void setCompetition(Competitions c, dynamic competitionStore) {
    final _$actionInfo = _$_CommonStoreActionController.startAction(
        name: '_CommonStore.setCompetition');
    try {
      return super.setCompetition(c, competitionStore);
    } finally {
      _$_CommonStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setPage(Pages p, dynamic competitionStore) {
    final _$actionInfo = _$_CommonStoreActionController.startAction(
        name: '_CommonStore.setPage');
    try {
      return super.setPage(p, competitionStore);
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
  void setAdminNone() {
    final _$actionInfo = _$_CommonStoreActionController.startAction(
        name: '_CommonStore.setAdminNone');
    try {
      return super.setAdminNone();
    } finally {
      _$_CommonStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setSpardhaAdmin(bool input) {
    final _$actionInfo = _$_CommonStoreActionController.startAction(
        name: '_CommonStore.setSpardhaAdmin');
    try {
      return super.setSpardhaAdmin(input);
    } finally {
      _$_CommonStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setKritiAdmin(bool input) {
    final _$actionInfo = _$_CommonStoreActionController.startAction(
        name: '_CommonStore.setKritiAdmin');
    try {
      return super.setKritiAdmin(input);
    } finally {
      _$_CommonStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setManthanAdmin(bool input) {
    final _$actionInfo = _$_CommonStoreActionController.startAction(
        name: '_CommonStore.setManthanAdmin');
    try {
      return super.setManthanAdmin(input);
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
isSpardhaAdmin: ${isSpardhaAdmin},
isKritiAdmin: ${isKritiAdmin},
isManthanAdmin: ${isManthanAdmin}
    ''';
  }
}
