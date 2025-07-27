// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gc_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$GCStore on _GCStore, Store {
  late final _$selectedCategoryAtom = Atom(
    name: '_GCStore.selectedCategory',
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

  late final _$_GCStoreActionController = ActionController(
    name: '_GCStore',
    context: context,
  );

  @override
  void changeSelectedCategory(String c) {
    final _$actionInfo = _$_GCStoreActionController.startAction(
      name: '_GCStore.changeSelectedCategory',
    );
    try {
      return super.changeSelectedCategory(c);
    } finally {
      _$_GCStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setFiltersToDefault() {
    final _$actionInfo = _$_GCStoreActionController.startAction(
      name: '_GCStore.setFiltersToDefault',
    );
    try {
      return super.setFiltersToDefault();
    } finally {
      _$_GCStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
selectedCategory: ${selectedCategory}
    ''';
  }
}
