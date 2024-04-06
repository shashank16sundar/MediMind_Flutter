import 'package:flutter/material.dart';

class InterfaceButton extends StatefulWidget {
  final String labelText;
  final VoidCallback onTap;

  const InterfaceButton({
    super.key,
    required this.labelText,
    required this.onTap,
  });

  @override
  State<InterfaceButton> createState() => _InterfaceButtonState();
}

class _InterfaceButtonState extends State<InterfaceButton> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SizedBox(
      width: size.width * 0.8,
      height: 60,
      child: ElevatedButton(
        style: ButtonStyle(
          shape: MaterialStatePropertyAll<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25.0),
              side: const BorderSide(color: Colors.black, width: 2),
            ),
          ),
          backgroundColor: MaterialStatePropertyAll(Colors.grey.shade200),
          shadowColor: const MaterialStatePropertyAll(Colors.transparent),
          side: const MaterialStatePropertyAll(
            BorderSide(color: Colors.black),
          ),
        ),
        onPressed: widget.onTap,
        child: Text(
          widget.labelText,
          style: const TextStyle(
            fontSize: 25,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
