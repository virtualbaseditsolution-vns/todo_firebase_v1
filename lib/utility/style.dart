import 'package:flutter/material.dart';



Color primaryColor = const Color(0xFF46539e);



/// Vertical Spacing...
SizedBox vSpace = const SizedBox(height: 10,);
SizedBox vSpaceSmall = const SizedBox(height: 5,);
SizedBox vSpaceBig = const SizedBox(height: 20,);

/// Horizontal Spacing....
SizedBox hSpace = const SizedBox(width: 10,);
SizedBox hSpaceSmall = const SizedBox(width: 5,);
SizedBox hSpaceBig = const SizedBox(width: 20,);



/// Text Style
TextStyle smallText = const TextStyle(fontSize: 11);
TextStyle heading = const TextStyle(fontSize: 15,fontWeight: FontWeight.bold);
TextStyle heading1 = const TextStyle(fontSize: 18,fontWeight: FontWeight.bold);
TextStyle heading2 = const TextStyle(fontSize: 25,fontWeight: FontWeight.bold);


//button style
EdgeInsets buttonPadding =
const EdgeInsets.symmetric(horizontal: 20, vertical: 15);
RoundedRectangleBorder get buttonShape {
  return const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(6.0)));
}
TextStyle buttonText = const TextStyle(
  fontWeight: FontWeight.w700,
  fontSize: 17.0,
);

ButtonStyle get buttonStyle{
  return ElevatedButton.styleFrom(
      elevation: 6,
      shape: buttonShape,
      backgroundColor: primaryColor,
      padding: buttonPadding,
      textStyle: buttonText
  );
}


BorderRadius inputRadius = BorderRadius.circular(5.0);

InputDecoration inputDecoration(
    {String? hintText,
      IconData? suffixIcon,
      IconData? prefixIcon,
      String? label,
      double? radius,
      Color? fillColor,
      String? prefix,
      Widget? suffix,
      BorderSide? borderSide}) {
  return InputDecoration(
    suffixIcon: suffixIcon != null ? Icon(suffixIcon) : null,
    prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
    prefixText: prefix,
    suffix: suffix,
    label: label != null ? Text(label) : null,
    labelStyle: borderSide != null ? const TextStyle(color: Colors.grey):null,
    hintText: hintText ?? "",
    hintStyle: const TextStyle(color: Colors.grey),
    filled: fillColor != null ? true : false,
    fillColor: fillColor ?? Colors.grey.withOpacity(0.1),
    errorStyle: borderSide != null
        ? const TextStyle(color: Colors.deepOrangeAccent)
        : null,
    errorBorder: OutlineInputBorder(
      borderSide: BorderSide(
          color: borderSide != null ? Colors.deepOrangeAccent : primaryColor),
      borderRadius:
      radius != null ? BorderRadius.circular(radius) : inputRadius,
    ),
    border: OutlineInputBorder(
      borderSide:
      borderSide ?? const BorderSide(color: Colors.transparent, width: 1),
      borderRadius:
      radius != null ? BorderRadius.circular(radius) : inputRadius,
    ),
    enabledBorder: OutlineInputBorder(
      borderSide:
      borderSide ?? BorderSide(color: primaryColor.withOpacity(0.5)),
      borderRadius:
      radius != null ? BorderRadius.circular(radius) : inputRadius,
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(
          color: borderSide != null ? primaryColor : primaryColor),
      borderRadius:
      radius != null ? BorderRadius.circular(radius) : inputRadius,
    ),
    contentPadding: const EdgeInsets.all(15.0),
  );
}