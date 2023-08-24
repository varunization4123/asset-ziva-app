import 'package:asset_ziva/utils/colors.dart';
import 'package:flutter/material.dart';

class CustomSearchBar extends StatelessWidget {
  final String hintText;
  // required IconData icon,
  final TextInputType inputType;
  final int maxLines;
  final TextEditingController controller;
  final Function controllerAction;
  const CustomSearchBar({
    super.key,
    required this.hintText,
    required this.inputType,
    required this.maxLines,
    required this.controller,
    required this.controllerAction,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextFormField(
        cursorColor: primaryColor,
        controller: controller,
        keyboardType: inputType,
        maxLines: maxLines,
        decoration: InputDecoration(
          prefixIcon: const Icon(
            Icons.search,
            color: primaryColor,
          ),
          suffixIcon: IconButton(
            icon: const Icon(Icons.clear),
            onPressed: () => controllerAction,
            color: primaryColor,
          ),
          //   child: Icon(
          //     icon,
          //     size: 20,
          //     color: Colors.white,
          //   ),
          // ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: primaryColor,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: primaryColor,
            ),
          ),
          hintText: hintText,
          alignLabelWithHint: true,
          border: InputBorder.none,
          fillColor: inputColor,
          filled: true,
        ),
      ),
    );
  }
}
