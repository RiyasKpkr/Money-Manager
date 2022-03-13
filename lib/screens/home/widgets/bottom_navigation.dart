import 'package:flutter/material.dart';
import 'package:money_managment/screens/home/screen_home.dart';

class MoneyManagerBottomNavigation extends StatelessWidget {
  const MoneyManagerBottomNavigation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: ScreenHome.selectedIndexNotifies,
      builder: (BuildContext context, int updatedIndex, Widget? _) {
        return BottomNavigationBar(
          // backgroundColor: Colors.black,
          selectedItemColor: Colors.purple,
          unselectedItemColor: Colors.grey,
          currentIndex: updatedIndex,
          onTap: (newIndex) {
            ScreenHome.selectedIndexNotifies.value = newIndex;
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Transactions',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.category),
              label: 'Categories',
            ),
          ],
        );
      },
    );
  }
}
