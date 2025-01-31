// Menu

import 'package:flutter/material.dart';

class Menu extends StatelessWidget {
  final String activeItem;
  final Function(String) onItemPressed;

  const Menu({
    super.key,
    required this.activeItem,
    required this.onItemPressed,
  });

  @override
  Widget build(BuildContext context) {
    return _menuItem(
      title: 'Voltar',
      isActive: activeItem == 'Voltar',
      onTap: () => onItemPressed('Voltar'),
    );
  }

  Widget _menuItem({
    required String title,
    required bool isActive,
    required VoidCallback onTap,
  }) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          child: Column(
            children: [
              Text(
                title,
              ),
              const SizedBox(
                height: 6,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
