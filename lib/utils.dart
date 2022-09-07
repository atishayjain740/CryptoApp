import 'dart:convert';
import 'package:http/http.dart' as http;

class Utils {
  static var loadDataUrl = 'https://www.bitstamp.net/api/v2/ticker/';
  static var loadOrderBookUrl = 'https://www.bitstamp.net/api/v2/order_book/';

  static Future<Map> getData(String data) async {
    try {
      String url = loadDataUrl + data;

      final response = await http.get(
        Uri.parse(url),
      );

      //print(response.body);
      var responseData = json.decode(response.body);

      return {'success': true, 'data': responseData};
    } catch (err) {
      //print(err.toString());
      return {"success": false, "message": err.toString()};
    }
  }

  static Future<Map> getOrderBook(String data) async {
    try {
      String url = loadOrderBookUrl + data;

      final response = await http.get(
        Uri.parse(url),
      );

      //print(response.body);
      var responseData = json.decode(response.body);

      return {'success': true, 'data': responseData};
    } catch (err) {
      //print(err.toString());
      return {"success": false, "message": err.toString()};
    }
  }
}
