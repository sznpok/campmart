import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../utils/theme.dart';
import '../bloc/bottom_nav_bar_bloc/home_page_bloc.dart';

class BottomNavBarScreen extends StatefulWidget {
  const BottomNavBarScreen({
    super.key,
  });

  @override
  State<BottomNavBarScreen> createState() => _BottomNavBarScreenState();
}

class _BottomNavBarScreenState extends State<BottomNavBarScreen> {
  int _selectedIndex = 0;
  DateTime? backButtonPressTime;

  @override
  void initState() {
    _selectedIndex = 0;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: BlocBuilder<HomePageBloc, HomePageState>(
        builder: (context, state) {
          switch (state) {
            case Page1():
              return Container();
            case Page2():
              return Container();
            case Page3():
              return Container();
            case Page4():
              return Container();
            default:
              return const SizedBox();
          }
        },
      ),
      bottomNavigationBar: Container(
        height: Platform.isAndroid ? 60 : null,
        margin: Platform.isAndroid
            ? const EdgeInsets.only(
                left: 20,
                bottom: 20,
                right: 20,
              )
            : null,
        decoration: ShapeDecoration(
          color: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          shadows: const [
            BoxShadow(
              color: Color(0x3F000000),
              blurRadius: 2,
              offset: Offset(0, 2),
              spreadRadius: 0,
            )
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: BottomNavigationBar(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            showSelectedLabels: true,
            unselectedItemColor: shadowColor,
            showUnselectedLabels: false,
            selectedItemColor: primaryColor,
            currentIndex: _selectedIndex,
            onTap: (currentIndex) {
              _selectedIndex = currentIndex;
              context
                  .read<HomePageBloc>()
                  .add(HomePageClickEvent(id: _selectedIndex));
              log('Current Index: $_selectedIndex');
              (context as Element).markNeedsBuild();
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                label: "home",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.campaign),
                label: "CampMart",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.bookmark),
                label: "History",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: "Me",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
