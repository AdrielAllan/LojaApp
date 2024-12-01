import 'package:flutter/material.dart';

class RectangularCard extends StatelessWidget {
  const RectangularCard({
    super.key,
    required this.title,
    required this.value,
    this.color,
    this.gradient,
  });

  final String title;
  final String value;
  final Color? color; // Cor sólida opcional
  final Gradient? gradient; // Gradiente opcional

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: AspectRatio(
        aspectRatio: 2 / 1, // Define largura:altura como 2:1
        child: Container(
          decoration: BoxDecoration(
            color: gradient == null ? (color ?? Colors.red) : null, // Usa cor se gradiente for nulo
            gradient: gradient, // Usa gradiente se fornecido
            borderRadius: BorderRadius.circular(8),
          ),
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                  maxLines: 1,
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      value,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 25,
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
