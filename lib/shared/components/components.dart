// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:untitled/shared/styles/colors.dart';

Widget defaultButton({
  required onPress,
  required String text,
  double width = double.infinity,
  Color background = defaultColor,
}) =>
    Container(
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: background,
      ),
      child: MaterialButton(
          onPressed: onPress,
          child: Text(
            text.toUpperCase(),
            style: const TextStyle(color: Colors.white, fontSize: 20),
          )),
    );

Widget defaultFormField(
        {required TextEditingController controller,
        required TextInputType type,
        required validate,
        required String label,
        required IconData prefix,
        IconData? suffix,
        onSubmit,
        onChanged,
        bool isPassword = false,
        Function? suffixPress,
        onTap}) =>
    TextFormField(
      cursorColor: defaultColor,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        labelText: label,
        prefixIcon: Icon(prefix),
        suffixIcon: IconButton(
            onPressed: () {
              suffixPress!();
            },
            icon: Icon(suffix),
            padding: const EdgeInsets.all(0)),
      ),
      controller: controller,
      keyboardType: type,
      validator: validate,
      onChanged: onChanged,
      onFieldSubmitted: onSubmit,
      obscureText: isPassword,
      onTap: onTap,
    );

void navigateTo({
  context,
  required Widget route,
}) =>
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => route,
        ));

void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => widget),
      (route) {
        return false;
      },
      // (Route<dynamic> route) => until,
    );

Future<bool?> showToast({required String text, required ToastColors state}) =>
    Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: switchColor(state),
        textColor: Colors.white,
        fontSize: 16.0);

enum ToastColors { SUCCESS, FAILED, WARN }

Color switchColor(ToastColors state) {
  Color color;
  switch (state) {
    case ToastColors.SUCCESS:
      color = Colors.green;
      break;
    case ToastColors.FAILED:
      color = Colors.red;
      break;
    case ToastColors.WARN:
      color = Colors.yellowAccent;
  }
  return color;
}
