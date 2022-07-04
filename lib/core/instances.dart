import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class Instances {
  FirebaseFirestore db = FirebaseFirestore.instance;

  FirebaseMessaging messaging = FirebaseMessaging.instance;
}
