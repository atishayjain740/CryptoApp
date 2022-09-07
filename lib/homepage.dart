import 'package:crypto_app/components/tickdata.dart';
import 'package:crypto_app/cryptopairservice.dart';
import 'package:crypto_app/utils.dart';
import 'package:flutter/material.dart';
import 'package:orderbook/orderbook.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _typeAheadController = TextEditingController();
  late String _selectedCryptoPair = '';
  late Map _selectedCryptoPairData = {};
  late List<Map> _selectedCryptoOrderBook = [];
  final GlobalKey<TickDataState> _tickDatakey = GlobalKey();
  final GlobalKey<OrderBookState> _orderBookkey = GlobalKey();
  bool _showOrderBook = false;
  bool _orderBookLoading = false;

  Future<void> loadData() async {
    await loadTickData();
    if (_showOrderBook) {
      await loadOrderBook();
    }
  }

  Future<void> loadTickData() async {
    Map responseTickData = await Utils.getData(_selectedCryptoPair);

    if (responseTickData['success']) {
      setState(() {
        _selectedCryptoPairData = responseTickData['data'];
      });
      if (_tickDatakey.currentState != null) {
        _tickDatakey.currentState!
            .refresh(_selectedCryptoPair, _selectedCryptoPairData);
      }
    } else {
      setState(() {
        _selectedCryptoPairData = {};
      });
    }
  }

  Future<void> loadOrderBook() async {
    setState(() {
      _orderBookLoading = true;
    });

    Map responseOrderBook = await Utils.getOrderBook(_selectedCryptoPair);
    if (responseOrderBook['success']) {
      List<Map> top5Orders = generateTop5Orders(responseOrderBook['data']);
      setState(() {
        _selectedCryptoOrderBook = top5Orders;
        _orderBookLoading = false;
      });
      if (_orderBookkey.currentState != null) {
        _orderBookkey.currentState!.refresh(top5Orders);
      }
    } else {
      setState(() {
        _selectedCryptoOrderBook = [];
        _orderBookLoading = false;
      });
    }
  }

  List<Map> generateTop5Orders(Map orderBook) {
    List<Map> orders = [];
    for (int i = 0; i < 5; i++) {
      Map order = {};
      order['bidPrice'] = orderBook['bids'][i][0];
      order['bidQty'] = orderBook['bids'][i][1];
      order['askPrice'] = orderBook['asks'][i][0];
      order['askQty'] = orderBook['asks'][i][1];
      orders.add(order);
    }

    return orders;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Container(
          color: Colors.white,
          margin: MediaQuery.of(context).padding,
          padding: const EdgeInsets.all(20),
          alignment: Alignment.topCenter,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                TypeAheadFormField(
                  noItemsFoundBuilder: (context) => const SizedBox(
                    height: 50,
                    child: Center(
                      child: Text('No Item Found'),
                    ),
                  ),
                  suggestionsBoxDecoration: const SuggestionsBoxDecoration(
                    color: Colors.white,
                    elevation: 4.0,
                  ),
                  debounceDuration: const Duration(milliseconds: 400),
                  textFieldConfiguration: TextFieldConfiguration(
                      controller: this._typeAheadController,
                      decoration: InputDecoration(
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black)),
                          hintText: "Enter currency pair",
                          contentPadding:
                              const EdgeInsets.only(top: 4, left: 10),
                          hintStyle:
                              const TextStyle(color: Colors.grey, fontSize: 14),
                          suffixIcon: IconButton(
                              onPressed: () async {
                                if (_selectedCryptoPair != '') {
                                  await loadData();
                                }
                              },
                              icon:
                                  const Icon(Icons.search, color: Colors.grey)),
                          fillColor: Colors.white,
                          filled: true)),
                  suggestionsCallback: (pattern) {
                    return CryptoPairService.getSuggestions(pattern);
                  },
                  itemBuilder: (context, suggestion) {
                    return ListTile(
                      title: Text(suggestion),
                    );
                  },
                  transitionBuilder: (context, suggestionsBox, controller) {
                    return suggestionsBox;
                  },
                  onSuggestionSelected: (suggestion) {
                    this._typeAheadController.text = suggestion;
                    setState(() {
                      _selectedCryptoPair = suggestion;
                    });
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please select crypto pair';
                    }
                  },
                  onSaved: (value) => this._selectedCryptoPair = value!,
                ),
                const SizedBox(
                  height: 30,
                ),
                _selectedCryptoPairData.isEmpty
                    ? Column(
                        children: const [
                          Icon(
                            Icons.search,
                            size: 200,
                            color: Colors.grey,
                          ),
                          Text("Enter a currency pair to load data."),
                        ],
                      )
                    : Column(
                        children: [
                          TickData(
                            key: _tickDatakey,
                            name: _selectedCryptoPair,
                            data: _selectedCryptoPairData,
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            children: [
                              const Spacer(),
                              TextButton(
                                onPressed: () async {
                                  setState(() {
                                    _showOrderBook = !_showOrderBook;
                                  });
                                  if (_showOrderBook) {
                                    await loadOrderBook();
                                  }
                                },
                                child: Text(
                                  (_showOrderBook)
                                      ? "HIDE ORDER BOOK"
                                      : "SHOW ORDER BOOK",
                                  style: const TextStyle(
                                      fontSize: 14,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.purple),
                                ),
                              ),
                            ],
                          ),
                          Visibility(
                            visible: _showOrderBook,
                            child: (_orderBookLoading)
                                ? const CircularProgressIndicator(
                                    color: Colors.purple,
                                  )
                                : OrderBook(
                                    key: _orderBookkey,
                                    orders: _selectedCryptoOrderBook,
                                  ),
                          )
                        ],
                      ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            if (_selectedCryptoPair != '') {
              await loadData();
            }
          },
          tooltip: 'Refresh',
          backgroundColor: Colors.purple,
          child: const Icon(Icons.refresh),
        ),
      ),
    );
  }
}
