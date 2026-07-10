import 'package:flutter/material.dart';

class HighlightText extends StatelessWidget {
  final String text;
  final String? keyword;
  final TextStyle? normalStyle;
  final TextStyle? highlightStyle;

  const HighlightText({
    super.key,
    required this.text,
    this.keyword,
    this.normalStyle,
    this.highlightStyle,
  });

  @override
  Widget build(BuildContext context) {
    if (keyword == null || keyword?.isEmpty == true) {
      return Text(text, style: normalStyle);
    }

    // 不区分大小写匹配
    final pattern = RegExp(RegExp.escape(keyword!), caseSensitive: false);
    final spans = <TextSpan>[];

    text.splitMapJoin(
      pattern,
      onMatch: (m) {
        spans.add(
          TextSpan(
            text: m[0],
            style: highlightStyle,
          ),
        );
        return '';
      },
      onNonMatch: (n) {
        spans.add(
          TextSpan(
            text: n,
            style: normalStyle,
          ),
        );
        return '';
      },
    );

    return RichText(text: TextSpan(children: spans));
  }
}
