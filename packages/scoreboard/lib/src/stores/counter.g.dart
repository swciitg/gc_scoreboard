// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'counter.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CounterStore on Counter, Store {
  late final _$lAtom = Atom(name: 'Counter.l', context: context);

  @override
  ObservableList<int> get l {
    _$lAtom.reportRead();
    return super.l;
  }

  @override
  set l(ObservableList<int> value) {
    _$lAtom.reportWrite(value, super.l, () {
      super.l = value;
    });
  }

  late final _$resultFieldsAtom =
      Atom(name: 'Counter.resultFields', context: context);

  @override
  ObservableList<NullableResultModel> get resultFields {
    _$resultFieldsAtom.reportRead();
    return super.resultFields;
  }

  @override
  set resultFields(ObservableList<NullableResultModel> value) {
    _$resultFieldsAtom.reportWrite(value, super.resultFields, () {
      super.resultFields = value;
    });
  }

  late final _$CounterActionController =
      ActionController(name: 'Counter', context: context);

  @override
  void addSame(int value) {
    final _$actionInfo =
        _$CounterActionController.startAction(name: 'Counter.addSame');
    try {
      return super.addSame(value);
    } finally {
      _$CounterActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addTie(int position) {
    final _$actionInfo =
        _$CounterActionController.startAction(name: 'Counter.addTie');
    try {
      return super.addTie(position);
    } finally {
      _$CounterActionController.endAction(_$actionInfo);
    }
  }

  @override
  void removeSame(int index) {
    final _$actionInfo =
        _$CounterActionController.startAction(name: 'Counter.removeSame');
    try {
      return super.removeSame(index);
    } finally {
      _$CounterActionController.endAction(_$actionInfo);
    }
  }

  @override
  void removePosition(int index) {
    final _$actionInfo =
        _$CounterActionController.startAction(name: 'Counter.removePosition');
    try {
      return super.removePosition(index);
    } finally {
      _$CounterActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addDifferent(int value) {
    final _$actionInfo =
        _$CounterActionController.startAction(name: 'Counter.addDifferent');
    try {
      return super.addDifferent(value);
    } finally {
      _$CounterActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addNewPosition(int value) {
    final _$actionInfo =
        _$CounterActionController.startAction(name: 'Counter.addNewPosition');
    try {
      return super.addNewPosition(value);
    } finally {
      _$CounterActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
l: ${l},
resultFields: ${resultFields}
    ''';
  }
}
