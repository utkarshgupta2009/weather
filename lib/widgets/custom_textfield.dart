import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather/screens/homescreen_controller.dart';


class CustomTextfield extends StatelessWidget {
  final TextEditingController controller; // Controller for the text field
  final FocusNode focusNode; // Focus node for managing focus state

  const CustomTextfield({
    Key? key,
    required this.controller,
    required this.focusNode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final getxController =
        Get.put(HomescreenController()); // Controller for managing state


    return TextField(
      controller: controller, // Attach controller to text field
      focusNode: focusNode, // Attach focus node to text field
      minLines: 1,
      maxLines: 1,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(
            vertical: 14.0, horizontal: 16.0), // Padding inside text field
        isDense: true,
        fillColor: const Color.fromARGB(
            255, 240, 237, 234), // Background color of text field
        filled: true,
        prefixIcon: const Icon(Icons.search,
            color: Color(0xffFF8911)), // Search icon at the start
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
              color: Colors.black, width: 2.0), // Border style when enabled
          borderRadius: BorderRadius.circular(25), // Rounded corners
        ),
        hintText: "Enter city", // Placeholder text
        hintStyle: const TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 15,
            color: Colors.grey), // Style for placeholder text
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
              color: Color(0xffFF8911),
              width: 2.0), // Border style when focused
          borderRadius: BorderRadius.circular(25),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
              color: Colors.red, width: 2.0), // Border style when error
          borderRadius: BorderRadius.circular(25),
        ),
      ),
      onTap: () {
        getxController.isTyping.value =
            true; // Set typing state to true when tapped
      },
      
      textAlignVertical:
          TextAlignVertical.center, // Center align the text vertically
    );
  }
}
