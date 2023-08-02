import 'package:flutter/material.dart';

Widget textFormField({
  required context,
  required IconData? icon,
  required String labelText,
  required String hintText,
  required dynamic onChanged,
  required dynamic validator,
  required TextInputType textInputType,
  required TextInputAction? textInputAction,
  int maxLines = 1,
  String initialValue = "",
}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: TextFormField(
      initialValue: initialValue,
      keyboardType: textInputType,
      onChanged: onChanged,
      validator: validator,
      minLines: 1,
      maxLines: maxLines,
      cursorHeight: 22,
      cursorWidth: 2,
      cursorColor: Theme.of(context).primaryColor,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(color: Theme.of(context).primaryColor),
        hintText: hintText,
        prefixIcon: Icon(
          icon,
          color: Theme.of(context).primaryColor,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).primaryColor,
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).primaryColor,
          ),
        ),
      ),
      textInputAction: textInputAction,
    ),
  );
}
