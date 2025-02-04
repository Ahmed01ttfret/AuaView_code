
import 'dart:ffi';

import 'package:fluent_ui/fluent_ui.dart' as ft;

import 'package:flutter/material.dart';

import '../Settings/Settings_page.dart';
import '../variables.dart';

class NavBar extends StatefulWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  State<NavBar> createState() => _NavBarState();

}

class _NavBarState extends State<NavBar> {
  int _selectedindex=0;
  @override
  Widget build(BuildContext context) {
    return NavigationRail(
      onDestinationSelected: (int index){
        setState(() {
          _selectedindex=index;
         pages.value=index;
        });
      },
      selectedIndex: _selectedindex,
        labelType: NavigationRailLabelType.all,
        elevation: 5,
        backgroundColor: Colors.white,
        trailing: ft.Column(

          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const ft.SizedBox(

              height: 50,
            ),
            IconButton(
              icon: const Icon(Icons.settings,
              size: 30,),
              onPressed: (){
                Navigator.push(
                  context,
                  ft.FluentPageRoute(builder: (context) => SettingsPage()),
                );

              },
            ),
          ],
        ),

        destinations: const <NavigationRailDestination>[
      NavigationRailDestination(icon: Icon(Icons.home_outlined),
          label: Text('Home'),

      selectedIcon: Icon(Icons.home_filled)),
          NavigationRailDestination(icon: Icon(Icons.add),
              label: Text('Import'),

              selectedIcon: Icon(Icons.add)),

          NavigationRailDestination(icon: Icon(Icons.line_axis),
              label: Text('Trends'),

              selectedIcon: Icon(Icons.line_axis_outlined)),

          NavigationRailDestination(icon: Icon(Icons.book_online),
              label: Text('Insight'),

              selectedIcon: Icon(Icons.book_outlined)),

          // NavigationRailDestination(icon: Icon(Icons.mail_outline),
          //     label: Text('Summery'),
          //
          //     selectedIcon: Icon(Icons.mail)),

    ]);
  }
}
