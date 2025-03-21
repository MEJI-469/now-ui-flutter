import 'package:flutter/material.dart';

import 'package:now_ui_flutter/constants/Theme.dart';

class TableCellSettings extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  const TableCellSettings({Key? key, required this.title, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(top: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: TextStyle(color: NowUIColors.text)),
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Icon(Icons.arrow_forward_ios,
                  color: NowUIColors.text, size: 14),
            )
          ],
        ),
      ),
    );
  }
}
