import 'package:flutter/material.dart';

extension SemanticsX on Widget {
  Widget withSemantics({
    required String label,
    String? hint,
    bool isButton = false,
  }) {
    return Semantics(label: label, hint: hint, button: isButton, child: this);
  }
}
