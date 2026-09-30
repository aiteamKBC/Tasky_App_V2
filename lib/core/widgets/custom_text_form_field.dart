import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.controller,
    this.maxLine,
    required this.hintText,
    this.validator,
    required this.title,
  });
  final TextEditingController controller;

  final int? maxLine;
  final String hintText;
  final String? Function(String?)? validator;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        Text(title, style: Theme.of(context).textTheme.titleMedium),
        SizedBox(height: 8),
        TextFormField(
          controller: controller,
          style: Theme.of(context).textTheme.titleMedium,
          validator: validator,
          maxLines: maxLine,

          decoration: InputDecoration(hintText: hintText),
        ),
      ],
    );
  }
}
