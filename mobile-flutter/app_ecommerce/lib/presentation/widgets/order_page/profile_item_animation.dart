// lib/presentation/widgets/profile_page/animated_profile_item_tile.dart
import '../profile_page/profile_item_title.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AnimatedProfileItemTile extends StatefulWidget {
  final IconData icon;
  final String label;
  final String routeName;

  const AnimatedProfileItemTile({
    required this.icon,
    required this.label,
    required this.routeName,
    super.key,
  });

  @override
  _AnimatedProfileItemTileState createState() =>
      _AnimatedProfileItemTileState();
}

class _AnimatedProfileItemTileState extends State<AnimatedProfileItemTile>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _scaleAnim;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
      lowerBound: 0.95,
      upperBound: 1.0,
      value: 1.0,
    );
    _scaleAnim = _ctrl.drive(Tween(begin: 1.0, end: 0.95));
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  Future<void> _handleTap() async {
    // anima para “pressionado”
    await _ctrl.reverse();
    // retorna ao tamanho normal
    await _ctrl.forward();
    // aí sim navega
    Get.toNamed(widget.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scaleAnim,
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: _handleTap,
        child: ProfileItemTile(icon: widget.icon, label: widget.label),
      ),
    );
  }
}
