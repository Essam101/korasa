import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shop/core/db.dart';
import 'package:shop/core/extensions/system_feedback.dart';

class ServiceBase extends ChangeNotifier {
  Db db = new Db();
}
