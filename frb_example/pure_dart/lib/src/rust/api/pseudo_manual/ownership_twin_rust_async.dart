// This file is automatically generated, so please do not edit it.
// Generated by `flutter_rust_bridge`@ 2.0.0-dev.34.

// ignore_for_file: invalid_use_of_internal_member, unused_import, unnecessary_import

import '../../frb_generated.dart';
import 'package:flutter_rust_bridge/flutter_rust_bridge_for_generated.dart';

Future<String> borrowStringTwinRustAsync({required String arg, dynamic hint}) =>
    RustLib.instance.api
        .crateApiPseudoManualOwnershipTwinRustAsyncBorrowStringTwinRustAsync(
            arg: arg, hint: hint);

Future<String> borrowStrTwinRustAsync({required String arg, dynamic hint}) =>
    RustLib.instance.api
        .crateApiPseudoManualOwnershipTwinRustAsyncBorrowStrTwinRustAsync(
            arg: arg, hint: hint);

Future<int> borrowI32TwinRustAsync({required int arg, dynamic hint}) =>
    RustLib.instance.api
        .crateApiPseudoManualOwnershipTwinRustAsyncBorrowI32TwinRustAsync(
            arg: arg, hint: hint);

Future<SimpleStructForBorrowTwinRustAsync> borrowStructTwinRustAsync(
        {required SimpleStructForBorrowTwinRustAsync arg, dynamic hint}) =>
    RustLib.instance.api
        .crateApiPseudoManualOwnershipTwinRustAsyncBorrowStructTwinRustAsync(
            arg: arg, hint: hint);

class SimpleStructForBorrowTwinRustAsync {
  final String one;

  const SimpleStructForBorrowTwinRustAsync({
    required this.one,
  });

  @override
  int get hashCode => one.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SimpleStructForBorrowTwinRustAsync &&
          runtimeType == other.runtimeType &&
          one == other.one;
}