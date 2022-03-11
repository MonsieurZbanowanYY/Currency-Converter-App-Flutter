import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sobgog_currency_converter/data/default_values.dart';
import 'package:sobgog_currency_converter/util/api_calls.dart';
import 'package:sobgog_currency_converter/widgets/appbar_widget.dart';
import 'package:sobgog_currency_converter/widgets/buttons_grid.dart';
import 'package:sobgog_currency_converter/widgets/currency_pickers.dart';
import 'package:sobgog_currency_converter/widgets/value_counter.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    getRatesFromApi();
    super.initState();
  }

  Map currencyData = {};
  getRatesFromApi() async {
    selectedPrice.value = 0.00;
    Response response = await ApiCalls().getRates(selectedFrom.value);
    currencyData = response.body;
    selectedPrice.value =
        double.parse(currencyData['data'][selectedTo]['value'].toString());
  }

  RxString selectedFrom = 'EUR'.obs;
  RxString selectedTo = 'PLN'.obs;
  RxString ammount = '1'.obs;
  RxDouble selectedPrice = 0.00.obs;

  void changeSelected(bool isFrom, String currency) {
    if (isFrom && selectedFrom.value != currency) {
      selectedFrom.value = currency;
      getRatesFromApi();
    } else if (!isFrom) {
      selectedTo.value = currency;
      selectedPrice.value =
          double.parse(currencyData['data'][selectedTo]['value'].toString());
    }
  }

  void switchCurrencies() {
    String selectedFromTemp = selectedFrom.value;
    selectedFrom.value = selectedTo.value;
    selectedTo.value = selectedFromTemp;
    getRatesFromApi();
  }

  void backspace() {
    if (ammount.value.isNotEmpty) {
      ammount.value = ammount.value.substring(0, ammount.value.length - 1);
    }
  }

  void changeAmmount(String value) {
    int index = ammount.value.indexOf(',');
    if (value == '0' && ammount.value == '0') {
    } else if (ammount.value == '0' && value != ',') {
      ammount.value = value;
    } else if (ammount.value.isEmpty && value == ',') {
      ammount.value = '0,';
    } else if (!ammount.value.contains(',') &&
        value == ',' &&
        ammount.value.isNotEmpty) {
      ammount.value = '${ammount.value}$value';
    } else if (value != '' &&
        ammount.value.contains(',') &&
        ammount.value.length - index < 3) {
      ammount.value = '${ammount.value}$value';
    } else if (value != ',' && !ammount.value.contains(',')) {
      ammount.value = '${ammount.value}$value';
    }
  }

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return Scaffold(
      backgroundColor: themeData.backgroundColor,
      appBar: appbarWidget(themeData),
      body: SafeArea(
        child: Padding(
          padding: paddingV1,
          child: ListView(
            physics: const ClampingScrollPhysics(),
            children: [
              currencyPickers(selectedFrom, selectedTo, switchCurrencies,
                  changeSelected, themeData),
              valueCounter(
                  ammount, selectedFrom, selectedTo, selectedPrice, themeData),
              buttonsGrid(changeAmmount, backspace, themeData),
            ],
          ),
        ),
      ),
    );
  }
}
