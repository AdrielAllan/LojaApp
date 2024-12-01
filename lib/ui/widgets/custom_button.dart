import 'package:flutter/material.dart';
import 'package:usanacaixaapp/data/constants/color_constants.dart';

class CustomButton extends StatelessWidget {
  final double? width;
  final double? height;
  final bool isFixedWidth;
  final String? text;
  final Icon? icon;
  final VoidCallback onPressed;
  final bool hasShadow;
  final Color? buttonColor;
  final Gradient? gradient;
  final bool isLoading;
  final bool isPrimary;

  const CustomButton({
    this.width,
    this.height,
    required this.isFixedWidth,
    required this.onPressed,
    this.text,
    this.icon,
    this.hasShadow = false,
    this.buttonColor,
    this.gradient,
    this.isLoading = false,
    this.isPrimary = true, // O padrão é true
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double? buttonWidth = width != null
            ? isFixedWidth
                ? width
                : constraints.maxWidth * width!
            : 0;

        if (isPrimary) {
          // Botão Primário com Gradiente
          return Container(
            width: buttonWidth != 0 ? buttonWidth : null,
            height: height,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(7),
              color: buttonColor,
              gradient: buttonColor == null
                  ? (gradient ?? AppColors.kPrimaryGradientColor)
                  : null,
              boxShadow: hasShadow
                  ? const [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 4,
                        offset: Offset(0, 4),
                      ),
                    ]
                  : null,
            ),
            child: ElevatedButton(
              onPressed: isLoading ? null : onPressed,
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                backgroundColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(7),
                ),
                shadowColor: Colors.transparent,
              ),
              child: _buildButtonContent(),
            ),
          );
        } else {
          // Botão Secundário com Borda (Outlined Button)
          return SizedBox(
            width: buttonWidth != 0 ? buttonWidth : null,
            height: height,
            child: OutlinedButton(
              onPressed: isLoading ? null : onPressed,
              style: OutlinedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                side: BorderSide(
                  color: buttonColor ?? const Color(0xFF87CEEB),
                  width: 2,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(7),
                ),
              ),
              child: _buildButtonContent(isSecondary: true),
            ),
          );
        }
      },
    );
  }

  Widget _buildButtonContent({bool isSecondary = false}) {
    TextStyle textStyle = TextStyle(
      fontSize: 14,
      color: isSecondary
          ? (buttonColor ??
              const Color(0xFF87CEEB)) // Cor do texto no botão secundário
          : Colors.white, // Cor do texto no botão primário
    );

    if (isLoading) {
      return SizedBox(
        height: 24,
        width: 24,
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(
            isSecondary
                ? (buttonColor ?? const Color(0xFF87CEEB))
                : Colors.white,
          ),
          strokeWidth: 2.5,
        ),
      );
    } else if (text != null || icon != null) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (icon != null) icon!,
          const SizedBox(
            width: 5,
          ),
          if (text != null)
            Text(
              text!,
              style: textStyle,
            ),
        ],
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}
