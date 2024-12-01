import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';

class CustomTextFormField extends StatefulWidget {
  final double width;
  final bool isFixedWidth;
  final String hintText;
  final bool isRequired;
  final TextInputType inputType;
  final bool isPasswordField;
  final bool isDateField;
  final bool isTimeField;
  final bool isEmailField;
  final bool setTimeWithDate;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final Function(DateTime)? onDateSelected;
  final Function(TimeOfDay)? onTimeSelected;
  final Function(String)? onChanged;
  final String? fieldName;
  final bool enable;
  final Icon? preffixIcon;
  final MaskedInputFormatter? maskFormatter;

  const CustomTextFormField({
    required this.width,
    required this.isFixedWidth,
    required this.hintText,
    required this.isRequired,
    required this.inputType,
    this.controller,
    this.validator,
    this.isEmailField = false,
    this.isPasswordField = false,
    this.onDateSelected,
    this.onTimeSelected,
    this.onChanged,
    this.isTimeField = false,
    this.setTimeWithDate = false,
    this.isDateField = false,
    this.enable = true,
    this.fieldName,
    this.preffixIcon,
    this.maskFormatter,
    super.key,
  });

  @override
  _CustomTextFormFieldState createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  late TextEditingController _controller;
  bool _obscureText = true;
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    _controller.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double fieldWidth = widget.isFixedWidth ? widget.width : constraints.maxWidth * widget.width;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (widget.fieldName != null) Text(widget.fieldName!) else const SizedBox.shrink(),
            SizedBox(
              width: fieldWidth,
              child: TextFormField(
                enabled: widget.enable,
                controller: _controller,
                keyboardType: widget.inputType,
                obscureText: widget.isPasswordField ? _obscureText : false,
                readOnly: widget.isDateField || widget.isTimeField,
                validator: widget.validator ??
                    (value) {
                      if (widget.isRequired && (value == null || value.isEmpty)) {
                        return 'Campo obrigatório';
                      }
                      if (value != null && widget.isEmailField && !value.contains('@')) {
                        return 'Insira um email válido.';
                      }
                      return null;
                    },
                inputFormatters: widget.maskFormatter != null ? [widget.maskFormatter!] : null,
                decoration: InputDecoration(
                  prefixIcon: widget.preffixIcon,
                  prefixIconColor: const Color(0xFF8F9BB3),
                  hintStyle: const TextStyle(color: Color(0xFF8F9BB3), fontWeight: FontWeight.normal),
                  hintText: widget.hintText,
                  suffixIcon: _buildSuffixIcon(),
                ),
                onChanged: widget.onChanged,
                onTap: () {
                  if (widget.isDateField || widget.isTimeField) {
                    widget.isTimeField ? _selectTime(context) : _selectDate(context);
                  }
                },
              ),
            ),
          ],
        );
      },
    );
  }

  Widget? _buildSuffixIcon() {
    if (widget.isPasswordField) {
      return IconButton(
        icon: Icon(
          _obscureText ? Icons.visibility_off_outlined : Icons.visibility_outlined,
          color: const Color(0xFF8F9BB3),
        ),
        onPressed: () {
          setState(() {
            _obscureText = !_obscureText;
          });
        },
      );
    } else if (widget.isDateField || widget.isTimeField) {
      return IconButton(
        icon: Icon(
          widget.isTimeField ? Icons.access_time : Icons.calendar_today_outlined,
          color: const Color(0xFF8F9BB3),
        ),
        onPressed: () {
          widget.isTimeField ? _selectTime(context) : _selectDate(context);
        },
      );
    } else if (_controller.text.isNotEmpty) {
      return IconButton(
        icon: const Icon(
          Icons.clear,
          color: Color(0xFF8F9BB3),
        ),
        onPressed: () {
          setState(() {
            _controller.clear();
          });
        },
      );
    }
    return null;
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _controller.text = "${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}";

        if (widget.onDateSelected != null) {
          widget.onDateSelected!(_selectedDate!);
        }
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: _selectedTime ?? TimeOfDay.now(),
    );
    if (pickedTime != null) {
      setState(() {
        _selectedTime = pickedTime;
        _controller.text = _selectedTime!.format(context);

        if (widget.onTimeSelected != null) {
          widget.onTimeSelected!(_selectedTime!);
        }
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
