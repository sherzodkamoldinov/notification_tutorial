import 'package:flutter/material.dart';
import 'package:notification_tutorial/utils/colors.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({super.key, required TextEditingController controller}): _controller = controller;

  final TextEditingController _controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      decoration: const InputDecoration(
        border: OutlineInputBorder(
            borderSide: BorderSide(color: MyColors.bluePurple)),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: MyColors.bluePurple)),
      ),
    );
  }
}
