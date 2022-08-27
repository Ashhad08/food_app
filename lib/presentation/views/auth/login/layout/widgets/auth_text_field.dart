import 'package:flutter/material.dart';

class AuthTextField extends StatefulWidget {
  AuthTextField({
    Key? key,
    required this.hintText,
    required this.prefixIcon,
    required this.isPasswordField,
    required this.controller,
    this.obscureText = false,
    this.validator,
  }) : super(key: key);
  final String hintText;
  final IconData prefixIcon;
  final bool isPasswordField;
  final TextEditingController controller;
  final Function(String)? validator;
  bool obscureText;

  @override
  State<AuthTextField> createState() => _AuthTextFieldState();
}

class _AuthTextFieldState extends State<AuthTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (val) => widget.validator!(val!),
      obscureText: widget.obscureText,
      controller: widget.controller,
      style: const TextStyle(
          color: Color(0xff777777),
          fontWeight: FontWeight.w500,
          fontSize: 10,
          fontFamily: 'Poppins'),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.only(top: 15),
        errorStyle: const TextStyle(
            color: Colors.red,
            fontWeight: FontWeight.w500,
            fontSize: 10,
            fontFamily: 'Poppins'),
        hintText: widget.hintText,
        hintStyle: const TextStyle(
            color: Color(0xff777777),
            fontWeight: FontWeight.w500,
            fontSize: 10,
            fontFamily: 'Poppins'),
        prefixIcon: Icon(
          widget.prefixIcon,
          size: 20,
        ),
        suffixIcon: widget.isPasswordField
            ? GestureDetector(
                onTap: () {
                  setState(() {
                    widget.obscureText = !widget.obscureText;
                  });
                },
                child: widget.obscureText
                    ? const Icon(
                        Icons.visibility_off,
                        size: 20,
                      )
                    : const Icon(
                        Icons.visibility,
                        size: 20,
                      ))
            : null,
      ),
    );
  }
}
