import 'package:flutter/material.dart';
import 'package:storemanager/products.dart';
import 'package:storemanager/users.dart';
import 'orders.dart';

class RealtimeDatabaseInsert extends StatefulWidget {
  const RealtimeDatabaseInsert({super.key});

  @override
  State<RealtimeDatabaseInsert> createState() => _RealtimeDatabaseInsertState();
}

class _RealtimeDatabaseInsertState extends State<RealtimeDatabaseInsert> {

  int _selectedTab = 0;

  final List _pages = [const Users(),const Products(), const Orders()];

  _changeTab(int index) {
    setState(() {
      _selectedTab = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedTab,
        onTap: (index) => _changeTab(index),
        selectedItemColor: Color(0xffff6666),
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.supervised_user_circle), label: "Users"),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_bag_rounded), label: "Products"),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart_rounded), label: "Orders"),
        ],
      ),
      body: _pages[_selectedTab]
    );
  }
}
