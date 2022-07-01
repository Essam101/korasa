import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/core/extensions/generateId.dart';
import 'package:shop/models/customerModel.dart';
import 'package:shop/screens/customer/state_management/add_customre_state.dart';

import '../../../components/custom_surfix_icon.dart';
import '../../../components/default_button.dart';
import '../../../components/form_error.dart';
import '../../../core/collectionsNames.dart';
import '../../../core/constants.dart';
import '../../../core/size_config.dart';
import '../../home/home_screen.dart';

class AddCustomerForm extends StatefulWidget {
  final Function(bool) loading;

  const AddCustomerForm({required this.loading});

  @override
  _AddCustomerFormState createState() => _AddCustomerFormState();
}

class _AddCustomerFormState extends State<AddCustomerForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> errors = [];

  late String customerName;
  late String notes;

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
    return Form(key: _formKey, child: Column(
      children: [
        buildCustomerNameField(),
        SizedBox(height: getProportionateScreenHeight(30)),

        FormError(errors: errors),
        SizedBox(height: getProportionateScreenHeight(40)),

        DefaultButton(
          text: "Add Customer",
          press: () async {
            if (_formKey.currentState!.validate()) {
              Provider.of<AddCustomerState>(context, listen: false)
                  .createCustomer(model: new CustomerModel(
                  customerId: CollectionsNames.customers.generateId(),
                  name: customerName,
                  notes: notes,
                  storeId: '')).then((value) =>
              {
                if(value) Navigator.pushNamed(context, HomeScreen.routeName)
              });
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
}
