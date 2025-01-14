import 'package:flutter/material.dart';
import 'package:tatweer_approval/widgets/custom_rectangle_button.dart';
import 'package:tatweer_approval/widgets/login_form_input.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key, required this.onLogIn});

  final Function onLogIn;

  @override
  State<LoginForm> createState() {
    return _LoginFormState();
  }
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _userNameController = TextEditingController();
  final _passwordController = TextEditingController();
  var _isLoggingIn = false;

  @override
  void dispose() {
    _userNameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void disableLoginSpinner () {
    setState(() {
      _isLoggingIn = false;
    });
  }

  @override
  Widget build(context) {
    return Column(children: [
      SizedBox(
        width: 300,
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              LoginFormInput(label: "Username", secured: false, controller: _userNameController, theme: 'light', icon: const Icon(Icons.person), maxLines: 1),
              const SizedBox(
                height: 15.0,
              ),
              LoginFormInput(label: "Password", secured: true, controller: _passwordController, theme: 'light', icon: const Icon(Icons.lock), maxLines: 1),
              const SizedBox(
                height: 15.0,
              ),
              SizedBox(
                width: 250,
                child: CustomRectangleButton(
                  onClick: (){
                    if (_formKey.currentState!.validate()) {
                    setState(() {      
                      _isLoggingIn = true;
                    });
                    widget.onLogIn(_userNameController.text,
                        _passwordController.text, disableLoginSpinner);
                  }
                  },
                  text: 'Login',
                  theme: 'dark',
                  loading: _isLoggingIn,
                  disabled: false,
                ),
              )
            ],
          ),
        ),
      ),
    ]);
  }
}
