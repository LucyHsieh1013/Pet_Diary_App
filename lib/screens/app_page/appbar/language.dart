import 'package:flutter/material.dart';
import 'package:test_app/screens/component/defaultSheet.dart';

enum Language { traditionalChinese, simplifiedChinese, english }

void LanguageSheet(BuildContext context) {
  showCustomDialog(
    context,
    "語言變更",
    StatefulBuilder(
      builder: (context, setState) {
        Language? _language = Language.traditionalChinese; // 在 StatefulBuilder 內定義

        return Column(
          mainAxisSize: MainAxisSize.min, // 讓彈窗高度自適應
          children: [
            Wrap(
              spacing: 8,
              children: [
                RadioListTile<Language>(
                  title: const Text('繁體中文'),
                  value: Language.traditionalChinese,
                  groupValue: _language,
                  onChanged: (Language? value) {
                    setState(() {
                      _language = value; // 正確更新狀態
                    });
                  },
                ),
                RadioListTile<Language>(
                  title: const Text('简体中文'),
                  value: Language.simplifiedChinese,
                  groupValue: _language,
                  onChanged: (Language? value) {
                    setState(() {
                      _language = value;
                    });
                  },
                ),
                RadioListTile<Language>(
                  title: const Text('English'),
                  value: Language.english,
                  groupValue: _language,
                  onChanged: (Language? value) {
                    setState(() {
                      _language = value;
                    });
                  },
                ),
              ],
            ),
          ],
        );
      },
    ),
  );
}
