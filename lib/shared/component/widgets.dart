import 'package:flutter/material.dart';

Widget defaultFormField({
  required TextEditingController textController,
  required TextInputType type,
  Function? onSubmit,
  Function? onChanged,
  Function? onTap,
  required Function validate,
  required String label,
  required IconData prefix,
  IconData? suffix,
  bool isPassword = false,
  Function? suffixPressed,
  bool isClickable = true,
  bool readOnly = false,
  TextInputAction? inputAction,
}) =>
    TextFormField(
      controller: textController,
      keyboardType: type,
      obscureText: isPassword,
      onFieldSubmitted: (value) {
        onSubmit!(value);
      },
      //  onChanged: (value)
      //  {
      //    onChanged!(value);
      //  },
      // onTap: ()
      // {
      //   onTap!();
      // },
      textInputAction: inputAction,

      validator: (value) {
        return validate(value);
      },
      enabled: isClickable,
      readOnly: readOnly,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(
          prefix,
        ),
        suffixIcon: suffix != null
            ? IconButton(
          icon: Icon(
            suffix,
          ),
          onPressed: () {
            suffixPressed!();
          },
        )
            : null,
        border: OutlineInputBorder(),
      ),
    );


Widget defaultButton({
  double width = double.infinity,
  double height = 40.0,
  Color color = Colors.blue,
  required Function function,
  required String text,
  double radius = 5.0,
}) =>
    Container(
      width: width,
      height: height,
      child: MaterialButton(
        onPressed: () {
          function();
        },
        child: Text(
          text.toUpperCase(),
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: color,
      ),
    );



void navigateTo(context, widget) => Navigator.push(
  context,
  MaterialPageRoute(builder: (context) => widget),
);

Widget myDivider() => Container(
  width: double.infinity,
  height: 1.0,
  color: Colors.grey[300],
);

