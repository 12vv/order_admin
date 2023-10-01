import 'package:flutter/material.dart';

const qrcodeApi =
    'https://api.qrserver.com/v1/create-qr-code/?size=250x250&data=';
const orderWebDomain = 'https://ordering-uat.sum-foods.com';

String createQrcodeUrl(String text) {
  return "$qrcodeApi$text";
}

String createOrderingUrl(String restaurantId, String tableId) {
  return createQrcodeUrl("$orderWebDomain/order/$restaurantId/$tableId");
}

class OrderingQrcodePage extends StatefulWidget {
  final String restaurantId;
  final String tableId;
  const OrderingQrcodePage(this.restaurantId, this.tableId, {super.key});

  @override
  // ignore: no_logic_in_create_state
  State<StatefulWidget> createState() =>
      _OrderingQrcodePageState(restaurantId, tableId);
}

class _OrderingQrcodePageState extends State<OrderingQrcodePage> {
  final String restaurantId;
  final String tableId;
  _OrderingQrcodePageState(this.restaurantId, this.tableId);
  @override
  Widget build(BuildContext context) {
    final url = createOrderingUrl(restaurantId, tableId);
    return Scaffold(
      appBar: AppBar(title: const Text('桌號二維碼')),
      body: Column(
        children: [
          Expanded(
              child: Center(
                  child: Image.network(
            url,
            loadingBuilder: (BuildContext context, Widget child,
                ImageChunkEvent? loadingProgress) {
              if (loadingProgress == null) {
                return child;
              }
              return Center(
                child: CircularProgressIndicator(
                  value: loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded /
                          loadingProgress.expectedTotalBytes!
                      : null,
                ),
              );
            },
          ))),
          ElevatedButton(
            onPressed: () {},
            child: const Text('下載'),
          )
        ],
      ),
    );
  }
}