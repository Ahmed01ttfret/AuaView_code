

import 'package:aqua/First_page/Body.dart';
import 'package:aqua/First_page/NavigationTab.dart';
import 'package:fluent_ui/fluent_ui.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      padding: EdgeInsets.zero,

      content: Container(
        color: Colors.white,
        child: const Row(

          children: [
            NavBar(),
            Expanded(child: Body())
         ],
        ),
      ),
    );
  }
}
