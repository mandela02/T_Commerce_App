import 'package:flutter/material.dart';
import 'package:t_commerce_app/application/widget/orders/orders_widget.dart';
import 'package:t_commerce_app/application/widget/product/products_widget.dart';
import 'package:t_commerce_app/application/widget/settings/settings_widget.dart';
import 'package:t_commerce_app/domain/model/side_menu_item.dart';

class HomeWidget extends StatefulWidget {
  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  List<SideMenuItem> _managementItems = [
    SideMenuItem("Order", Colors.red, () => OrderWidget()),
    SideMenuItem("Product", Colors.red, () => ProductsWidget())
  ];

  List<SideMenuItem> _settingsItems = [
    SideMenuItem("Settings", Colors.red, () => SettingsWidget()),
  ];

  SideMenuItem _selectedMenuItem;
  String _title;

  @override
  void initState() {
    super.initState();
    _selectedMenuItem = _managementItems.first;
    _title = _selectedMenuItem.title;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        elevation: 0,
        title: Text(
          _title,
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Center(
        child: _getMenuItemWidget(_selectedMenuItem),
      ),
      drawer: Drawer(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              UserAccountsDrawerHeader(
                accountName: Text("HaniPla"),
                accountEmail: Text("10khongquang@gmail.com"),
                currentAccountPicture: new CircleAvatar(
                  backgroundColor: Colors.red,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              getHeader("Management"),
              Column(
                children: _managementItems
                    .map((item) => getCell(context, item: item))
                    .toList(),
              ),
              SizedBox(
                height: 20,
              ),
              getHeader("Settings"),
              Column(
                children: _settingsItems
                    .map((item) => getCell(context, item: item))
                    .toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getCell(BuildContext context, {SideMenuItem item}) {
    return Container(
      decoration: BoxDecoration(
        color: item == _selectedMenuItem ? Colors.grey[300] : Colors.white,
      ),
      child: ListTile(
        leading: Icon(Icons.add),
        title: Text(
          item.title,
          style: TextStyle(
            fontSize: 20,
            color: Colors.black,
          ),
        ),
        onTap: () {
          onMenuClick(item: item);
          Navigator.pop(context);
        },
      ),
    );
  }

  Widget getHeader(String text) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 5, 0, 5),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 15,
          color: Colors.grey[800],
        ),
      ),
    );
  }

  void onMenuClick({SideMenuItem item}) {
    setState(() {
      _selectedMenuItem = item;
      _title = item.title;
    });
  }

  Widget _getMenuItemWidget(SideMenuItem menuItem) {
    return menuItem.func();
  }
}
