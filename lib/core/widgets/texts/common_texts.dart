// lib/core/presentation/widgets/common_text_widgets.dart

import 'package:flutter/material.dart';
import 'package:flutter_practical_test/core/widgets/texts/text_styles.dart';

class Texts {
  static Widget heading1(String text, {TextStyle? style}) {
    return Text(
      text,
      style: style ?? AppTextStyles.heading1,
    );
  }

  static Widget heading2(String text, {TextStyle? style}) {
    return Text(
      text,
      style: style ?? AppTextStyles.heading2,
    );
  }

  static Widget subheading(String text, {TextStyle? style}) {
    return Text(
      text,
      style: style ?? AppTextStyles.subheading,
    );
  }

  static Widget subheading2(String text, {TextStyle? style}) {
    return Text(
      text,
      style: style ?? AppTextStyles.subheading2,
    );
  }

  static Widget bodyText(String text, {TextStyle? style}) {
    return Text(
      text,
      style: style ?? AppTextStyles.bodyText,
    );
  }

  static Widget caption(String text, {TextStyle? style}) {
    return Text(
      text,
      style: style ?? AppTextStyles.caption,
    );
  }

  static Widget caption2(String text, {TextStyle? style}) {
    return Text(
      text,
      style: style ?? AppTextStyles.caption2,
    );
  }

  static Widget button(String text, {TextStyle? style}) {
    return Text(
      text,
      style: style ?? AppTextStyles.button,
    );
  }
}
