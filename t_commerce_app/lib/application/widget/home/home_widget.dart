import 'package:flutter/material.dart';
import 'package:t_commerce_app/application/app/app_router.dart';
import 'package:t_commerce_app/application/widget/category_list/notifier_category_list_widget.dart';
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
    SideMenuItem(title: "Order", color: Colors.red, content: OrderWidget()),
    SideMenuItem(
        title: "Product", color: Colors.blue, content: ProductsWidget()),
    SideMenuItem(
        title: "Category",
        color: Colors.pink,
        content: NotifierCategoryListWidget()),
  ];

  List<SideMenuItem> _settingsItems = [
    SideMenuItem(
        title: "Settings", color: Colors.deepPurple, content: SettingsWidget()),
  ];

  late SideMenuItem _selectedMenuItem;

  @override
  void initState() {
    super.initState();
    _selectedMenuItem = _managementItems.first;
  }

  Widget? get _rightAppBarButton {
    if (_selectedMenuItem.title == "Category") {
      return IconButton(
          icon: Icon(Icons.add),
          onPressed: () {
            Navigator.pushNamed(context, AppRouter.CATEGORY);
          });
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: _selectedMenuItem.color,
        elevation: 0,
        title: Text(
          _selectedMenuItem.title,
          style: TextStyle(color: Colors.white),
        ),
        actions: getAllActionButtons(),
      ),
      body: Center(
        child: _selectedMenuItem.content,
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
                decoration: BoxDecoration(
                  color: Colors.indigo,
                ),
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

  Widget getCell(BuildContext context, {required SideMenuItem item}) {
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

  void onMenuClick({required SideMenuItem item}) {
    setState(() {
      _selectedMenuItem = item;
    });
  }

  Widget _getMenuItemWidget(SideMenuItem menuItem) {
    return menuItem.content;
  }

  List<Widget> getAllActionButtons() {
    if (_rightAppBarButton != null) {
      return [_rightAppBarButton!];
    } else {
      return [];
    }
  }
}
