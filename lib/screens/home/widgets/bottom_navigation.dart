import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:money_managment/screens/home/screen_home.dart';

class MoneyManagerBottomNavigation extends StatelessWidget {
  const MoneyManagerBottomNavigation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: ScreenHome.selectedIndexNotifies,
      builder: (BuildContext context, int updatedIndex, Widget? _) {
        return CurvedNavigationBar(
          height: 50,
          backgroundColor: Colors.black,
          color: Colors.amber,
          index: updatedIndex,
          animationDuration: Duration(milliseconds: 300),
          onTap: (newIndex) {
            ScreenHome.selectedIndexNotifies.value = newIndex;
          },
          items: const [
            Icon(
              Icons.home,
              semanticLabel: 'Transactions',
              color: Colors.black,
              size: 30,
            ),
            Icon(
              Icons.category,
              semanticLabel: 'Categories',
              color: Colors.black,
              size: 30,
            ),
          ],
        );
      },
    );
  }
}
