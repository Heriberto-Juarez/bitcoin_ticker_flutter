import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiService {

  String baseURL = "https://rest.coinapi.io/v1/exchangerate";

  getApiKey(){
    return dotenv.env['COIN_API_KEY'];
  }

  Map<String,String> getHeaders(){
    Map<String, String> requestHeaders = {
      "X-CoinAPI-Key": this.getApiKey(),
    };
    return requestHeaders;
  }

  Future<double> getExchangeRate(String cryptoCoin, String fiatCoin) async {
    var url = "$baseURL/$cryptoCoin/$fiatCoin";
    print(url);
    var response = await http.get(Uri.parse(url), headers: getHeaders());
    if (response.statusCode == 200){
      var result = jsonDecode(response.body);
      return result["rate"];
    }else{
      print(response.statusCode);
      throw "Unable to fetch exchange rate";
    }
  }
}