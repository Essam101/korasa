import 'package:flutter/material.dart';

import 'package:shop/core/size_config.dart';
import 'package:shop/models/userModel.dart';

class Employee extends StatelessWidget {
  final UserModel userModel;

  const Employee({
    Key? key,
    required this.userModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Color(0xFFF5F6F9), borderRadius: BorderRadius.all(Radius.circular(10))),
      margin: EdgeInsets.all(5),
      child: Column(
        children: [
          ListTile(
            title: Text(userModel.name + "    ${userModel.role}"),
            subtitle: Text(userModel.email),
            leading: Icon(Icons.label),
            trailing: Text("100 \$"),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: OutlinedButton.icon(
                  onPressed: () {
                    // Respond to button press
                  },
                  icon: Icon(Icons.edit, size: 18),
                  label: Text("تعديل  "),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: OutlinedButton.icon(
                  onPressed: () {
                    // Respond to button press
                  },
                  icon: Icon(Icons.delete, size: 18),
                  label: Text("حذف  "),
                ),
              ),
              SizedBox(width: 40),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: OutlinedButton.icon(
                  onPressed: () {
                    // Respond to button press
                  },
                  icon: Icon(Icons.add, size: 18),
                  label: Text("اضافة طلب"),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
