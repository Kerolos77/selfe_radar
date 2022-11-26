import 'package:nanoid/nanoid.dart';

class CreateId {
  static String createId() {
    String v1 = nanoid(8);
    return v1;
  }
}