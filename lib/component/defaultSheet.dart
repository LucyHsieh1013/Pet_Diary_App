//彈出視窗(主題變更、語言變更、日記-每日紀錄)
import 'package:flutter/material.dart';

void showCustomDialog(BuildContext context, String title, Widget body) {
  showDialog(
    context: context,
    barrierDismissible: true, // 點擊外部可以關閉
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: LayoutBuilder(
          builder: (context, constraints) {
            double maxHeight = MediaQuery.of(context).size.height * 0.8; // 最大高度 80%

            return ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: maxHeight, // 限制最大高度
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min, // 讓 Dialog 根據內容變動
                children: [
                  // 標題區
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Center( // 標題置中
                          child: Text(
                            title,
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                        ),
                        Positioned( // 右上角的關閉按鈕
                          right: 0,
                          child: IconButton(
                            icon: Icon(Icons.close, color: Theme.of(context).colorScheme.primary),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(color: Theme.of(context).colorScheme.primary),
                  // 內容區 (超過最大高度才滾動)
                  Flexible(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: body,
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
}
