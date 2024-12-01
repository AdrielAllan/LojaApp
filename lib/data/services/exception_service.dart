import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ExceptionService {
  static void showErrorNotification(BuildContext context, String message) {
    showNotification(context, message, "oh_snap".tr(), "assets/icons/failure.svg", const Color(0xFFCA2B42));
  }

  static void showSuccessNotification(BuildContext context, String message) {
    showNotification(context, message, "well_done".tr(), "assets/icons/success.svg", const Color(0xFF4D8D7C));
  }

  static void showWarningNotification(BuildContext context, String message) {
    showNotification(context, message, "heads_up".tr(), "assets/icons/warning.svg", const Color(0xFFFA483E));
  }

  // Método para exibir notificação de erro como SnackBar
  static void showNotification(
    BuildContext context,
    String message,
    String title,
    String iconPath,
    Color color,
  ) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Stack(children: [
        Container(
          padding: const EdgeInsets.all(16),
          height: 95,
          decoration: BoxDecoration(color: color, borderRadius: const BorderRadius.all(Radius.circular(20))),
          child: Row(children: [
            SvgPicture.asset(
              iconPath,
              height: 60,
            ),
            const SizedBox(
              width: 20,
            ),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontSize: 18, color: Colors.white),
                ),
                const Spacer(),
                SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight: 60, // Limita a altura máxima do texto.
                    ),
                    child: Text(
                      message,
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                )
              ],
            )),
          ]),
        ),
      ]),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      elevation: 0,
    ));
  }

  // Método para exibir notificação de erro como AlertDialog
  static void showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('alert'.tr()),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Fecha o diálogo
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  static void confirmDeleteDialog(BuildContext context, {required Future<void> Function() function}) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('delete').tr(),
        content: const Text('confirm_delete_event').tr(),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context), // Fecha o diálogo
            child: const Text('cancel').tr(),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context); // Fecha o diálogo
              await function(); // Chama o método para deletar o evento
            },
            child: const Text(
              'delete',
              style: TextStyle(color: Colors.red),
            ).tr(),
          ),
        ],
      ),
    );
  }
}
