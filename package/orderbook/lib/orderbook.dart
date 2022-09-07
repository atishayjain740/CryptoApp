library orderbook;

import 'package:flutter/material.dart';

class OrderBook extends StatefulWidget {
  late List<Map> orders;

  OrderBook({super.key, required this.orders});

  @override
  State<OrderBook> createState() => OrderBookState(orders);
}

class OrderBookState extends State<OrderBook> {
  List<Map> orders = [];

  OrderBookState(this.orders);

  void refresh(List<Map> orders) {
    setState(() {
      this.orders = orders;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3.0,
      child: DataTable(
          horizontalMargin: 10,
          columnSpacing: 0,
          border: TableBorder.all(color: Colors.white, width: 1),
          headingTextStyle: const TextStyle(color: Colors.black, fontSize: 14),
          dataTextStyle: const TextStyle(fontSize: 12, color: Colors.black),
          columns: const <DataColumn>[
            DataColumn(
              label: Expanded(
                child: Center(
                  child: Text(
                    'BID PRICE',
                    style: TextStyle(
                        fontStyle: FontStyle.italic,
                        fontSize: 10,
                        fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            ),
            DataColumn(
              label: Expanded(
                child: Center(
                  child: Text(
                    'QTY',
                    style: TextStyle(
                        fontStyle: FontStyle.italic,
                        fontSize: 10,
                        fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            ),
            DataColumn(
              label: Expanded(
                  child: Center(
                child: Text(
                  'QTY',
                  style: TextStyle(
                      fontStyle: FontStyle.italic,
                      fontSize: 10,
                      fontWeight: FontWeight.w700),
                ),
              )),
            ),
            DataColumn(
              label: Expanded(
                  child: Center(
                child: Text(
                  'ASK PRICE',
                  style: TextStyle(
                      fontStyle: FontStyle.italic,
                      fontSize: 10,
                      fontWeight: FontWeight.w700),
                ),
              )),
            ),
          ],
          rows: orders
              .map((order) => DataRow(cells: [
                    DataCell(Container(
                        //width: 90,
                        padding: const EdgeInsets.all(10),
                        child: Text(order['bidPrice']))),
                    DataCell(Container(
                        //width: 90,
                        padding: const EdgeInsets.all(10),
                        child: Text(order['bidQty']))),
                    DataCell(Container(
                        //width: 90,
                        padding: const EdgeInsets.all(10),
                        child: Text(order['askQty']))),
                    DataCell(Container(
                        //width: 90,
                        padding: const EdgeInsets.all(10),
                        child: Text(order['askPrice']))),
                  ]))
              .toList()),
    );
  }
}
