import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shop/core/enums.dart';
import 'package:shop/core/system_feedback.dart';

import 'service_base.dart';

class AuthServices extends ServiceBase {
  Future<UserCredential> signIn({required String email, required String password}) async {
    var userCredential;
    try {
      userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        systemFeedBack.showAlert(alertType: AlertType.Warning, massage: 'No user found for that email.');
      } else if (e.code == 'wrong-password') {
        systemFeedBack.showAlert(alertType: AlertType.Error, massage: 'Wrong password provided for that user.');
      }
    }
    return userCredential;
  }

  Future<UserCredential> signUp({required String email, required String password}) async {
    var userCredential;
    try {
      userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        systemFeedBack.showAlert(alertType: AlertType.Error, massage: 'The password provided is too weak.');
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        systemFeedBack.showAlert(alertType: AlertType.Error, massage: 'The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
    return userCredential;
  }

  logOut() async {
    try {
      await FirebaseAuth.instance.signOut();
    } on FirebaseAuthException catch (e) {
      systemFeedBack.showAlert(alertType: AlertType.Error, massage: 'The account already exists for that email.');
    } catch (e) {
      systemFeedBack.showAlert(alertType: AlertType.Error, massage: e.toString());
    }
  }
}
