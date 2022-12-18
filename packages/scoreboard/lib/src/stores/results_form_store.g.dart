// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'results_form_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ResultsFormStore on ResultsFormStoreBase, Store {
  late final _$resultFieldsAtom =
      Atom(name: 'ResultsFormStoreBase.resultFields', context: context);

  @override
  ObservableList<NullableResultModel>? get resultFields {
    _$resultFieldsAtom.reportRead();
    return super.resultFields;
  }

  @override
  set resultFields(ObservableList<NullableResultModel>? value) {
    _$resultFieldsAtom.reportWrite(value, super.resultFields, () {
      super.resultFields = value;
    });
  }

  late final _$ResultsFormStoreBaseActionController =
      ActionController(name: 'ResultsFormStoreBase', context: context);

  @override
  void addTie(int position) {
    final _$actionInfo = _$ResultsFormStoreBaseActionController.startAction(
        name: 'ResultsFormStoreBase.addTie');
    try {
      return super.addTie(position);
    } finally {
      _$ResultsFormStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void removePosition(int index) {
    final _$actionInfo = _$ResultsFormStoreBaseActionController.startAction(
        name: 'ResultsFormStoreBase.removePosition');
    try {
      return super.removePosition(index);
    } finally {
      _$ResultsFormStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addNewPosition(int? value) {
    final _$actionInfo = _$ResultsFormStoreBaseActionController.startAction(
        name: 'ResultsFormStoreBase.addNewPosition');
    try {
      return super.addNewPosition(value);
    } finally {
      _$ResultsFormStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
resultFields: ${resultFields}
    ''';
  }
}
