
extension CachingKeys on String {
  static const store = "store";
  static const stores = "stores";

  static const page = "page";
  static const pages = "pages";

  static const user = "user";
  static const storeUsers = "storeUsers";
  static const storeEmployees = "storeEmployees";
  static const allUsers = "AllUsers";

  static const customer = "customer";
  static const storeCustomers = "storeCustomers";

  static const isLoggedIn = "isLoggedIn";
  static const customerPages = "customerPages";

  String addIdToKey({required String id}) {
    return "${this + '_' + id}";
  }
}
