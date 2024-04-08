import 'package:flutter/material.dart';

class InterfaceButton extends StatefulWidget {
  final String labelText;
  final VoidCallback onTap;
  final String imageURL;

  const InterfaceButton({
    super.key,
    required this.labelText,
    required this.onTap,
    required this.imageURL,
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
      height: 250,
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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.labelText,
                style: const TextStyle(
                  fontSize: 25,
                  color: Colors.black,
                ),
              ),
              Image.asset(
                widget.imageURL,
                fit: BoxFit.contain,
                width: 150,
                height: 150,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
