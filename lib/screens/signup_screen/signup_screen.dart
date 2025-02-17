import 'package:flutter/material.dart';
import 'package:tatweer_maximo/widgets/custom_text_field.dart';
import 'package:tatweer_maximo/widgets/custom_date_picker.dart';
import 'package:tatweer_maximo/widgets/custom_rectangle_button.dart';
import 'package:tatweer_maximo/widgets/login_form_input.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key, required this.toggleScreen});
  final Function toggleScreen;

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  DateTime? selectedDate;
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _mobileController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void onSubmit() {
    if (_formKey.currentState!.validate()) {
      // Show popup on successful validation
      showDialog(
        context: context,
        barrierDismissible:
            false, // Prevents user from dismissing without clicking OK
        builder: (context) {
          return AlertDialog(
            backgroundColor: Theme.of(context).colorScheme.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            title: const Text(
              "Request Under Review",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            content: const Text(
              "We will notify you once approved/declined through your email.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.white70),
            ),
            actions: [
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context); // Close the popup
                    widget.toggleScreen(
                        "projects"); // Navigate to projects screen
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.secondary,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    "OK",
                    style:
                        TextStyle(color: Theme.of(context).colorScheme.primary),
                  ),
                ),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.tertiary,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(30, 60, 30, 0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Sign Up',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Personal Details',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: CustomTextField(
                            label: 'First Name',
                            controller: _firstNameController,
                            theme: 'white',
                            required: true,
                            disabled: false,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: CustomTextField(
                            label: 'Last Name',
                            controller: _lastNameController,
                            theme: 'white',
                            required: true,
                            disabled: false,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    CustomTextField(
                      label: 'Mobile',
                      controller: _mobileController,
                      theme: 'white',
                      required: true,
                      disabled: false,
                    ),
                    const SizedBox(height: 10),
                    CustomDatePicker(
                      label: 'Date of Birth (Optional)',
                      theme: 'white',
                      disabled: false,
                      selectedDate: selectedDate,
                      setSelectedValue: (pickedDate, label) {
                        selectedDate = pickedDate;
                        debugPrint('$label: $pickedDate');
                      },
                    ),
                    const SizedBox(height: 30),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Security Details',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(height: 10),
                    LoginFormInput(
                      label: "Email",
                      secured: false,
                      controller: _emailController,
                      theme: "light",
                      icon: const Icon(Icons.email),
                      maxLines: 1,
                    ),
                    const SizedBox(height: 10),
                    LoginFormInput(
                      label: "Password",
                      secured: true,
                      controller: _passwordController,
                      theme: "light",
                      icon: const Icon(Icons.lock),
                      maxLines: 1,
                    ),
                    const SizedBox(height: 10),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: 300,
                      child: CustomRectangleButton(
                        onClick: onSubmit,
                        text: 'Sign Up',
                        theme: 'white',
                        loading: false,
                        disabled: false,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Already have an account?',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextButton(
                          onPressed: () {
                            widget.toggleScreen("login");
                          },
                          child: Text(
                            'SIGN IN',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
