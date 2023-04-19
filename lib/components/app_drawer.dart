import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  Widget tile(
      BuildContext context, IconData iconData, String title, String route) {
    return ListTile(
      leading: Icon(iconData),
      title: Text(title),
      onTap: () {
        Navigator.of(context).pushReplacementNamed(route);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            title: const Text('Hello!'),
            automaticallyImplyLeading: false,
          ),
          tile(context, Icons.home, 'Home', "home"),
          tile(context, Icons.select_all_sharp, 'View My Orders', 'order'),

          tile(context, Icons.logout, 'Log out', 'login'),

          //tile(context, Icons.payment, 'My Products', UserProductsScreen.ROUTE),
        ],
      ),
    );
  }
}
