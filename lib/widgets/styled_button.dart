import 'package:flutter/material.dart';

class StyledButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool enabled;

  const StyledButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    // When enabled is false, pass null to onPressed to visually disable the button.
    final callback = enabled ? onPressed : null;

    return ElevatedButton.icon(
      onPressed: callback,
      icon: icon != null ? Icon(icon, size: 18) : const SizedBox.shrink(),
      label: Text(
        label,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
        ),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: enabled ? Colors.teal : Colors.grey, // background
        foregroundColor: Colors.white, // text & icon
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
}
