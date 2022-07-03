import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/core/extensions/generateId.dart';
import 'package:shop/models/customerModel.dart';
import 'package:shop/screens/customer/state_management/customre_state.dart';
import 'package:shop/screens/navigation/navigation_screen.dart';

import '../../../components/custom_surfix_icon.dart';
import '../../../components/default_button.dart';
import '../../../components/form_error.dart';
import '../../../core/collectionsNames.dart';
import '../../../core/constants.dart';
import '../../../core/size_config.dart';
import '../../home/home_screen.dart';

class AddCustomerForm extends StatefulWidget {
  @override
  _AddCustomerFormState createState() => _AddCustomerFormState();
}

class _AddCustomerFormState extends State<AddCustomerForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> errors = [];

  late String customerName;

  late String customerNotes;

  void addError({String? error}) {
    if (!errors.contains(error))
      setState(() {
        errors.add(error!);
      });
  }

  void removeError({String? error}) {
    if (errors.contains(error))
      setState(() {
        errors.remove(error);
      });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          children: [
            SizedBox(height: getProportionateScreenHeight(30)),
            buildCustomerNameField(),
            SizedBox(height: getProportionateScreenHeight(30)),
            buildCustomerNotesField(),
            FormError(errors: errors),
            SizedBox(height: getProportionateScreenHeight(40)),
            DefaultButton(
              text: "Add Customer",
              press: () async {
                if (_formKey.currentState!.validate()) {
                  Provider.of<CustomerState>(context, listen: false)
                      .createCustomer(
                          model: new CustomerModel(
                              creationDate: new DateTime.now().toString(),
                              customerId: CollectionsNames.customers.generateId(),
                              name: customerName,
                              notes: customerNotes,
                              storeId: ''))
                      .then((value) => {if (value) Navigator.pop(context)});
                }
              },
            ),
          ],
        ));
  }

  TextFormField buildCustomerNameField() {
    return TextFormField(
      onSaved: (newValue) {
        if (newValue != null) {
          this.customerName = newValue;
        }
      },
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kNamelNullError);
        }
        this.customerName = value;
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kNamelNullError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Customer Name",
        hintText: "Enter Customer Name",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
      ),
    );
  }

  TextFormField buildCustomerNotesField() {
    return TextFormField(
      onSaved: (newValue) {
        if (newValue != null) {
          this.customerNotes = newValue;
        }
      },
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kNamelNullError);
        }
        customerNotes = value;
        return null;
      },
      decoration: InputDecoration(
        labelText: "Customer Notes",
        hintText: "You Can Add  notes ",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
      maxLines: 8,
    );
  }
}
