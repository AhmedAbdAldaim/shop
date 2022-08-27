//Default ListTile
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

defaultListTitle(
    {required Widget title,
    Widget? leading,
    Widget? trailing,
    Widget? subtilte,
    EdgeInsetsGeometry? contentPadding,
    GestureTapCallback? onTap}) {
  return ListTile(
    leading: leading,
    contentPadding: contentPadding,
    title: title,
    trailing: trailing,
    subtitle: subtilte,
    onTap: onTap,
  );
}

navigetionBack({required BuildContext context}) {
  Navigator.of(context).pop();
}

navigetTo({required BuildContext context, Widget? page}) {
  Navigator.of(context).push(MaterialPageRoute(builder: (context) => page!));
}

navigatorAndRemive({required BuildContext context, Widget? page}) {
  Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => page!), (route) => false);
}

defaultTextFormFailed(
    {required TextEditingController controller,
    required String hint,
    required FormFieldValidator<String> validator,
    required TextInputAction action,
    required TextInputType keyboard,
    bool? obscureText = false,
    Icon? iconPassword,
    VoidCallback? onpressed}) {
  return TextFormField(
    autovalidateMode: AutovalidateMode.onUserInteraction,
    keyboardType: keyboard,
    textInputAction: action,
    validator: validator,
    controller: controller,
    obscureText: obscureText!,
    decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.grey),
        contentPadding: const EdgeInsets.all(12.0),
        suffixIcon: iconPassword != null
            ? IconButton(onPressed: onpressed, icon: iconPassword)
            : null,
        enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey)),
        border: const OutlineInputBorder(),
        errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red))),
  );
}

//flutter Toast
defautToast({
  required String message,
}) {
  return Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: Colors.red.shade800,
      textColor: Colors.white,
      fontSize: 16.0);
}
