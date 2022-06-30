import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:shop/components/custom_surfix_icon.dart';
import 'package:shop/components/form_error.dart';
import 'package:shop/core/keyboard.dart';
import 'package:shop/core/size_config.dart';
import 'package:shop/models/userModel.dart';
import 'package:shop/screens/forgot_password/forgot_password_screen.dart';
import 'package:shop/screens/login_success/login_success_screen.dart';
import 'package:shop/screens/sign_in/state_management/sign_in_state.dart';
import 'package:shop/services/auth_services.dart';

import '../../../components/default_button.dart';
import '../../../core/constants.dart';
import '../../complete_store/complete_store_screen.dart';
import '../../complete_store/state_management/complete_store_state.dart';

class SignForm extends StatefulWidget {
  @override
  _SignFormState createState() => _SignFormState();
}

class _SignFormState extends State<SignForm> {
  UserModel? userModel;
  final _formKey = GlobalKey<FormState>();
  late String email = "essamsaleh101@gmail.com";
  late String password = "123456@#";
  bool? remember = false;
  final List<String?> errors = [];

  @override
  void initState() {
    super.initState();
  }

  void addError({String? error}) {
    if (!errors.contains(error))
      setState(() {
        errors.add(error);
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
          buildEmailFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildPasswordFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          Row(
            children: [
              Checkbox(
                value: remember,
                activeColor: kPrimaryColor,
                onChanged: (value) {
                  setState(() {
                    remember = value;
                  });
                },
              ),
              Text("Remember me"),
              Spacer(),
              GestureDetector(
                onTap: () => Navigator.pushNamed(context, ForgotPasswordScreen.routeName),
                child: Text(
                  "Forgot Password",
                  style: TextStyle(decoration: TextDecoration.underline),
                ),
              )
            ],
          ),
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(20)),
          DefaultButton(
            text: "Continue",
            press: () async {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                Provider.of<SignInState>(context, listen: false).signIn(email: email, password: password).then((value) async => {
                      if (value)
                        {
                          if (await Provider.of<CompleteStoreState>(context, listen: false).isUserHasStore())
                            {Navigator.pushReplacementNamed(context, LoginSuccessScreen.routeName)}
                          else
                            {Navigator.pushReplacementNamed(context, CompleteStoreScreen.routeName)}
                        }
                    });
              }
            },
          ),
          DefaultButton(
            text: "clear cache ",
            press: () async {
              new GetStorage().erase();
            },
          ),
        ],
      ),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      initialValue: Provider.of<SignInState>(context, listen: true).userModel?.password,
      obscureText: true,
      onSaved: (newValue) {
        if (newValue != null) password = newValue;
      },
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPassNullError);
        } else if (value.length >= 8) {
          removeError(error: kShortPassError);
        }
        return null;
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

  TextFormField buildEmailFormField() {
    return TextFormField(
      initialValue: Provider.of<SignInState>(context, listen: true).userModel?.email,
      keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) {
        if (newValue != null) email = newValue;
      },
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kEmailNullError);
        } else if (emailValidatorRegExp.hasMatch(value)) {
          removeError(error: kInvalidEmailError);
        }
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
