import 'package:flutter/material.dart';
import 'package:frontend/data/model/destination.dart';
import 'package:frontend/features/layout/bottom_navigation.dart';
import 'package:go_router/go_router.dart';

class LayoutScaffold extends StatefulWidget {
  const LayoutScaffold({required this.navigationShell, Key? key})
    : super(key: key ?? const ValueKey<String>('LayoutScaffold'));

  final StatefulNavigationShell navigationShell;

  @override
  State<LayoutScaffold> createState() => _LayoutScaffoldState();
}

class _LayoutScaffoldState extends State<LayoutScaffold> {
  final List<Destination> destinations = [
    Destination(id: 'home', icon: 'Icons.home', labelKey: 'Trang chủ'),
    Destination(id: 'chat', icon: 'Icons.home', labelKey: 'chat'),
    Destination(id: 'news', icon: 'Icons.home', labelKey: 'Tin tức'),
    Destination(id: 'profile', icon: 'Icons.home', labelKey: 'Cài đặt'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.navigationShell,
      bottomNavigationBar: BottomNavigation(
        widget: widget,
        destination: destinations,
      ),
    );
  }
}
