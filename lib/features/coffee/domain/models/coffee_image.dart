import 'dart:typed_data';

import 'package:equatable/equatable.dart';

class CoffeeImage with EquatableMixin {
  const CoffeeImage({
    required this.id,
    required this.bytes,
  });

  final String id;
  final Uint8List bytes;

  @override
  List<Object?> get props => [id, bytes];
}
