import 'package:fav_coffee/app/app.dart';
import 'package:fav_coffee/bootstrap.dart';

Future<void> main() async {
  await bootstrap(() => const App());
}
