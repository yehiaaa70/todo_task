import 'package:flutter/material.dart';
import 'package:todo_task/Constants/Colors.dart';

class MyTextFormField extends StatelessWidget {
  const MyTextFormField(
      {Key? key,
      required this.title,
      required this.hint,
      required this.inputType,
      this.icon,
      this.calenderOnClick,
      required this.controller})
      : super(key: key);
  final String title;
  final String hint;
  final TextInputType inputType;
  final IconData? icon;
  final VoidCallback? calenderOnClick;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
      child: Column(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          TextFormField(
            controller: controller,
            keyboardType: inputType,
            decoration: InputDecoration(
              suffixIcon: icon == null
                  ? null
                  : IconButton(
                      onPressed: calenderOnClick,
                      icon: Icon(icon),
                    ),
              disabledBorder: InputBorder.none,
              fillColor: MyColors.txtFormColor,
              filled: true,
              hintText: hint,
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(12.0),
              ),
            ),
          )
        ],
      ),
    );
  }
}
