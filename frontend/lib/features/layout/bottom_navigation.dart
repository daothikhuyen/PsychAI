import 'package:flutter/material.dart';
import 'package:frontend/data/model/destination.dart';
import 'package:frontend/features/layout/layout_scaffold.dart';
import 'package:google_fonts/google_fonts.dart';

class BottomNavigation extends StatelessWidget {
  const BottomNavigation({
    required this.widget,
    required this.destination,
    super.key,
  });

  final LayoutScaffold widget;
  final List<Destination> destination;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Color(0xFFC1C7CF),
            offset: Offset(0, -5),
            blurRadius: 60,
          ),
        ],
      ),
      child: NavigationBarTheme(
        data: NavigationBarThemeData(
          labelTextStyle: WidgetStateTextStyle.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return GoogleFonts.jost().copyWith(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF2853af),
              );
            }
            return GoogleFonts.jost().copyWith(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF2853af),
            );
          }),
        ),
        child: NavigationBar(
          selectedIndex: widget.navigationShell.currentIndex,
          indicatorColor: Colors.transparent,
          onDestinationSelected: widget.navigationShell.goBranch,
          destinations:
              destination.map((e) {
                return NavigationDestination(
                  icon: const Icon(Icons.home_outlined),
                  selectedIcon: const Icon(Icons.home),
                  label: e.labelKey,
                );
              }).toList(),
        ),
      ),
    );
  }
}
