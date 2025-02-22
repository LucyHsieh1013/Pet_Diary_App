import 'package:flutter/material.dart';

void showCustomDialog(
  BuildContext context,
  String title,
  dynamic body, // 接受 Widget 或 Builder Function
) {
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext dialogContext) {
      return StatefulBuilder(
        builder: (context, setState) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: LayoutBuilder(
              builder: (context, constraints) {
                double maxHeight = MediaQuery.of(context).size.height * 0.8;

                return ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: maxHeight,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // 標題區
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Center(
                              child: Text(
                                title,
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                            ),
                            Positioned(
                              right: 0,
                              child: IconButton(
                                icon: Icon(Icons.close,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .primary),
                                onPressed: () => Navigator.pop(dialogContext),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(color: Theme.of(context).colorScheme.primary),
                      // 內容區
                      Flexible(
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: body is Widget
                                ? body
                                : body(context, setState), // 自動適應 Widget 或 builder
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        },
      );
    },
  );
}
