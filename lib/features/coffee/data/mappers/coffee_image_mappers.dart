import 'package:fav_coffee/features/coffee/data/data_sources/local/local.dart';
import 'package:fav_coffee/features/coffee/domain/domain.dart';

extension CoffeeImageDomainMapper on CoffeeImage {
  CoffeeImageLocal toLocal() => CoffeeImageLocal(
    id: id,
    bytes: bytes,
  );
}

extension CoffeeImageLocalMapper on CoffeeImageLocal {
  CoffeeImage toDomain() => CoffeeImage(
    id: id,
    bytes: bytes,
  );
}
