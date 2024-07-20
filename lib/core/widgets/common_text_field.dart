import 'package:flutter/material.dart';

class CommonTextField extends StatefulWidget {
  final String labelText;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final String? hintText;
  final Function(String?)? onchange;

  const CommonTextField(
      {super.key,
      required this.labelText,
      this.validator,
      this.controller,
      this.hintText,
      this.onchange});

  @override
  State<CommonTextField> createState() => _CommonTextFieldState();
}

class _CommonTextFieldState extends State<CommonTextField> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _controller,
      decoration: InputDecoration(
        // fillColor: const Color(0xfff2f2f2),
        // filled: true,
        // contentPadding:
        //     const EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0),
        prefixIcon:
            IconButton(onPressed: () async {}, icon: const Icon(Icons.search)),
        hintText: widget.hintText,
        labelText: widget.labelText,

        // counterStyle: TextStyle(color: fontColor),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(
            color: Colors.blue,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(
            color: Colors.black12,
            width: 1.0,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(
            color: Colors.redAccent,
            width: 1.0,
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(
            color: Colors.blue,
            width: 1.0,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(
            color: Colors.redAccent,
            width: 1.0,
          ),
        ),
      ),
      validator: widget.validator,
      onChanged: widget.onchange,
    );
  }
}
