import 'package:bitcoin_ticker/ApiService.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bitcoin_ticker/coin_data.dart';
import 'dart:io' show Platform, sleep;

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  int selectedCurrency = 0;
  String selectedCurrencyStr = 'USD';
  String rateBtc = "0";
  String rateEth = "0";
  String rateLTC = "1";

  void getCurrencyExchange() async {
    var api = ApiService();
    this.rateBtc = (await api.getExchangeRate("BTC", selectedCurrencyStr)).toStringAsFixed(2);
    this.rateEth = (await api.getExchangeRate("ETH", selectedCurrencyStr)).toStringAsFixed(2);
    this.rateLTC = (await api.getExchangeRate("LTC", selectedCurrencyStr)).toStringAsFixed(2);
    setState(() {
    });
  }

  Widget iosPicker() {
    List<Widget> currenciesWidgets = [];
    for (var i = 0; i<currenciesList.length; i++) {
      var currency = currenciesList[i];
      if (currency == selectedCurrencyStr){
        selectedCurrency = i;
      }
      currenciesWidgets.add(Text(currency));
    }
    return CupertinoPicker(
        backgroundColor: Colors.lightBlue,
        children: currenciesWidgets,
        itemExtent: 32.0,
        onSelectedItemChanged: (selectedIndex) {
          print(selectedIndex);
          selectedCurrencyStr = currenciesList[selectedIndex];
          print("ios: $selectedCurrencyStr");
          getCurrencyExchange();
        },
    scrollController: FixedExtentScrollController(
      initialItem: selectedCurrency
    ),);

  }

  Widget androidPicker() {
    List<DropdownMenuItem<String>> currenciesWidgets = [];
    for(var currency in currenciesList){
      currenciesWidgets.add(DropdownMenuItem(child: Text(currency), value: currency,));
    }
    return DropdownButton(items: currenciesWidgets, onChanged: (value) {
      setState(() {
        selectedCurrencyStr = value.toString();
      });
      getCurrencyExchange();
    }, value: selectedCurrencyStr);
  }

  @override
  void initState() {
    super.initState();
    getCurrencyExchange();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(child: Column(children: [
            CoinBox(rate: rateBtc, selectedCurrencyStr: selectedCurrencyStr, baseCoin: "BTC"),
            CoinBox(rate: rateEth, selectedCurrencyStr: selectedCurrencyStr, baseCoin: "ETH"),
            CoinBox(rate: rateLTC, selectedCurrencyStr: selectedCurrencyStr, baseCoin: "LTC")
          ],),),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isIOS ? iosPicker() : androidPicker(),
          ),
        ],
      ),
    );
  }
}

class CoinBox extends StatelessWidget {
  const CoinBox({
    super.key,
    required this.rate,
    required this.selectedCurrencyStr,
    required this.baseCoin,
  });

  final String rate;
  final String selectedCurrencyStr;
  final String baseCoin;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
      child: Card(
        color: Colors.lightBlueAccent,
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
          child: Text(
            '1 $baseCoin = $rate $selectedCurrencyStr',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
