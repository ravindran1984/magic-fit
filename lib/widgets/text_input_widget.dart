import 'package:flutter/material.dart';

class InputFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final TextInputType inputType;
  final FormFieldValidator<String>? validator;

  const InputFieldWidget({
    super.key,
    required this.controller,
    required this.label,
    required this.inputType,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
      keyboardType: inputType,
      validator: validator,
    );
  }
}
