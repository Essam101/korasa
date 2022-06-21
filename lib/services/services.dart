import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import 'auth_services.dart';

class Services {
  final BuildContext context;

  Services(this.context);

  List<SingleChildWidget> providers() {
    return [
      Provider<AuthServices>(create: (context) => AuthServices()),
    ];
  }
}
