import 'package:flutter/material.dart';

class ConfirmationDialog {
  static Future<void> show({
    required BuildContext context,
    required String title,
    required String message,
    required VoidCallback onConfirm,
    VoidCallback? onCancel,
  }) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          actionsAlignment: MainAxisAlignment.spaceBetween,
          actions: [
            // Botão de Cancelar
            SizedBox(
              width: 120, // Define largura consistente para os botões
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Fecha o diálogo
                  if (onCancel != null) onCancel();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey, // Cor do botão
                  foregroundColor: Colors.white, // Cor do texto
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text("Cancelar"),
              ),
            ),
            // Botão de Confirmar
            SizedBox(
              width: 120, // Define largura consistente para os botões
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Fecha o diálogo
                  onConfirm();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green, // Cor do botão
                  foregroundColor: Colors.white, // Cor do texto
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text("Confirmar"),
              ),
            ),
          ],
        );
      },
    );
  }
}
