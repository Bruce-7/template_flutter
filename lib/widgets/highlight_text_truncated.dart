import 'package:flutter/material.dart';

class HighlightTextTruncated extends StatelessWidget {
  final String text;
  final String keyword;
  final TextStyle? normalStyle;
  final TextStyle? highlightStyle;
  final int contextLength;

  const HighlightTextTruncated({
    super.key,
    required this.text,
    required this.keyword,
    this.normalStyle,
    this.highlightStyle,
    this.contextLength = 20,
  });

  String _getTruncatedText() {
    if (keyword.isEmpty || text.isEmpty) {
      return text;
    }

    final lowerText = text.toLowerCase();
    final lowerKeyword = keyword.toLowerCase();
    final index = lowerText.indexOf(lowerKeyword);

    if (index == -1) {
      return text;
    }

    final start = (index - contextLength).clamp(0, text.length);
    final end = (index + keyword.length + contextLength).clamp(0, text.length);

    final prefix = start > 0 ? '...' : '';
    final suffix = end < text.length ? '...' : '';

    return '$prefix${text.substring(start, end)}$suffix';
  }

  @override
  Widget build(BuildContext context) {
    final truncatedText = _getTruncatedText();

    if (keyword.isEmpty) {
      return Text(truncatedText, style: normalStyle);
    }

    final pattern = RegExp(RegExp.escape(keyword), caseSensitive: false);
    final spans = <TextSpan>[];

    truncatedText.splitMapJoin(
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
