import 'package:flutter/material.dart';
import 'package:shop/core/size_config.dart';

class AddStaffForm extends StatefulWidget {
  const AddStaffForm({Key? key}) : super(key: key);

  @override
  State<AddStaffForm> createState() => _AddStaffFormState();
}

class _AddStaffFormState extends State<AddStaffForm> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: getProportionateScreenHeight(1500),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Text('Modal BottomSheet'),
            ElevatedButton(
              child: const Text('Close BottomSheet'),
              onPressed: () => Navigator.pop(context),
            )
          ],
        ),
      ),
    );
  }
}
