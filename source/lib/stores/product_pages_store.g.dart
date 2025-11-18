// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_pages_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ProductPagesStore on _ProductPagesStore, Store {
  Computed<bool>? _$hasAnyComputed;

  @override
  bool get hasAny =>
      (_$hasAnyComputed ??= Computed<bool>(
            () => super.hasAny,
            name: '_ProductPagesStore.hasAny',
          ))
          .value;

  late final _$productPagesAtom = Atom(
    name: '_ProductPagesStore.productPages',
    context: context,
  );

  @override
  ObservableList<ProductPagesModel> get productPages {
    _$productPagesAtom.reportRead();
    return super.productPages;
  }

  @override
  set productPages(ObservableList<ProductPagesModel> value) {
    _$productPagesAtom.reportWrite(value, super.productPages, () {
      super.productPages = value;
    });
  }

  late final _$loadAsyncAction = AsyncAction(
    '_ProductPagesStore.load',
    context: context,
  );

  @override
  Future<ProductPagesModel?> load(String productId, String language) {
    return _$loadAsyncAction.run(() => super.load(productId, language));
  }

  late final _$_ProductPagesStoreActionController = ActionController(
    name: '_ProductPagesStore',
    context: context,
  );

  @override
  void add(ProductPagesModel model) {
    final _$actionInfo = _$_ProductPagesStoreActionController.startAction(
      name: '_ProductPagesStore.add',
    );
    try {
      return super.add(model);
    } finally {
      _$_ProductPagesStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void update(ProductPagesModel model) {
    final _$actionInfo = _$_ProductPagesStoreActionController.startAction(
      name: '_ProductPagesStore.update',
    );
    try {
      return super.update(model);
    } finally {
      _$_ProductPagesStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
productPages: ${productPages},
hasAny: ${hasAny}
    ''';
  }
}
