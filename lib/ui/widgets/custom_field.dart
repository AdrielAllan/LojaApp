import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomTextField extends StatefulWidget {
  final double width;
  final double? fieldHeight;
  final bool isFixedWidth;
  final String hintText;
  final bool isRequired;
  final TextInputType inputType;
  final bool isPasswordField;
  final bool isDateField;
  final bool isTimeField;
  final bool setTimeWithDate;
  final TextEditingController controller;
  final Function(DateTime)? onDateSelected;
  final Function(TimeOfDay)? onTimeSelected;
  final Function(String)? onChanged;
  final bool enable;
  final bool isMultiline; // Novo parâmetro
  bool showError;

  CustomTextField({
    required this.width,
    required this.isFixedWidth,
    required this.hintText,
    required this.isRequired,
    required this.inputType,
    required this.controller,
    this.isPasswordField = false,
    this.onDateSelected,
    this.onTimeSelected,
    this.onChanged,
    this.isTimeField = false,
    this.setTimeWithDate = false,
    this.isDateField = false,
    this.enable = true,
    this.showError = false,
    this.fieldHeight,
    this.isMultiline = false, // Novo parâmetro com valor padrão
    super.key,
  });

  @override
  // ignore: library_private_types_in_public_api
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _obscureText = true; // Para o campo de senha

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double fieldWidth = widget.isFixedWidth ? widget.width : constraints.maxWidth * widget.width;
        bool showErrorField = widget.showError && widget.controller.text.isEmpty;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: widget.isMultiline ? widget.fieldHeight : null, // Altura é flexível para multiline
              width: fieldWidth,
              decoration: BoxDecoration(
                  color: widget.enable ? Colors.transparent : Colors.grey[300],
                  borderRadius: BorderRadius.circular(7),
                  border: Border.all(color: showErrorField ? Colors.red : const Color(0xFFEDF1F7), width: 1)),
              child: TextField(
                enabled: widget.enable,
                controller: widget.controller,
                keyboardType: widget.isMultiline ? TextInputType.multiline : widget.inputType,
                obscureText: widget.isPasswordField ? _obscureText : false,
                readOnly: widget.isDateField || widget.isTimeField,
                maxLines: widget.isMultiline ? null : 1, // Permite múltiplas linhas se isMultiline for true
                minLines: widget.isMultiline ? 3 : 1, // Define linhas mínimas para multiline
                style: const TextStyle(
                  color: Color(0xFF4F555A), // Cor do texto do campo
                ),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                  hintStyle: const TextStyle(color: Color(0xFF8F9BB3), fontWeight: FontWeight.normal),
                  hintText: widget.hintText,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(7),
                    borderSide: BorderSide.none,
                  ),
                ),
                onChanged: (value) {
                  if (widget.isRequired && value.isEmpty) {
                    setState(() {
                      widget.showError = true;
                    });
                  } else {
                    setState(() {
                      widget.showError = false;
                    });
                  }
                  if (widget.onChanged != null) {
                    widget.onChanged!(value);
                  }
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
