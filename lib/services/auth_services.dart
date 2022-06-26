import 'package:firebase_auth/firebase_auth.dart';
import 'package:shop/core/enums.dart';
import 'package:shop/core/extensions/system_feedback.dart';

import 'service_base.dart';

class AuthServices extends ServiceBase {
  UserCredential? userCredential;

  signIn({required String email, required String password}) async {
    try {
      userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        'No user found for that email.'.showAlert(alertType: AlertType.Warning);
      } else if (e.code == 'wrong-password') {
        'Wrong password provided for that user.'.showAlert(alertType: AlertType.Error);
      }
    }
    notifyListeners();
  }

  signUp({required String email, required String password}) async {
    try {
      userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        'The password provided is too weak.'.showAlert(alertType: AlertType.Error);
      } else if (e.code == 'email-already-in-use') {
        'The account already exists for that email.'.showAlert(alertType: AlertType.Error);
      }
    } catch (e) {
      print(e);
    }
    notifyListeners();
  }

  logOut() async {
    try {
      await FirebaseAuth.instance.signOut();
    } on FirebaseAuthException catch (e) {
      print(e);
      'The account already exists for that email.'.showAlert(alertType: AlertType.Error);
    } catch (e) {
      e.toString().showAlert(alertType: AlertType.Error);
    }
  }
}
