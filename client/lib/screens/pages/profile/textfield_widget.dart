import 'package:area/constants.dart';
import 'package:area/settings.dart';
import 'package:flutter/material.dart';

class TextFieldWidget extends StatefulWidget {
  final String label;
  final String text;
  final ValueChanged<String> onChanged;

  const TextFieldWidget({
    Key? key,
    required this.label,
    required this.text,
    required this.onChanged,
  }) : super(key: key);

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  late final TextEditingController controller;
  bool _dark = settings.dark_mode;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(text: widget.text);
    _dark = settings.dark_mode;
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.label,
            style: TextStyle(
              fontFamily: "Raleway",
              fontSize: 18,
              color: settings.dark_mode ? pc1 : pf1,
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: controller,
            style: TextStyle(
              fontFamily: "Raleway",
              fontSize: 15,
              color: settings.dark_mode ? pc1 : pf1,
            ),
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: settings.dark_mode ? pc2 : pc3,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onChanged: widget.onChanged,
          ),
        ],
      );
}
