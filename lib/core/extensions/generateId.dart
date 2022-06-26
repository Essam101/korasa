import 'package:uuid/uuid.dart';

// Create a custom
extension GenerateId on String {
  String generateId() {
    return new Uuid().v5(Uuid.NAMESPACE_URL, this);
  }
}
