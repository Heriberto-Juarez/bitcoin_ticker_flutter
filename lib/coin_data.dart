import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

class CoinData {

  getListWidgets(){
    List<DropdownMenuItem<String>> currenciesWidgets = [];
    for(var currency in currenciesList){
      currenciesWidgets.add(DropdownMenuItem(child: Text(currency), value: currency,));
    }
    return currenciesWidgets;
  }

}
