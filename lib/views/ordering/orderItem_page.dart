import 'package:flutter/material.dart';
import 'package:order_admin/provider/selected_table_provider.dart';
import 'package:provider/provider.dart';
import '../cookie_page.dart';
import 'package:order_admin/createItemPage.dart';
import 'package:order_admin/provider/restaurant_provider.dart';
import 'package:order_admin/provider/selected_table_provider.dart';
import 'package:order_admin/views/components/navbar.dart';
import 'item_list.dart';
import 'dart:math';
import 'shopping_cart.dart';

class OrderItem extends StatefulWidget {
  OrderItem({super.key});
  final List<String> _tabs = [];
  List shoppingList = [];
  int tabListLength = 0;

  @override
  _OrderItemState createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> with TickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final restaurant = context.watch<RestaurantProvider>();
    _tabController =
        TabController(length: restaurant.itemsMap.keys.length + 1, vsync: this);

    return Row(
      children: [
        const SizedBox(
          width: 200,
          child: NavBar(),
        ),
        Expanded(
            child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0.0,
            centerTitle: true,
            // leading: IconButton(
            //   icon: const Icon(Icons.arrow_back, color: Color(0xFF545D68)),
            //   onPressed: () {},
            // ),
            title: const Text('點餐',
                style: TextStyle(fontSize: 20.0, color: Color(0xFF545D68))),
          ),
          body: ListView(
            padding: const EdgeInsets.only(left: 20.0),
            children: <Widget>[
              SizedBox(height: 15.0),
              Text(
                  '餐廳名稱：${context.read<RestaurantProvider>().name}。餐桌號：${context.read<SelectedTableProvider>().selectedTable?.label}'),
              Row(
                children: [
                  Expanded(
                      flex: 8,
                      child: TabBar(
                          controller: _tabController,
                          indicatorColor: Colors.transparent,
                          labelColor: Color(0xFFC88D67),
                          isScrollable: true,
                          labelPadding: EdgeInsets.only(right: 45.0),
                          unselectedLabelColor: Color(0xFFCDCDCD),
                          tabs: [
                            Tab(
                              child: Text('所有品項',
                                  style: TextStyle(
                                    fontSize: 18.0,
                                  )),
                            ),
                            ...restaurant.itemsMap.keys.map(
                              (label) => Tab(
                                child: Text(label,
                                    style: TextStyle(
                                      fontSize: 18.0,
                                    )),
                              ),
                            )
                          ])),
                ],
              ),
              Container(
                  height: MediaQuery.of(context).size.height,
                  // width: double.infinity,
                  child: TabBarView(controller: _tabController, children: [
                    ItemListView(itemList: restaurant.items),
                    ...restaurant.itemsMap.keys.map(
                      (label) => ItemListView(
                          itemList: restaurant.itemsMap[label]?.toList()),
                    )
                  ]))
            ],
          ),
          // bottomNavigationBar: BottomBar(),
        )),
        SizedBox(
          height: MediaQuery.of(context).size.height,
          child: const VerticalDivider(),
        ),
        SizedBox(width: 420, child: ShoppingCart()),
      ],
    );
  }
}