import 'package:flutter/material.dart';

class LoginInputPasswordWidget extends StatelessWidget {
  final TextEditingController textEditingController;
  final bool? readingOnly;
  final bool? errorBorder;
  final void Function(String)? onChanged;
  const LoginInputPasswordWidget({
    Key? key,
    required this.textEditingController,
    this.readingOnly,
    this.errorBorder,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChanged,
      controller: textEditingController,
      obscureText: true,
      keyboardType: TextInputType.text,
      readOnly: readingOnly ?? false,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.lock),
        label: const Text('Senha'),
        floatingLabelStyle: const TextStyle(fontSize: 22),
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.blue),
          borderRadius: BorderRadius.circular(20),
        ),
        enabledBorder: errorBorder == null
            ? OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.blue, width: 2),
                borderRadius: BorderRadius.circular(20),
              )
            : OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.red, width: 2),
                borderRadius: BorderRadius.circular(20),
              ),
      ),
    );
  }
}
