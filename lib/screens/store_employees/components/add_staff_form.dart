import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/components/custom_surfix_icon.dart';
import 'package:shop/components/default_button.dart';
import 'package:shop/components/form_error.dart';
import 'package:shop/core/constants.dart';
import 'package:shop/core/size_config.dart';
import 'package:shop/models/userModel.dart';

import '../state_management/store_employees_state.dart';

class AddStaffForm extends StatefulWidget {
  final String? empId;
  final String? empName;
  final String? role;
  final String? storeId;
  final String? email;
  final String? password;

  const AddStaffForm({
    Key? key,
    this.empId,
    this.empName,
    this.storeId,
    this.role,
    this.email,
    this.password,
  }) : super(key: key);

  @override
  State<AddStaffForm> createState() => _AddStaffFormState();
}

class _AddStaffFormState extends State<AddStaffForm> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.empId != null ) {
      empId = widget.empId!;
      email = widget.email!;
      password = widget.password!;
      name = widget.empName!;
      storeId = widget.storeId!;
      role = widget.role!;
    }
  }

  final _formKey = GlobalKey<FormState>();
  final List<String> errors = [];

  late String empId= "";
  late String email= "";

  late String conform_password= "";

  late String role= "";

  late String password= "";

  late String name = "";

  late String storeId= "";

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
        child: Padding(
          padding: const  EdgeInsets.only(left: 8.0,right: 8.0),
          child: Column(
            children: [
              SizedBox(height: getProportionateScreenHeight(30)),
              buildNameFormField(),
              SizedBox(height: getProportionateScreenHeight(30)),
              buildEmailFormField(),
              SizedBox(height: getProportionateScreenHeight(30)),
              buildPasswordFormField(),
              SizedBox(height: getProportionateScreenHeight(30)),
              buildConformPassFormField(),
              SizedBox(height: getProportionateScreenHeight(30)),
              FormError(errors: errors),
              SizedBox(height: getProportionateScreenHeight(40)),
              DefaultButton(
                text: (empId.isNotEmpty? "Update" : " Add") + " Employee",
                press: () async {
                  if (_formKey.currentState!.validate()) {
                    Provider.of<StoreEmployeesState>(context, listen: false)
                        .UpdateOrCreateWorker(
                            model: new UserModel(
                          userId: empId.isNotEmpty ? empId : "",
                          name: name,
                          email: email,
                          storeId: storeId,
                          password: password,
                          role: roleType.emp.name,
                        ))
                        .then((value) => {if (value) Navigator.pop(context)});
                  }
                },
              ),
            ],
          ),
        ));
  }

  TextFormField buildConformPassFormField() {
    return TextFormField(
      obscureText: true,
      initialValue: password,
      onSaved: (newValue) {
        if (newValue != null) {
          conform_password = newValue;
        }
      },
      onChanged: (value) {
        // if (value.isNotEmpty) {
        //   removeError(error: kPassNullError);
        // } else if (value.isNotEmpty && password == conform_password) {
        //   removeError(error: kMatchPassError);
        // }
        conform_password = value;
      },
      validator: (value) {
        // if (value!.isEmpty) {
        //   addError(error: kPassNullError);
        //   return "";
        // } else if ((password != value)) {
        //   addError(error: kMatchPassError);
        //   return "";
        // }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Confirm Password",
        hintText: "Re-enter your password",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
      ),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      obscureText: true,
      initialValue: password,
      onSaved: (newValue) {
        if (newValue != null) {
          password = newValue;
        }
      },
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPassNullError);
        } else if (value.length >= 8) {
          removeError(error: kShortPassError);
        }
        password = value;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kPassNullError);
          return "";
        } else if (value.length < 8) {
          addError(error: kShortPassError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Password",
        hintText: "Enter your password",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
      ),
    );
  }

  TextFormField buildNameFormField() {
    return TextFormField(
      keyboardType: TextInputType.name,
      initialValue: name,
      onSaved: (newValue) {
        if (newValue != null) {
          name = newValue;
        }
      },
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kEmailNullError);
        }
        name = value;

        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kEmailNullError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Name",
        hintText: "Enter your Name",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
      ),
    );
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      initialValue: email,
      onSaved: (newValue) {
        if (newValue != null) {
          email = newValue;
        }
      },
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kEmailNullError);
        } else if (emailValidatorRegExp.hasMatch(value)) {
          removeError(error: kInvalidEmailError);
        }
        email = value;

        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kEmailNullError);
          return "";
        } else if (!emailValidatorRegExp.hasMatch(value)) {
          addError(error: kInvalidEmailError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Email",
        hintText: "Enter your email",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
      ),
    );
  }
}
