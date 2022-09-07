import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TickData extends StatefulWidget {
  late String name;
  late Map data;

  TickData({super.key, required this.name, required this.data});

  @override
  State<TickData> createState() => TickDataState(name, data);
}

class TickDataState extends State<TickData> {
  String name = "";
  Map data = {};

  TickDataState(this.name, this.data);

  void refresh(String name, Map data) {
    setState(() {
      this.name = name;
      this.data = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(name.toUpperCase(),
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 28,
                    letterSpacing: 0.0,
                    fontWeight: FontWeight.w600)),
            const Spacer(),
            Text(DateFormat('d MMMM y hh:mm a').format(DateTime.now()),
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 10,
                    letterSpacing: 0.0,
                    fontWeight: FontWeight.w400)),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text("OPEN",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.w500)),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text("\$ " + data['open'],
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 22,
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.w500)),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text("HIGH",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.w500)),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text("\$ " + data['high'],
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 22,
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.w500)),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text("LOW",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.w500)),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text("\$ " + data['low'],
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 22,
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.w500)),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text("LAST",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.w500)),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text("\$ " + data['last'],
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 22,
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.w500)),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text("VOLUME",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.w500)),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(data['volume'],
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 22,
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.w500)),
                  ),
                ],
              ),
            ),
          ],
        )
      ],
    );
  }
}
