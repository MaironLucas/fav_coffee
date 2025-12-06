import 'dart:typed_data';

import 'package:equatable/equatable.dart';

class CoffeeImageLocal with EquatableMixin {
  CoffeeImageLocal({
    required this.id,
    required this.bytes,
  });

  final String id;
  final Uint8List bytes;

  @override
  List<Object?> get props => [id, bytes];
}
